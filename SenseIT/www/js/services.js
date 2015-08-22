angular.module('starter.services', ['ngResource'])

.factory('login', function ($resource) {

    //return $resource('http://localhost:5000/sessions/:sessionId');
    return $resource('http://localhost:5000/login')
})

.factory('dbServices', function ($resource) {
    return $resource('http://192.168.1.102:3000/api/v1/videos')
    //cuando esten implementadas las funciones en el server va esta
    //return $resource('http://192.168.1.102:3000/api/v1')
})

.factory('user', function($resource){
  var serverIp = window.localStorage.getItem('serverIp');
  return $resource('serverIp' + 'users/new')
})

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