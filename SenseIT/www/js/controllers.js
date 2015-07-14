
angular.module('starter.controllers', ['ionic.utils', 'starter.services', 'ngOpenFB'])

.controller('AppCtrl', function($scope, $state, $ionicModal, localstorage, $timeout, ngFB, $ionicPlatform, $window) {

  // Form data for the login modal
  $scope.loginData = {};
 
  // Create the login modal that we will use later
  $ionicModal.fromTemplateUrl('templates/login.html', {
    scope: $scope,
    animation: 'slide-in-up'
  }).then(function(modal) {
    $scope.modal = modal;
  
    $ionicPlatform.ready(function() {  
      
      var token = window.localStorage.getItem('TokenResponse');
      
      if (token === null)
      {
        $scope.login();
      }
      
      });
      
    });
      
 
  // Triggered in the login modal to close it
  $scope.closeLogin = function() {
    $scope.modal.hide();
  };

  // Open the login modal
  $scope.login = function() {
    $scope.modal.show();
  };

  $scope.fbLogin = function () {
    ngFB.login({scope: 'email,read_stream,publish_actions'}).then(
        function (response) {
            if (response.status === 'connected') {
                console.log('Facebook login succeeded');
     
                window.localStorage.setItem('TokenResponse', response.authResponse.accessToken);
                ngFB.api({
                        path: '/me',
                        params: {access_token: window.localStorage.TokenResponse, fields: 'id,name'}
                        }).then(
                        function (user) {                          
                            localstorage.setObject('user', {
                            name: user.name,
                            id: user.id,
                            city: user.city
                            });

                          },

                        
                        function (error) {
                            alert('Facebook error: ' + error.error_description);
                        });
                 
                $scope.closeLogin();
            } else {
                alert('Facebook login failed');
            }
        });
};
  
})


.controller('SessionsCtrl', function($scope, Session) {
    $scope.sessions = Session.query();
})

.controller('SessionCtrl', function($scope, $stateParams, Session, ngFB) {
    $scope.session = Session.get({sessionId: $stateParams.sessionId});

    
})

.controller('HomeCtrl', function($scope, $stateParams, ngFB, $cordovaSocialSharing){

  $scope.share1 = function(){

    $cordovaSocialSharing
    .shareViaFacebook("Mira este video en 360! Disfrutalo en realidad virtual con SenseIT", null,"https://www.youtube.com/watch?v=WKAgKlnfkDA" )
    .then(function(result){
      alert('El video se compartio en Facebook');
    }, function(err){
      alert('Error al compartir el video en Facebook');
    });
  };
  /*$scope.share1 = function (event) {

   var videoUrl = "https://www.youtube.com/watch?WKAgKlnfkDA "; 

   ngFB.api({
        method: 'POST',
        path: '/me/feed',
        params: {
            
            message: videoUrl + " Mirá este video en 360 usá SenseIT para verlo en realidad virtual!"

        }
    }).then(
        function () {
            alert('El video fue compartido en Facebook');
        },
        function () {
            alert('Ocurrió un error al compartir el video en Facebook');
        });
};*/

$scope.share2 = function (event) {

    var videoUrl = "https://www.youtube.com/watch?v=6uG9vtckp1U";

    $cordovaSocialSharing
    .shareViaFacebook("Mira este video en 360! Disfrutalo en realidad virtual con SenseIT", null,videoUrl)
    .then(function(result){
      alert('El video se compartio en Facebook');
    }, function(err){
      alert('Error al compartir el video en Facebook');
    });
};


$scope.share3 = function (event) {

    var videoUrl = "https://www.youtube.com/watch?v=LdTm7Vpape0";

   $cordovaSocialSharing
    .shareViaFacebook("Mira este video en 360! Disfrutalo en realidad virtual con SenseIT", null,videoUrl)
    .then(function(result){
      //alert('El video se compartio en Facebook');
      $ionicPopup.show({
        template: "<style>.popup { width: 500px} </style><p>Video compartido en Facebook</p>",
        title: 'Compartir',
        scope: $scope,
        buttons: [
          {text: 'Ok'},
          {
            text: '<b>OK</b>',
            type: 'button-positive',
            OnTap: function(){console.log('Se compartio video en facebook')}
          }
        ]
      });
    }, function(err){
      alert('Error al compartir el video en Facebook');
    });
};


})

.controller('ProfileCtrl', function ($scope, $state, ngFB, localstorage, $ionicModal) {

  $scope.user = localstorage.getObject('user');
  $scope.fbLogin = function () {
  ngFB.login({scope: 'email,read_stream,publish_actions'}).then(
      function (response) {
          if (response.status === 'connected') {
              console.log('Facebook login succeeded');
   
              window.localStorage.setItem('TokenResponse', response.authResponse.accessToken);
              ngFB.api({
                      path: '/me',
                      params: {access_token: window.localStorage.TokenResponse, fields: 'id,name'}
                      }).then(
                      function (user) {                          
                          localstorage.setObject('user', {
                          name: user.name,
                          id: user.id,
                          city: user.city
                          });

                        },

                      
                      function (error) {
                          alert('Facebook error: ' + error.error_description);
                      });
               
              $scope.closeLogin();
          } else {
              alert('Facebook login failed');
          }
      });
  };

  // Triggered in the login modal to close it
  $scope.closeLogin = function() {
    $scope.modal.hide();
  };

  $scope.fbLogout = function() {
    ngFB.logout();
    //delete local storage information
    localstorage.deleteObject('user');
    //delete scope user
    $scope.user = null;
    //show login modal again
    // Form data for the login modal
    $scope.loginData = {};
 
    // Create the login modal that we will use later
    $ionicModal.fromTemplateUrl('templates/login.html', {
        scope: $scope,
        animation: 'slide-in-up'
      }).then(function(modal) {
        $scope.modal = modal;
        $state.go('app.home');
        $scope.modal.show();

    }) ;


  }
})




.controller("FileCtrl", function($scope, $ionicLoading) {
 
    $scope.download = function() {
      $ionicLoading.show({
      template: 'Loading...'
    });
    window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fs) {
        fs.root.getDirectory(
            "ExampleProject",
            {
                create: false
            },
            function(dirEntry) {
                dirEntry.getFile(
                    "test.mp4", 
                    {
                        create: false, 
                        exclusive: false
                    }, 
                    function gotFileEntry(fe) {
                        var p = fe.toURL();
                        fe.remove();
                        ft = new FileTransfer();
                        ft.download(
                          encodeURL("https://www.youtube.com/watch?v=WKAgKlnfkDA"),
                          p,
                          function(entry){
                            $ionicLoading.hide();
                            $scope.vdoFile = entry.toURL();
                          },
                          function(error){
                            $ionicLoading.hide();
                            console.log("download failed");
                          },
                          false,
                          null
                        );
                    }, 
                    function(error) {
                        $ionicLoading.hide();
                        console.log("Error getting file");
                    }
                );
            }
        );
    },
    function() {
        $ionicLoading.hide();
        console.log("Error requesting filesystem");
    });
 
    }
 
    $scope.load = function() {
    
    }
 
});
;;