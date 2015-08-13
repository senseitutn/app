// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.controllers' is found in controllers.js

//Creamos la base de datos como una variable global para que se pueda acceder desde cualquier metodo y controlador
//var db = null;

angular.module('starter', ['ionic', 'starter.controllers', 'ngOpenFB', 'ngCordova', 'ngResource'])

.run(function($ionicPlatform, ngFB, $cordovaSQLite) {

  ngFB.init({appId: '1431925717111021'});
  
  window.localStorage.setItem('serverIp', 'http://192.168.0.121:3000/api/v1/');

  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }

  });
})

.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

  .state('app', {
    url: "/app",
    abstract: true,
    templateUrl: "templates/menu.html",
    controller: 'AppCtrl'
  })

  .state('app.historial', {
    url: "/historial",
    views: {
      'menuContent':{
          templateUrl:"templates/historial.html",
          controller: 'historialCtrl'
      }
    }
  })

  .state('app.favoritos', {
    url: "/favoritos",
    views: {
      'menuContent': {
        templateUrl: "templates/favoritos.html"
      }
    }
  })

  .state('app.home', {
    url: "/home",
    views: {
      'menuContent': {
        templateUrl: "templates/home.html",
        controller: 'HomeCtrl'
      }
    }
  })

  .state('app.profile', {
    url: "/profile",
    views: {
        'menuContent': {
            templateUrl: "templates/profile.html",
            controller: "ProfileCtrl"
        }
    }
})
  
  .state('app.videos', {
  url: "/videos",
  views: {
      'menuContent': {
          templateUrl: "templates/videos.html",
          controller: 'VideosCtrl'
      }
  }
})

  .state('app.acerca', {
  url: "/acerca",
  views: {
      'menuContent': {
          templateUrl: "templates/acerca.html"
      }
  }
})


.state('app.video', {
    url: "/video/:videoId",
    views: {
        'menuContent': {
          templateUrl: "templates/video.html",
          controller: 'videoCtrl'
      }
    }
});;
  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/app/home');
});
