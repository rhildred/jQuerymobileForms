JQuery Mobile app object and events
======

You will see a lot of code that looks like this:

    var app = {
        // Application Constructor
        initialize: function() {
            this.bindEvents();
        },
        // Bind Event Listeners
        //
        // Bind any events that are required on startup. Common events are:
        // 'load', 'deviceready', 'offline', and 'online'.
        bindEvents: function() {
            document.addEventListener('deviceready', this.onDeviceReady, false);
        },
        // deviceready Event Handler
        //
        // The scope of 'this' is the event. In order to call the 'receivedEvent'
        // function, we must explicity call 'app.receivedEvent(...);'
        onDeviceReady: function() {
            app.receivedEvent('deviceready');
        },
        // Update DOM on a Received Event
        receivedEvent: function(id) {
            var parentElement = document.getElementById(id);
            var listeningElement = parentElement.querySelector('.listening');
            var receivedElement = parentElement.querySelector('.received');

            listeningElement.setAttribute('style', 'display:none;');
            receivedElement.setAttribute('style', 'display:block;');

            console.log('Received Event: ' + id);
        }
    };
    app.initialize();
    
I thought that I would get fancy and move my initialize up a line `}.initialize();` I got an error when my deviceReady event was received, because there was no app yet when `initialize` was chained on. 1 fix was to just go back to the way that the example was. A better fix, I think, is to use jQuery.proxy to set the context for the app when the listener is bound to the event:

    var app = {
        // Application Constructor
        initialize: function() {
            this.bindEvents();
        },
        // Bind Event Listeners
        //
        // Bind any events that are required on startup. Common events are:
        // 'load', 'deviceready', 'offline', and 'online'.
        bindEvents: function() {
            document.addEventListener('deviceready', jQuery.proxy(this.onDeviceReady, this), false);
        },
        // deviceready Event Handler
        //
        // The scope of 'this' is the event. In order to call the 'receivedEvent'
        // function, we must explicity call 'app.receivedEvent(...);'
        onDeviceReady: function() {
            this.receivedEvent('deviceready');
        },
        // Update DOM on a Received Event
        receivedEvent: function(id) {
            console.log('Received Event: ' + id);
        }
    }.initialize();

I think that this is a better fix, because we don't rely on a global app object to move forwards. In a big project we may have multiple objects listening for different events. jQuery.proxy seems to keep related events and objects together better then using a global identifier like `app`.