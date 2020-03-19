#!/usr/bin/env node

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

var fs = require('fs');
var path = require('path');
var url = require('url');
var cordovaServe = require('cordova-serve');

module.exports.run = function (args) {
    // defaults
    args.port = args.port || 8000;
    args.target = args.target || 'default'; // make default the system browser
    args.noLogOutput = args.silent || false;

    var wwwPath = path.join(__dirname, '../../www');
    var manifestFilePath = path.resolve(path.join(wwwPath, 'manifest.json'));

    var startPage;

    // get start page from manifest
    if (fs.existsSync(manifestFilePath)) {
        try {
            var manifest = require(manifestFilePath);
            startPage = manifest.start_url;
        } catch (err) {
            console.log('failed to require manifest ... ' + err);
        }
    }

    var server = cordovaServe();
    server.servePlatform('browser', { port: args.port, noServerInfo: true, noLogOutput: args.noLogOutput })
        .then(function () {
            if (!startPage) {
                // failing all else, set the default
                startPage = 'index.html';
            }

            var projectUrl = (new url.URL(`http://localhost:${server.port}/${startPage}`)).href;

            console.log('startPage = ' + startPage);
            console.log('Static file server running @ ' + projectUrl + '\nCTRL + C to shut down');
            return server.launchBrowser({ 'target': args.target, 'url': projectUrl });
        })
        .catch(function (error) {
            console.log(error.message || error.toString());
            if (server.server) {
                server.server.close();
            }
        });
};
