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
var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
        var el = $('#main');
        el.empty();

        var html = app.render("intro",{});
        el.append(html)

    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        this.receivedEvent('deviceready');
    },

    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        console.log('Received Event: ' + id);
    },

    render: function (tmpl_name, tmpl_data) {
        if (!this.render.tmpl_cache) {
            this.render.tmpl_cache = {};
        }

        if (!this.render.tmpl_cache[tmpl_name]) {
            var tmpl_dir = 'templates';

            var tmpl_url = tmpl_dir + '/' + tmpl_name + '.html';

            var tmpl_string;

            $.ajax({
                url: tmpl_url,
                method: 'GET',
                dataType: 'html',
                async: false,
                success: function(data) {
                    tmpl_string = data;
                }
            });

            this.render.tmpl_cache[tmpl_name] = _.template(tmpl_string);
        }

        return this.render.tmpl_cache[tmpl_name](tmpl_data);
    }
};

app.initialize();

$(document).on("click","#learn_more",function(event){
  var el = $('#main');
  el.empty();

  var html = app.render("about",{});
  el.append(html)
})
