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
var shell = require('shelljs');
var path = require('path');
var check_reqs = require('./check_reqs');
var platformBuildDir = path.join('platforms', 'browser', 'www');

var run = function () {

    // TODO: everything calls check_reqs ... why?
    // Check that requirements are (still) met
    if (!check_reqs.run()) {
        console.error('Please make sure you meet the software requirements in order to clean an browser cordova project');
        process.exit(2);
    }

    try {
        if (fs.existsSync(platformBuildDir)) {
            shell.rm('-r', platformBuildDir);
        }
    } catch (err) {
        console.log('could not remove ' + platformBuildDir + ' : ' + err.message);
    }
};

module.exports.run = run;
// just on the off chance something is still calling cleanProject, we will leave this here for a while
module.exports.cleanProject = function () {
    console.log('lib/clean will soon only export a `run` command, please update to not call `cleanProject`.');
    return run();
};
