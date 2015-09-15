angular.module('starter.services', ['ngResource'])

.factory('login', function ($resource) {
    return $resource('http://localhost:5000/login')
})

.factory('dbServices', function ($resource) {
    var serverIp = window.localStorage.getItem('serverIp');
    return $resource(serverIp + 'videos')
   
})

.factory('User', function($resource){
  var serverIp = window.localStorage.getItem('serverIp');
  return $resource(serverIp + 'users')

})

.factory('Favorite', function($resource){
  var serverIp = window.localStorage.getItem('serverIp');
  return $resource(serverIp + 'favourites')

})

.factory('Video', function($resource){
  var serverIp = window.localStorage.getItem('serverIp');
  return 1;
})
.factory('History', function($resource){
  var serverIp = window.localStorage.getItem('serverIp');
  return $resource(serverIp + 'histories')
})

.factory('$localstorage', ['$window', function($window) {
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