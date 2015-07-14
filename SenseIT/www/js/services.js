angular.module('starter.services', ['ngResource'])

.factory('login', function ($resource) {

    //return $resource('http://localhost:5000/sessions/:sessionId');
    return $resource('http://localhost:5000/login')
});

angular.module('ionic.utils', [])
  .factory('localstorage', ['$window', function($window) {
    return {
      set: function(key, value) {
        $window.localStorage[key] = value;
      },
      get: function(key, defaultValue) {
        return $window.localStorage[key] || defaultValue;
      },
      setObject: function(key, value) {
        $window.localStorage[key] = JSON.stringify(value);
      },
      getObject: function(key) {
        return JSON.parse($window.localStorage[key] || '{}');
      },
      deleteObject: function(key){
      	return $window.localStorage.removeItem(key);
      }
    }
  }]);