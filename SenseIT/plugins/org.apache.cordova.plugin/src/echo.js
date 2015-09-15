
angular.module('plugin', ['ngCordova', 'ionic'])

    .factory('echo', function ($window) {

        //cordova.exec(function(winParam) {}, function(error) {}, "service", "action", ["firstArgument", "secondArgument", 42, false]);


        window.echo = function(str, callback) {
            cordova.exec(callback, function(err) {callback('Nothing to echo.');}, "Echo", "echo", [str] ); 
        };

        return 1;

    });       



