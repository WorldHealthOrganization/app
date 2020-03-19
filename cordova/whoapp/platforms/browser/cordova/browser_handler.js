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

var path = require('path');
var fs = require('fs');
var shell = require('shelljs');
var events = require('cordova-common').events;

module.exports = {
    www_dir: function (project_dir) {
        return path.join(project_dir, 'www');
    },
    package_name: function (project_dir) {
        // this method should the id from root config.xml => <widget id=xxx
        // return common.package_name(project_dir, this.www_dir(project_dir));
        // console.log('package_name called with ' + project_dir);
        var pkgName = 'io.cordova.hellocordova';
        var widget_id_regex = /(?:<widget\s+id=['"])(\S+)(?:['"])/;

        var configPath = path.join(project_dir, 'config.xml');
        if (fs.existsSync(configPath)) {
            var configStr = fs.readFileSync(configPath, 'utf8');
            var res = configStr.match(widget_id_regex);
            if (res && res.length > 1) {
                pkgName = res[1];
            }
        }
        return pkgName;
    },
    'js-module': {
        install: function (jsModule, plugin_dir, plugin_id, www_dir) {
            // Copy the plugin's files into the www directory.
            var moduleSource = path.resolve(plugin_dir, jsModule.src);
            // Get module name based on existing 'name' attribute or filename
            // Must use path.extname/path.basename instead of path.parse due to CB-9981
            var moduleName = plugin_id + '.' + (jsModule.name || path.basename(jsModule.src, path.extname(jsModule.src)));

            // Read in the file, prepend the cordova.define, and write it back out.
            var scriptContent = fs.readFileSync(moduleSource, 'utf-8').replace(/^\ufeff/, ''); // Window BOM
            if (moduleSource.match(/.*\.json$/)) {
                scriptContent = 'module.exports = ' + scriptContent;
            }
            scriptContent = 'cordova.define("' + moduleName + '", function(require, exports, module) { ' + scriptContent + '\n});\n';

            var moduleDestination = path.resolve(www_dir, 'plugins', plugin_id, jsModule.src);
            shell.mkdir('-p', path.dirname(moduleDestination));
            fs.writeFileSync(moduleDestination, scriptContent, 'utf-8');
        },
        uninstall: function (jsModule, www_dir, plugin_id) {
            var pluginRelativePath = path.join('plugins', plugin_id, jsModule.src);
            // common.removeFileAndParents(www_dir, pluginRelativePath);
            console.log('js-module uninstall called : ' + pluginRelativePath);
        }
    },
    'source-file': {
        install: function (obj, plugin_dir, project_dir, plugin_id, options) {
            // var dest = path.join(obj.targetDir, path.basename(obj.src));
            // common.copyFile(plugin_dir, obj.src, project_dir, dest);
            console.log('install called');
        },
        uninstall: function (obj, project_dir, plugin_id, options) {
            // var dest = path.join(obj.targetDir, path.basename(obj.src));
            // common.removeFile(project_dir, dest);
            console.log('uninstall called');
        }
    },
    'header-file': {
        install: function (obj, plugin_dir, project_dir, plugin_id, options) {
            events.emit('verbose', 'header-fileinstall is not supported for browser');
        },
        uninstall: function (obj, project_dir, plugin_id, options) {
            events.emit('verbose', 'header-file.uninstall is not supported for browser');
        }
    },
    'resource-file': {
        install: function (obj, plugin_dir, project_dir, plugin_id, options) {
            events.emit('verbose', 'resource-file.install is not supported for browser');
        },
        uninstall: function (obj, project_dir, plugin_id, options) {
            events.emit('verbose', 'resource-file.uninstall is not supported for browser');
        }
    },
    'framework': {
        install: function (obj, plugin_dir, project_dir, plugin_id, options) {
            events.emit('verbose', 'framework.install is not supported for browser');
        },
        uninstall: function (obj, project_dir, plugin_id, options) {
            events.emit('verbose', 'framework.uninstall is not supported for browser');
        }
    },
    'lib-file': {
        install: function (obj, plugin_dir, project_dir, plugin_id, options) {
            events.emit('verbose', 'lib-file.install is not supported for browser');
        },
        uninstall: function (obj, project_dir, plugin_id, options) {
            events.emit('verbose', 'lib-file.uninstall is not supported for browser');
        }
    },
    asset: {
        install: function (asset, plugin_dir, wwwDest) {
            var src = path.join(plugin_dir, asset.src);
            var dest = path.join(wwwDest, asset.target);
            var destDir = path.parse(dest).dir;
            if (destDir !== '' && !fs.existsSync(destDir)) {
                shell.mkdir('-p', destDir);
            }

            if (fs.statSync(src).isDirectory()) {
                shell.cp('-Rf', src + '/*', dest);
            } else {
                shell.cp('-f', src, dest);
            }
        },
        uninstall: function (asset, wwwDest, plugin_id) {
            shell.rm('-rf', path.join(wwwDest, asset.target));
            shell.rm('-rf', path.join(wwwDest, 'plugins', plugin_id));
        }
    }
};
