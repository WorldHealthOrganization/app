/**
    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
*/

var fs = require('fs');
var path = require('path');
var shell = require('shelljs');
var CordovaError = require('cordova-common').CordovaError;
var events = require('cordova-common').events;
var FileUpdater = require('cordova-common').FileUpdater;

function dirExists (dir) {
    return fs.existsSync(dir) && fs.statSync(dir).isDirectory();
}

function browser_parser (project) {
    if (!dirExists(project) || !dirExists(path.join(project, 'cordova'))) {
        throw new CordovaError('The provided path "' + project + '" is not a valid browser project.');
    }
    this.path = project;
}

module.exports = browser_parser;

// Returns a promise.
browser_parser.prototype.update_from_config = function () {
    return Promise.resolve();
};

browser_parser.prototype.www_dir = function () {
    return path.join(this.path, 'www');
};

// Used for creating platform_www in projects created by older versions.
browser_parser.prototype.cordovajs_path = function (libDir) {
    var jsPath = path.join(libDir, 'cordova-lib', 'cordova.js');
    return path.resolve(jsPath);
};

browser_parser.prototype.cordovajs_src_path = function (libDir) {
    // console.log("cordovajs_src_path");
    var jsPath = path.join(libDir, 'cordova-js-src');
    return path.resolve(jsPath);
};

/**
 * Logs all file operations via the verbose event stream, indented.
 */
function logFileOp (message) {
    events.emit('verbose', '  ' + message);
}

// Replace the www dir with contents of platform_www and app www.
browser_parser.prototype.update_www = function (cordovaProject, opts) {
    var platform_www = path.join(this.path, 'platform_www');
    var my_www = this.www_dir();
    // add cordova www and platform_www to sourceDirs
    var sourceDirs = [
        path.relative(cordovaProject.root, cordovaProject.locations.www),
        path.relative(cordovaProject.root, platform_www)
    ];

    // If project contains 'merges' for our platform, use them as another overrides
    var merges_path = path.join(cordovaProject.root, 'merges', 'browser');
    if (fs.existsSync(merges_path)) {
        events.emit('verbose', 'Found "merges/browser" folder. Copying its contents into the browser project.');
        // add merges/browser to sourceDirs
        sourceDirs.push(path.join('merges', 'browser'));
    }

    // targetDir points to browser/www
    var targetDir = path.relative(cordovaProject.root, my_www);
    events.emit('verbose', 'Merging and updating files from [' + sourceDirs.join(', ') + '] to ' + targetDir);
    FileUpdater.mergeAndUpdateDir(sourceDirs, targetDir, { rootDir: cordovaProject.root }, logFileOp);
};

browser_parser.prototype.update_overrides = function () {
    // console.log("update_overrides");

    // TODO: ?
    // var projectRoot = util.isCordova(this.path);
    // var mergesPath = path.join(util.appDir(projectRoot), 'merges', 'browser');
    // if(fs.existsSync(mergesPath)) {
    //     var overrides = path.join(mergesPath, '*');
    //     shell.cp('-rf', overrides, this.www_dir());
    // }
};

browser_parser.prototype.config_xml = function () {
    return path.join(this.path, 'config.xml');
};

// Returns a promise.
browser_parser.prototype.update_project = function (cfg) {
    // console.log("update_project ",cfg);
    var defer = this.update_from_config();
    var self = this;
    var www_dir = self.www_dir();
    defer.then(function () {
        self.update_overrides();
        // Copy munged config.xml to platform www dir
        shell.cp('-rf', path.join(www_dir, '..', 'config.xml'), www_dir);
    });
    return defer;
};
