/**
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
'License'); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
'AS IS' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
*/

/*
    this file is found by cordova-lib when you attempt to
    'cordova platform add PATH' where path is this repo.
*/

var shell = require('shelljs');
var path = require('path');
var fs = require('fs');

var cdvcmn = require('cordova-common');
var CordovaLogger = cdvcmn.CordovaLogger;
var ConfigParser = cdvcmn.ConfigParser;
var ActionStack = cdvcmn.ActionStack;
var selfEvents = cdvcmn.events;
var xmlHelpers = cdvcmn.xmlHelpers;
var PlatformJson = cdvcmn.PlatformJson;
var PlatformMunger = cdvcmn.ConfigChanges.PlatformMunger;
var PluginInfoProvider = cdvcmn.PluginInfoProvider;

var BrowserParser = require('./browser_parser');
var PLATFORM_NAME = 'browser';

function setupEvents (externalEventEmitter) {
    if (externalEventEmitter) {
        // This will make the platform internal events visible outside
        selfEvents.forwardEventsTo(externalEventEmitter);
        return externalEventEmitter;
    }

    // There is no logger if external emitter is not present,
    // so attach a console logger
    CordovaLogger.get().subscribe(selfEvents);
    return selfEvents;
}

function Api (platform, platformRootDir, events) {

    this.platform = platform || PLATFORM_NAME;

    // MyApp/platforms/browser
    this.root = path.resolve(__dirname, '..');
    this.events = setupEvents(events);
    this.parser = new BrowserParser(this.root);
    this._handler = require('./browser_handler');

    this.locations = {
        platformRootDir: platformRootDir,
        root: this.root,
        www: path.join(this.root, 'www'),
        res: path.join(this.root, 'res'),
        platformWww: path.join(this.root, 'platform_www'),
        configXml: path.join(this.root, 'config.xml'),
        defaultConfigXml: path.join(this.root, 'cordova/defaults.xml'),
        build: path.join(this.root, 'build'),
        // NOTE: Due to platformApi spec we need to return relative paths here
        cordovaJs: 'bin/templates/project/assets/www/cordova.js',
        cordovaJsSrc: 'cordova-js-src'
    };

    this._platformJson = PlatformJson.load(this.root, platform);
    this._pluginInfoProvider = new PluginInfoProvider();
    this._munger = new PlatformMunger(platform, this.root, this._platformJson, this._pluginInfoProvider);
}

Api.createPlatform = function (dest, config, options, events) {

    var creator = require('../../lib/create');
    events = setupEvents(events);

    var name = 'HelloCordova';
    var id = 'io.cordova.hellocordova';
    if (config) {
        name = config.name();
        id = config.packageName();
    }

    var result;
    try {
        // we create the project using our scripts in this platform
        result = creator.createProject(dest, id, name, options)
            .then(function () {
                // after platform is created we return Api instance based on new Api.js location
                // Api.js has been copied to the new project
                // This is required to correctly resolve paths in the future api calls
                var PlatformApi = require(path.resolve(dest, 'cordova/Api'));
                return new PlatformApi('browser', dest, events);
            });
    } catch (e) {
        events.emit('error', 'createPlatform is not callable from the browser project API.');
        throw (e);
    }
    return result;
};

Api.updatePlatform = function (dest, options, events) {
    // console.log("test-platform:Api:updatePlatform");
    // todo?: create projectInstance and fulfill promise with it.
    return Promise.resolve();
};

Api.prototype.getPlatformInfo = function () {
    // console.log("browser-platform:Api:getPlatformInfo");
    // return PlatformInfo object
    return {
        'locations': this.locations,
        'root': this.root,
        'name': this.platform,
        'version': { 'version': '1.0.0' }, // um, todo!
        'projectConfig': this.config
    };
};

Api.prototype.prepare = function (cordovaProject, options) {

    // First cleanup current config and merge project's one into own
    var defaultConfigPath = path.join(this.locations.platformRootDir, 'cordova',
        'defaults.xml');
    var ownConfigPath = this.locations.configXml;
    var sourceCfg = cordovaProject.projectConfig;

    // If defaults.xml is present, overwrite platform config.xml with it.
    // Otherwise save whatever is there as defaults so it can be
    // restored or copy project config into platform if none exists.
    if (fs.existsSync(defaultConfigPath)) {
        this.events.emit('verbose', 'Generating config.xml from defaults for platform "' + this.platform + '"');
        shell.cp('-f', defaultConfigPath, ownConfigPath);
    } else if (fs.existsSync(ownConfigPath)) {
        this.events.emit('verbose', 'Generating defaults.xml from own config.xml for platform "' + this.platform + '"');
        shell.cp('-f', ownConfigPath, defaultConfigPath);
    } else {
        this.events.emit('verbose', 'case 3"' + this.platform + '"');
        shell.cp('-f', sourceCfg.path, ownConfigPath);
    }

    // merge our configs
    this.config = new ConfigParser(ownConfigPath);
    xmlHelpers.mergeXml(cordovaProject.projectConfig.doc.getroot(),
        this.config.doc.getroot(),
        this.platform, true);
    this.config.write();

    // Update own www dir with project's www assets and plugins' assets and js-files
    this.parser.update_www(cordovaProject, options);

    // Copy or Create manifest.json
    // todo: move this to a manifest helper module
    // output path
    var manifestPath = path.join(this.locations.www, 'manifest.json');
    var srcManifestPath = path.join(cordovaProject.locations.www, 'manifest.json');
    if (fs.existsSync(srcManifestPath)) {
        // just blindly copy it to our output/www
        // todo: validate it? ensure all properties we expect exist?
        this.events.emit('verbose', 'copying ' + srcManifestPath + ' => ' + manifestPath);
        shell.cp('-f', srcManifestPath, manifestPath);
    } else {
        var manifestJson = {
            'background_color': '#FFF',
            'display': 'standalone'
        };
        if (this.config) {
            if (this.config.name()) {
                manifestJson.name = this.config.name();
            }
            if (this.config.shortName()) {
                manifestJson.short_name = this.config.shortName();
            }
            if (this.config.packageName()) {
                manifestJson.version = this.config.packageName();
            }
            if (this.config.description()) {
                manifestJson.description = this.config.description();
            }
            if (this.config.author()) {
                manifestJson.author = this.config.author();
            }
            // icons
            var icons = this.config.getStaticResources('browser', 'icon');
            var manifestIcons = icons.map(function (icon) {
                // given a tag like this :
                // <icon src="res/ios/icon.png" width="57" height="57" density="mdpi" />
                /* configParser returns icons that look like this :
                {   src: 'res/ios/icon.png',
                    target: undefined,
                    density: 'mdpi',
                    platform: null,
                    width: 57,
                    height: 57
                } ******/
                /* manifest expects them to be like this :
                {   "src": "images/touch/icon-128x128.png",
                    "type": "image/png",
                    "sizes": "128x128"
                } ******/
                // ?Is it worth looking at file extentions?
                return { 'src': icon.src,
                    'type': 'image/png',
                    'sizes': (icon.width + 'x' + icon.height) };
            });
            manifestJson.icons = manifestIcons;

            // orientation
            // <preference name="Orientation" value="landscape" />
            var oriPref = this.config.getGlobalPreference('Orientation');
            if (oriPref) {
                // if it's a supported value, use it
                if (['landscape', 'portrait'].indexOf(oriPref) > -1) {
                    manifestJson.orientation = oriPref;
                } else { // anything else maps to 'any'
                    manifestJson.orientation = 'any';
                }
            }

            // get start_url
            var contentNode = this.config.doc.find('content') || { 'attrib': { 'src': 'index.html' } }; // sensible default
            manifestJson.start_url = contentNode.attrib.src;

            // now we get some values from start_url page ...
            var startUrlPath = path.join(cordovaProject.locations.www, manifestJson.start_url);
            if (fs.existsSync(startUrlPath)) {
                var contents = fs.readFileSync(startUrlPath, 'utf-8');
                // matches <meta name="theme-color" content="#FF0044">
                var themeColorRegex = /<meta(?=[^>]*name="theme-color")\s[^>]*content="([^>]*)"/i;
                var result = themeColorRegex.exec(contents);
                var themeColor;
                if (result && result.length >= 2) {
                    themeColor = result[1];
                } else { // see if there is a preference in config.xml
                    // <preference name="StatusBarBackgroundColor" value="#000000" />
                    themeColor = this.config.getGlobalPreference('StatusBarBackgroundColor');
                }
                if (themeColor) {
                    manifestJson.theme_color = themeColor;
                }
            }
        }
        fs.writeFileSync(manifestPath, JSON.stringify(manifestJson, null, 2), 'utf8');
    }

    // update project according to config.xml changes.
    return this.parser.update_project(this.config, options);
};

Api.prototype.addPlugin = function (pluginInfo, installOptions) {

    // console.log(new Error().stack);
    if (!pluginInfo) {
        return Promise.reject(new Error('The parameter is incorrect. The first parameter ' +
            'should be valid PluginInfo instance'));
    }

    installOptions = installOptions || {};
    installOptions.variables = installOptions.variables || {};
    // CB-10108 platformVersion option is required for proper plugin installation
    installOptions.platformVersion = installOptions.platformVersion ||
        this.getPlatformInfo().version;

    var self = this;
    var actions = new ActionStack();
    var projectFile = this._handler.parseProjectFile && this._handler.parseProjectFile(this.root);

    // gather all files needs to be handled during install
    pluginInfo.getFilesAndFrameworks(this.platform)
        .concat(pluginInfo.getAssets(this.platform))
        .concat(pluginInfo.getJsModules(this.platform))
        .forEach(function (item) {
            actions.push(actions.createAction(
                self._getInstaller(item.itemType),
                [item, pluginInfo.dir, pluginInfo.id, installOptions, projectFile],
                self._getUninstaller(item.itemType),
                [item, pluginInfo.dir, pluginInfo.id, installOptions, projectFile]));
        });

    // run through the action stack
    return actions.process(this.platform, this.root)
        .then(function () {
            if (projectFile) {
                projectFile.write();
            }

            // Add PACKAGE_NAME variable into vars
            if (!installOptions.variables.PACKAGE_NAME) {
                installOptions.variables.PACKAGE_NAME = self._handler.package_name(self.root);
            }

            self._munger
                // Ignore passed `is_top_level` option since platform itself doesn't know
                // anything about managing dependencies - it's responsibility of caller.
                .add_plugin_changes(pluginInfo, installOptions.variables, /* is_top_level= */true, /* should_increment= */true)
                .save_all();

            var targetDir = installOptions.usePlatformWww ?
                self.getPlatformInfo().locations.platformWww :
                self.getPlatformInfo().locations.www;

            self._addModulesInfo(pluginInfo, targetDir);
        });
};

Api.prototype.removePlugin = function (plugin, uninstallOptions) {
    // console.log("NotImplemented :: browser-platform:Api:removePlugin ",plugin, uninstallOptions);

    uninstallOptions = uninstallOptions || {};
    // CB-10108 platformVersion option is required for proper plugin installation
    uninstallOptions.platformVersion = uninstallOptions.platformVersion ||
        this.getPlatformInfo().version;

    var self = this;
    var actions = new ActionStack();
    var projectFile = this._handler.parseProjectFile && this._handler.parseProjectFile(this.root);

    // queue up plugin files
    plugin.getFilesAndFrameworks(this.platform)
        .concat(plugin.getAssets(this.platform))
        .concat(plugin.getJsModules(this.platform))
        .forEach(function (item) {
            actions.push(actions.createAction(
                self._getUninstaller(item.itemType), [item, plugin.dir, plugin.id, uninstallOptions, projectFile],
                self._getInstaller(item.itemType), [item, plugin.dir, plugin.id, uninstallOptions, projectFile]));
        });

    // run through the action stack
    return actions.process(this.platform, this.root)
        .then(function () {
            if (projectFile) {
                projectFile.write();
            }

            self._munger
                // Ignore passed `is_top_level` option since platform itself doesn't know
                // anything about managing dependencies - it's responsibility of caller.
                .remove_plugin_changes(plugin, /* is_top_level= */true)
                .save_all();

            var targetDir = uninstallOptions.usePlatformWww ?
                self.getPlatformInfo().locations.platformWww :
                self.getPlatformInfo().locations.www;

            self._removeModulesInfo(plugin, targetDir);
            // Remove stale plugin directory
            // TODO: this should be done by plugin files uninstaller
            shell.rm('-rf', path.resolve(self.root, 'Plugins', plugin.id));
        });
};

Api.prototype._getInstaller = function (type) {
    var self = this;
    return function (item, plugin_dir, plugin_id, options, project) {
        var installer = self._handler[type];

        if (!installer) {
            console.log('unrecognized type ' + type);

        } else {
            var wwwDest = options.usePlatformWww ?
                self.getPlatformInfo().locations.platformWww :
                self._handler.www_dir(self.root);

            if (type === 'asset') {
                installer.install(item, plugin_dir, wwwDest);
            } else if (type === 'js-module') {
                installer.install(item, plugin_dir, plugin_id, wwwDest);
            } else {
                installer.install(item, plugin_dir, self.root, plugin_id, options, project);
            }
        }
    };
};

Api.prototype._getUninstaller = function (type) {
    var self = this;
    return function (item, plugin_dir, plugin_id, options, project) {
        var installer = self._handler[type];

        if (!installer) {
            console.log('browser plugin uninstall: unrecognized type, skipping : ' + type);

        } else {
            var wwwDest = options.usePlatformWww ?
                self.getPlatformInfo().locations.platformWww :
                self._handler.www_dir(self.root);

            if (['asset', 'js-module'].indexOf(type) > -1) {
                return installer.uninstall(item, wwwDest, plugin_id);
            } else {
                return installer.uninstall(item, self.root, plugin_id, options, project);
            }

        }
    };
};

/**
 * Removes the specified modules from list of installed modules and updates
 *   platform_json and cordova_plugins.js on disk.
 *
 * @param   {PluginInfo}  plugin  PluginInfo instance for plugin, which modules
 *   needs to be added.
 * @param   {String}  targetDir  The directory, where updated cordova_plugins.js
 *   should be written to.
 */
Api.prototype._addModulesInfo = function (plugin, targetDir) {
    var installedModules = this._platformJson.root.modules || [];

    var installedPaths = installedModules.map(function (installedModule) {
        return installedModule.file;
    });

    var modulesToInstall = plugin.getJsModules(this.platform)
        .filter(function (moduleToInstall) {
            return installedPaths.indexOf(moduleToInstall.file) === -1;
        }).map(function (moduleToInstall) {
            var moduleName = plugin.id + '.' + (moduleToInstall.name || moduleToInstall.src.match(/([^\/]+)\.js/)[1]);
            var obj = {
                file: ['plugins', plugin.id, moduleToInstall.src].join('/'), /* eslint no-useless-escape : 0 */
                id: moduleName,
                pluginId: plugin.id
            };
            if (moduleToInstall.clobbers.length > 0) {
                obj.clobbers = moduleToInstall.clobbers.map(function (o) { return o.target; });
            }
            if (moduleToInstall.merges.length > 0) {
                obj.merges = moduleToInstall.merges.map(function (o) { return o.target; });
            }
            if (moduleToInstall.runs) {
                obj.runs = true;
            }

            return obj;
        });

    this._platformJson.root.modules = installedModules.concat(modulesToInstall);
    if (!this._platformJson.root.plugin_metadata) {
        this._platformJson.root.plugin_metadata = {};
    }
    this._platformJson.root.plugin_metadata[plugin.id] = plugin.version;

    this._writePluginModules(targetDir);
    this._platformJson.save();
};
/**
 * Fetches all installed modules, generates cordova_plugins contents and writes
 *   it to file.
 *
 * @param   {String}  targetDir  Directory, where write cordova_plugins.js to.
 *   Ususally it is either <platform>/www or <platform>/platform_www
 *   directories.
 */
Api.prototype._writePluginModules = function (targetDir) {
    // Write out moduleObjects as JSON wrapped in a cordova module to cordova_plugins.js
    var final_contents = 'cordova.define(\'cordova/plugin_list\', function(require, exports, module) {\n';
    final_contents += 'module.exports = ' + JSON.stringify(this._platformJson.root.modules, null, '    ') + ';\n';
    final_contents += 'module.exports.metadata = \n';
    final_contents += '// TOP OF METADATA\n';
    final_contents += JSON.stringify(this._platformJson.root.plugin_metadata || {}, null, '    ') + '\n';
    final_contents += '// BOTTOM OF METADATA\n';
    final_contents += '});'; // Close cordova.define.

    shell.mkdir('-p', targetDir);
    fs.writeFileSync(path.join(targetDir, 'cordova_plugins.js'), final_contents, 'utf-8');
};

/**
 * Removes the specified modules from list of installed modules and updates
 *   platform_json and cordova_plugins.js on disk.
 *
 * @param   {PluginInfo}  plugin  PluginInfo instance for plugin, which modules
 *   needs to be removed.
 * @param   {String}  targetDir  The directory, where updated cordova_plugins.js
 *   should be written to.
 */
Api.prototype._removeModulesInfo = function (plugin, targetDir) {
    var installedModules = this._platformJson.root.modules || [];
    var modulesToRemove = plugin.getJsModules(this.platform)
        .map(function (jsModule) {
            return ['plugins', plugin.id, jsModule.src].join('/');
        });

    var updatedModules = installedModules
        .filter(function (installedModule) {
            return (modulesToRemove.indexOf(installedModule.file) === -1);
        });

    this._platformJson.root.modules = updatedModules;
    if (this._platformJson.root.plugin_metadata) {
        delete this._platformJson.root.plugin_metadata[plugin.id];
    }

    this._writePluginModules(targetDir);
    this._platformJson.save();
};

Api.prototype.build = function (buildOptions) {
    var self = this;
    return require('./lib/check_reqs').run()
        .then(function () {
            return require('./lib/build').run.call(self, buildOptions);
        });
};

Api.prototype.run = function (runOptions) {
    return require('./lib/run').run(runOptions);
};

Api.prototype.clean = function (cleanOptions) {
    return require('./lib/clean').run(cleanOptions);
};

Api.prototype.requirements = function () {
    return require('./lib/check_reqs').run();
};

module.exports = Api;
