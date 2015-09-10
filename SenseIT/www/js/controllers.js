angular.module('starter.controllers', ['starter.services', 'ngResource', 'plugin', 'ngRoute'])

.controller('AppCtrl', function($scope, $state, $ionicModal, $localstorage, $cordovaOauth, $http, $window, User) {

  // Form data for the login modal
  $scope.profileData = null;
 
  // Create the login modal that we will use later
  $ionicModal.fromTemplateUrl('templates/login.html', {
    scope: $scope,
    animation: 'slide-in-up'
  }).then(function(modal) {
    $scope.modal = modal;
  
    
      var token = window.localStorage.getItem('TokenResponse');

      if (token === null)
      {
        $scope.login();
      }
  
    });

  // Triggered in the login modal to close it
  $scope.closeLogin = function() {
    $scope.modal.hide();
  };

  // Open the login modal
  $scope.login = function() {
    $scope.modal.show();
  };

  $scope.fbLogin = function() {

   $cordovaOauth.facebook("519491304866168", ["email", "user_website", "user_location", "user_relationships"]).then(function(result) {
       
        alert("Login satisfactorio");

        window.localStorage.setItem('TokenResponse', result.access_token);

        $http.get("https://graph.facebook.com/v2.2/me", { 
            params: {
                    access_token: result.access_token, 
                    fields: "id,name,gender,location,picture, email, first_name, last_name",
                    format: "json"
           }
        })
       .success(function(result) {

             $localstorage.setObject('user', {
              id: result.id,
              name: result.name,
              first_name: result.first_name,
              last_name: result.last_name,
              email: result.email
              });

             //mando al servidor el usuario para que lo cree 
              var newUser = new User();
             
              newUser.name = result.name;
              newUser.first_name = result.first_name;
              newUser.last_name = result.last_name;
              newUser.email = result.email;
              newUser.facebook_id = result.id;

              var dbResult = User.save(newUser, function(){
                console.log('se guardo el usuario: '+ newUser.name);
                //alert('se guardo el usuario: '+ newUser.name);
              });
              console.log(dbResult);

        })
       .error( function(error) {
              alert("Error al pedir datos del usuario ");

        });

        $scope.modal.hide();
        $state.go('app.home');
    }, function(error) {
        alert("There was a problem signing in!  See the console for logs"+error);

        console.log(error);
    });

}})

.controller('VideosCtrl', function($scope, $sce, $state, $http, $localstorage) {

  var id_face = $localstorage.getObject('user').id;

  //var id_face = '123198231';
  var serverIp = window.localStorage.getItem('serverIp');

  $http.get(serverIp +'users/get_videos/'+id_face).
    then(function(data) {
      // this callback will be called asynchronously
      // when the response is available
      $scope.videos = data.data.videos;
      var len = $scope.videos.length;

      for(var i=0;i<len;i++)
      { 
        var src= $scope.videos[i].url_preview; 

        //var src = 'https://www.youtube.com/embed/h3LeVGOBjSg'

        $scope.videos[i].url_preview= $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');

      }

    }, function(response) {
      alert('no se encontraron videos de este usuario');
      $state.go('app.home');
    });

  $scope.open = function(item){
        /*if ($scope.isOpen(item)){
            $scope.opened = undefined;
        } else {
            $scope.opened = item;
        }      */  
       $state.go('app.video', { id: item.id});
    };
    
  $scope.isOpen = function(item){
      return $scope.opened === item;
  };
  
  $scope.anyItemOpen = function() {
      return $scope.opened !== undefined;
  };
  
  $scope.close = function() {
      $scope.opened = undefined;
  };
  
})

.controller('VideoCtrl', function($scope, $cordovaSocialSharing, $cordovaFile, $localstorage, $stateParams, $http, $sce, History, Favorite,$timeout) {
    
   var id_face = $localstorage.getObject('user').id;

    //var id_face='123198231';

    var serverIp = window.localStorage.getItem('serverIp');

   /* $scope.download = function() {
      var url = "http://your_ip_address/images/my.jpg";
      var url = "http://animalia-life.com/data_images/dog/dog1.jpg";
      var filename = url.split("/").pop();
      alert(filename);
      var targetPath = cordova.file.dataDirectory + filename;
      alert("target path: "+targetPath);
      var trustHosts = true;
      var options = {};
      alert("cordova file dataDirectory "+cordova.file.dataDirectory);
      $cordovaFileTransfer.download(url, targetPath, options, trustHosts)
        .then(function(result) {
          // Success!
          alert("Resultado del file transfer "+ JSON.stringify(result));
        }, function(error) {
          // Error
          alert("Error de file transfer "+JSON.stringify(error));
        }, function (progress) {
          $timeout(function () {
            $scope.downloadProgress = (progress.loaded / progress.total) * 100;
          })
        });
   };*/

    

    $scope.download = function($cordovaFile){

    var url = "http://cdn.wall-pix.net/albums/art-space/00030109.jpg";
    var targetPath = cordova.file.applicationStorageDirectory + "testImage.png";
    //var targetPath = "/data/data/testImage.png";
    var trustHosts = true
    var options = {};
    alert("target path: "+ targetPath);
       $cordovaFileTransfer.download(url, targetPath, options, trustHosts)
      .then(function(result) {
        // Success!
        alert("success: "+ result);
      }, function(err) {
        // Error
        alert( "error: "+err);
      }, function (progress) {
        $timeout(function () {
          $scope.downloadProgress = (progress.loaded / progress.total) * 100;
          alert( "$scope.downloadProgress");
        })
      });


    };

    $http.get(serverIp +'videos/'+ $stateParams.id).success(function(data) {
            $scope.video = data;
            $scope.video.url_segura= $sce.trustAsHtml('<iframe width="250px" height="150px" side="center" src="'+$scope.video.url+'" frameborder="0" allowfullscreen></iframe>');
            
        });
    

    $scope.share= function(){

      $cordovaSocialSharing
      .shareViaFacebook("Mira este video en 360! Disfrutalo en realidad virtual con SenseIT", null,$scope.video.url)
      .then(function(result){
        alert('El video se compartio en Facebook');
      }, function(err){
        alert('Error al compartir el video en Facebook');
      });
    };

    $scope.reproducir = function(){

      var userHistory = new History();

      userHistory.id_facebook = id_face;
      userHistory.video_id = $scope.video.id;


      var dbResult = History.save(userHistory, function(){
        console.log('se guardo el historial con el resultado: ' + dbResult);
      });

    };

    $scope.favorito = function(){
      var favorito = new Favorite();

      favorito.id_facebook = id_face;
      favorito.video_id = $scope.video.id;

      var result = Favorite.save(favorito, function(){

        console.log(result.message);

      });

    };

  
})

.controller('BusquedaCtrl', function($scope, $stateParams, $sce){

  console.log('llegamos al controlador de busqueda');
  var videos = angular.fromJson($stateParams.videos);

  var len = videos.length;

  for(var i=0;i< len;i++)
  { 
    var src= videos[i].url; 


    videos[i].url = $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
    

  }

  $scope.videos = videos;

})


.controller('historialCtrl', function($scope,$http, $sce, $localstorage, $window){

    //busco id usuario en localStorage
    var id_face = $localstorage.getObject('user').id;

    //var id_face = '123198231';
    var serverIp = window.localStorage.getItem('serverIp');

    $http.get(serverIp +'histories/get-by-user/'+id_face).success(function(data) {
      $scope.historial = data;
      console.log(data);

      if(data.message == "el usuario no tiene user histories asociadas")
      {
        alert(data.message);
      }
      else
      {

      var len = $scope.historial.length;
      var j = 0;

      $scope.videos_historial = [];

      for(var i=0;i<len;i++)
      { 
        
        var idvideo = $scope.historial[i].video_id; 



        $http.get(serverIp +'videos/'+ idvideo).success(function(data) {
        $scope.videos_historial[j] = data;   
        var src = $scope.videos_historial[j].url;

        $scope.videos_historial[j].url= $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
        j++;
        if(j == len){
      
          console.log($scope.videos_historial);
        }
        });

      }

    }

            
});
   

  $scope.open = function(item){
  
       $state.go('app.video', { id: item.id});
    };
    
  $scope.isOpen = function(item){
      return $scope.opened === item;
  };
  
  $scope.anyItemOpen = function() {
      return $scope.opened !== undefined;
  };
  
  $scope.close = function() {
      $scope.opened = undefined;
  };

  $scope.doRefresh = function() {

    $http.get(serverIp +'histories/get-by-user/'+id_face)
     .success(function(data) {
             $scope.historial = data;
              if(data.message == "el usuario no tiene user histories asociadas"){
                alert(data.message);
              }else{

              var len = $scope.historial.length;
              var j = 0;
              $scope.videos_historial = [];
              for(var i=0;i<len;i++){ 
                var idvideo = $scope.historial[i].video_id; 
                $http.get(serverIp +'videos/'+ idvideo).success(function(data) {
                $scope.videos_historial[j] = data;   
                var src = $scope.videos_historial[j].url;
                $scope.videos_historial[j].url= $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
                j++;
                });
              }

            }
     })
     .finally(function() {
       // Stop the ion-refresher from spinning
       $scope.$broadcast('scroll.refreshComplete');
     });
  };

 
})

.controller('HomeCtrl', function($scope, $stateParams, $sce, $state, $http, $ionicModal, echo){

  var serverIp = window.localStorage.getItem('serverIp');

  if($scope.videos == null){
    //hacer query y pedir toodos los videos
     $http.get(serverIp +'videos').success(function(data) {
        $scope.videos = data.videos;
        var len = $scope.videos.length;

        for(var i=0;i< len;i++)
        { 
          var src= $scope.videos[i].url; 

          $scope.videos[i].url = $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
        }



        });


  };




  $scope.open = function(item){

       $state.go('app.video', { id: item.id});
    };
    
  $scope.isOpen = function(item){
      return $scope.opened === item;
  };
  
  $scope.anyItemOpen = function() {
      return $scope.opened !== undefined;
  };
  
  $scope.close = function() {
      $scope.opened = undefined;
  };

  $scope.buscar = function(){

          // Create the login modal that we will use later
      $ionicModal.fromTemplateUrl('templates/buscar.html', {
        scope: $scope,
        animation: 'slide-in-up'
      }).then(function(modal) {
        $scope.modal = modal;
        $scope.modal.show();
 
        });

  };

  $scope.results = [];
  $scope.findValue = function(enteredValue) {     
      
      $http.get(serverIp +'videos/search/'+enteredValue).success(function(data) {

        if(data.message == "no hay resultados para "+ enteredValue)
        {
          alert('No hay resultados para '+enteredValue);
        }
        else
        {

         $scope.modal.hide();
         var json = angular.toJson(data.videos, false);
         $state.go('app.busqueda', { videos: json});
        }

      });
    
  };


  $scope.reproducir = function(){

    //cordova.exec(function(winParam) {}, function(error) {}, "service","action", ["firstArgument", "secondArgument", 42,false]);
    window.echo("echome", function(echoValue) {
        alert(echoValue == "echome"); // should alert true.
    });


  };

})

.controller('FavoritosCtrl', function ($scope, $state, $localstorage, $http, $sce) {

  var id_face = $localstorage.getObject('user').id;
  var serverIp = window.localStorage.getItem('serverIp');

    $http.get(serverIp +'users/favourites/'+id_face).
    then(function(data) {
      // this callback will be called asynchronously
      // when the response is available
      $scope.lista_favoritos = data.data;
      var len = $scope.lista_favoritos.length;

      var j = 0;

      $scope.favoritos = [];

      for(var i=0;i<len;i++)
      { 
        
        var idvideo = $scope.lista_favoritos[i].video_id; 
        $http.get(serverIp +'videos/'+ idvideo).success(function(data) {
        $scope.favoritos[j] = data;   
        var src = $scope.favoritos[j].url;

        $scope.favoritos[j].url= $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
        j++;
        if(j == len){
          console.log($scope.favoritos);
        }
        });

      }

    }, function(response) {
      alert('no se encontraron favoritos de este usuario');
      $state.go('app.home');
    });

    $scope.doRefresh = function() {
      $http.get(serverIp +'videos/'+ idvideo)
       .success(function(data) {
          $scope.lista_favoritos = data.data;
          var len = $scope.lista_favoritos.length;
          var j = 0;
          $scope.favoritos = [];
          for(var i=0;i<len;i++){ 
            var idvideo = $scope.lista_favoritos[i].video_id; 
            $http.get(serverIp +'videos/'+ idvideo).success(function(data) {
            $scope.favoritos[j] = data;   
            var src = $scope.favoritos[j].url;
            $scope.favoritos[j].url= $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
            j++;
            });
          }
       })
       .finally(function() {
         // Stop the ion-refresher from spinning
         $scope.$broadcast('scroll.refreshComplete');
       });
    };

})


.controller('ProfileCtrl', function ($scope, $state, $localstorage, $ionicModal) {
  
  $scope.user = $localstorage.getObject('user');

  // Triggered in the login modal to close it
  $scope.closeLogin = function() {
    $scope.modal.hide();
  };

  $scope.fbLogout = function() {
  
    //delete local storage information
    $localstorage.deleteObject('user');
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
        //$state.go('app.home');
        $scope.modal.show();

    }) ;

  }
})