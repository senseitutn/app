
angular.module('plugin', ['ngCordova', 'ionic'])

    .factory('echo', function ($window) {


        window.echo = function(str, callback) {

            var result = cordova.exec(callback, function(err) {
                callback('Nothing to echo.');
                alert('el error es: '+err);
                }, "Echo", "echo", [str]);
            alert('termino el exec con:'+result);
        };

        return 1;

    });       

