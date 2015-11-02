angular.module('starter.controllers', ['starter.services', 'ngResource', 'plugin', 'ngRoute'])

.controller('AppCtrl', function($scope, $state, $ionicModal,$ionicPlatform, $localstorage, $cordovaOauth,  $cordovaSocialSharing, $ionicPopup, $http, $window, User) {

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
        //$scope.login();
      }
  
    });

   $scope.fbLogout = function() {
  
    //delete local storage information
    $localstorage.deleteObject('user');
    //delete scope user
    $scope.user = null;

    $scope.modal.show();

    } ;

  $scope.shareApp = function(){
   // $cordovaSocialSharing.share("This is your message", "This is your subject", "www/imagefile.png", "http://blog.nraboy.com")
      $cordovaSocialSharing
      .shareViaFacebook("Descargate SenseIT!", "www/img/logo.jpg", "www/img/logo.jpg");

  };

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
       
        $ionicPopup.alert({
          content: 'Login realizado con éxito'
        }).then(function(res) {
          console.log('error en el alert');
        });

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
             $scope.user = $localstorage.getObject('user');

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
                 $ionicPopup.alert({
                    content: 'Error al pedir datos del usuario.'
                  }).then(function(res) {
                    console.log('error en el alert');
                  });

        });

        $scope.modal.hide();
        $state.go('app.home');
    }, function(error) {
        $ionicPopup.alert({
          content: 'Hubo un problema al loguearse. Intente de nuevo.'
        }).then(function(res) {
          console.log('error en el alert');
        });
        console.log(error);
    });

}})

.controller('VideosCtrl', function($scope, $sce, $state, $http, $parse, $localstorage, $timeout, $ionicPopup, $ionicLoading, VideoNuevo, $ionicModal) {

  var id_face = $localstorage.getObject('user').id;
  var id_face = '10154179806703835';
  var serverIp = window.localStorage.getItem('serverIp');

  $scope.files = [
    { name: 'data', nativeURL: 'data', isDirectory: true, isFile: false },
    { name: 'media', nativeURL: 'media', isDirectory: true, isFile: false },
    { name: 'obb', nativeURL: 'obb', isDirectory: true, isFile: false },
    { name: 'Videos', nativeURL: 'Videos', isDirectory: true, isFile: false }

  ];

  $http.get(serverIp +'users/get_videos/'+id_face).
    then(function(data) {
      // this callback will be called asynchronously
      // when the response is available
      $scope.videos = data.data.videos;
      var len = $scope.videos.length;
      for(var i=0;i<len;i++)
      { 
        var src= $scope.videos[i].url; 
        $scope.videos[i].url= $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');

      }

    }, function(response) {

          $ionicPopup.alert({
            content: 'No se encontraron videos de este usuario.'
          }).then(function(res) {
            console.log('error en el alert');
          });

      
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

  $scope.download = function(){

      $ionicModal.fromTemplateUrl('templates/descargar.html', {
        scope: $scope,
        animation: 'slide-in-up'
      }).then(function(modal) {
        $scope.modal = modal;
        $scope.modal.show();
 
        });
  };

  $scope.upload = function(){


      $ionicModal.fromTemplateUrl('templates/subir.html', {
        scope: $scope,
        animation: 'slide-in-up'
      }).then(function(modal) {
        $scope.modal = modal;
        $scope.modal.show();
 
        });

  };

  $scope.getContents = function(path) {

    if(path == 'Videos'){
        $scope.files =[  
        { name: 'Videos viejos', nativeURL: 'Videos viejos', isDirectory: true, isFile: false },
        { name: 'Bernabeu', nativeURL: 'Bernabeu', isDirectory: false, isFile: true },
        { name: 'Airplane', nativeURL: 'Airplane', isDirectory: false, isFile: true },
        { name: 'Avicii', nativeURL: 'Avicii', isDirectory: false, isFile: true }
        ];
    };
    if(path == 'Bernabeu'){

      var videoNuevo = new VideoNuevo;
      videoNuevo.id_facebook = id_face;
      videoNuevo.title = "Bernabeu";
      videoNuevo.description = "Vive en carne propia el estadio del Real Madrid";
      videoNuevo.url = "https://www.youtube.com/embed/R5NlBydVDQg";
      
      var result = VideoNuevo.save(videoNuevo, function(){
            console.log('se creo el video '+result);
      }); 

      result.$promise.then(function(success){

        $ionicLoading.show({
          content: 'Loading',
          animation: 'fade-in',
          showBackdrop: true,
          maxWidth: 200,
          showDelay: 0,
          duration: 3800
        });

        setTimeout(function(){
             $ionicPopup.alert({
                content: 'Video subido exitosamente'
              }).then(function(res) {
                    //$ionicPoconsole.log('error en el alert '+res);
              });
         //your code to be executed after 1 seconds
        }, 4000);    

      }, function(failed){
        $ionicLoading.show({
            content: 'Loading',
            animation: 'fade-in',
            showBackdrop: true,
            maxWidth: 200,
            showDelay: 0,
            duration: 2800
          });

          setTimeout(function(){

           //your code to be executed after 1 seconds
          }, 3000);  
        });   
  
      $scope.modal.hide();
    };

    if(path == 'Airplane'){
  
      var videoNuevo = new VideoNuevo;
      videoNuevo.id_facebook = id_face;
      videoNuevo.title = "Airplane";
      videoNuevo.description = "Avion a helice que sigue muy de cerca a un F22 durante su vuelo";
      //videoNuevo.url = "https://www.youtube.com/embed/-RFjROsovWs";
      videoNuevo.url = "https://www.youtube.com/embed/LD4XfM2TZ2k";

      var result = VideoNuevo.save(videoNuevo, function(){
              console.log('se creo el video');
              });

      result.$promise.then(function(success){
        
        $ionicLoading.show({
          content: 'Loading',
          animation: 'fade-in',
          showBackdrop: true,
          maxWidth: 200,
          showDelay: 0,
          duration: 3800
        });

        setTimeout(function(){
              $ionicPopup.alert({
                content: 'Video subido exitosamente'
              }).then(function(res) {
                    //console.log('error en el alert '+res);
              });
         //your code to be executed after 1 seconds
        }, 4000);    

      }, function(failed){
        $ionicLoading.show({
            content: 'Loading',
            animation: 'fade-in',
            showBackdrop: true,
            maxWidth: 200,
            showDelay: 0,
            duration: 2800
          });

          setTimeout(function(){
                $ionicPopup.alert({
                  content: 'Error al subir el video'
                }).then(function(res) {
                      //console.log('error en el alert '+res);
                });
           //your code to be executed after 1 seconds
          }, 3000);  
        });   

      $scope.modal.hide();
    }    

    if(path == 'Avicii'){

      var videoNuevo = new VideoNuevo;
      videoNuevo.id_facebook = id_face;
      videoNuevo.title = "Avicii";
      videoNuevo.description = "Videoclip de Avicii Waiting for Love";
      videoNuevo.url = "https://www.youtube.com/embed/edcJ_JNeyhg";
      
      var result = VideoNuevo.save(videoNuevo, function(){
              console.log('se creo el video');
              });
      result.$promise.then(function(success){
        
        $ionicLoading.show({
          content: 'Loading',
          animation: 'fade-in',
          showBackdrop: true,
          maxWidth: 200,
          showDelay: 0,
          duration: 3800
        });

        setTimeout(function(){
              $ionicPopup.alert({
                content: 'Video subido exitosamente'
              }).then(function(res) {
                    //console.log('error en el alert '+res);
              });
         //your code to be executed after 1 seconds
        }, 4000);    

      }, function(failed){
        $ionicLoading.show({
            content: 'Loading',
            animation: 'fade-in',
            showBackdrop: true,
            maxWidth: 200,
            showDelay: 0,
            duration: 2800
          });

          setTimeout(function(){
                $ionicPopup.alert({
                  content: 'Error al subir el video'
                }).then(function(res) {
                      //console.log('error en el alert '+res);
                });
           //your code to be executed after 1 seconds
          }, 3000);  
        });   
   

      $scope.modal.hide();
    }   
  };

 $scope.doRefreshVideos = function() {

    $http.get(serverIp +'users/get_videos/'+id_face)
     .then(function(data) {
            $scope.videos = data.data.videos;
            var len = $scope.videos.length;

            for(var i=0;i<len;i++){ 
              var src= $scope.videos[i].url; 
              $scope.videos[i].url= $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');

            }
            $scope.$apply();

     })
     .finally(function() {
       // Stop the ion-refresher from spinning
       $scope.$broadcast('scroll.refreshComplete');
     });
  };

  $scope.descargarVideo = function(enteredValue){

      /*$ionicPopup.alert({
        content: 'Video en proceso de descarga'
      }).then(function(res) {
        console.log('error en el alert');
      });*/
      var input;
      enteredValue.split(input)[13];
      if(enteredValue == "https://youtu.be"){
        var i;
      };
      var input2 = enteredValue.match(/.{1,16}/g);

      if(input2[0] == "https://youtu.be")
      {
        var videoNuevo = new VideoNuevo;
        videoNuevo.id_facebook = id_face;
        videoNuevo.title = "Neimar Experience";
        videoNuevo.description = "Mueva su telefono para tomar el terreno de juego como el numero 10 de Brasil";
        videoNuevo.url = "https://www.youtube.com/embed/bBZhuqPRx9c";
        

        var result = VideoNuevo.save(videoNuevo, function(){
                console.log('se creo el video');
                });

        result.$promise.then(function(success){

        $ionicLoading.show({
          content: 'Loading',
          animation: 'fade-in',
          showBackdrop: true,
          maxWidth: 200,
          showDelay: 0,
          duration: 4800
        });

        setTimeout(function(){
              $ionicPopup.alert({
                content: 'Video descargado exitosamente'
              }).then(function(res) {
                    //console.log('error en el alert '+res);
              });
         //your code to be executed after 1 seconds
        }, 5000) } ,
        function(error){
            $ionicLoading.show({
            content: 'Loading',
            animation: 'fade-in',
            showBackdrop: true,
            maxWidth: 200,
            showDelay: 0,
            duration: 3800
          });

          setTimeout(function(){
                $ionicPopup.alert({
                  content: 'Error al descargar el video'
                }).then(function(res) {
                      //console.log('error en el alert '+res);
                });
           //your code to be executed after 1 seconds
          }, 4000);

        } );
        $scope.modal.hide();

      }
      else
      {
        $ionicPopup.alert({
          content: 'Por favor ingrese un link de youtube.'
        }).then(function(res) {
              //console.log('error en el alert '+res);
        });
      }

    
  };

  
})

.controller('VideoCtrl', function($scope, $cordovaSocialSharing, echo, $localstorage, $stateParams, $http, $ionicPopup, $sce, History, Favorite,$timeout) {
    
    var id_face = $localstorage.getObject('user').id;
    //Mi usuario de face
    //var id_face='10154179806703835';
    var serverIp = window.localStorage.getItem('serverIp');
    var ipUnity = window.localStorage.getItem('ipUnity');

    $http.get(serverIp +'videos/get-by-id/'+ $stateParams.id).success(function(data) {
            $scope.video = data;
            $scope.video.url_segura= $sce.trustAsHtml('<iframe width="100%" height="150px" src="'+$scope.video.url+'" frameborder="0" allowfullscreen></iframe>');
            
        });
    

    $scope.share= function(){

      $cordovaSocialSharing
      .shareViaFacebook("Mira este video en 360! Disfrutalo en realidad virtual con SenseIT", null,$scope.video.url);

    };

    $scope.reproducir = function(){

      var userHistory = new History();

      userHistory.id_facebook = id_face;
      userHistory.video_id = $scope.video.id;
      
      //Levantar cantidad de frames del server
      //var cantFrames = 2005;


      var dbResult = History.save(userHistory, function(){
        console.log('se guardo el historial con el resultado: ' + dbResult);
        $ionicPopup.alert({
          content: 'Se guardó el video en el historial.'
        }).then(function(res) {
          console.log('error en el alert');
        });
      });

      //Para q funcione
      //$scope.video.title = "Bernabeu1280";
      window.echo({"ip": ipUnity, "puerto": "3000", "nombre": $scope.video.folder_path, "frames":$scope.video.frames_count}, function(echoValue) {
        //alert(echoValue == "echome"); // should alert true.
      });


    };

    $scope.favorito = function(){
      var favorito = new Favorite();

      favorito.id_facebook = id_face;
      favorito.video_id = $scope.video.id;

      var result = Favorite.save(favorito, function(){

        console.log(result.message);
        $ionicPopup.alert({
          content: 'Se guardó el video en favoritos.'
        }).then(function(res) {
          console.log('error en el alert');
        });

      });

    };

  
})

.controller('BusquedaCtrl', function($scope, $stateParams, $sce, $state){

  var videos = angular.fromJson($stateParams.videos);

  var len = videos.length;

  for(var i=0;i< len;i++)
  { 
    var src= videos[i].url; 
    videos[i].url = $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
  }

  $scope.videos = videos;

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

})


.controller('historialCtrl', function($scope,$http, $sce, $state, $localstorage, $window){

    //busco id usuario en localStorage
    var id_face = $localstorage.getObject('user').id;
    //var id_face='10154179806703835';
    var serverIp = window.localStorage.getItem('serverIp');

    $http.get(serverIp +'histories/get-by-user-ordered-by-date/'+id_face).success(function(data) {
      $scope.historial = data;
      console.log(data);

      if(data.message == "el usuario no tiene user histories asociadas ")
      {
          $ionicPopup.alert({
            content: 'El usuario no tiene historial.'
          }).then(function(res) {
            console.log('error en el alert');
          });
      }
      else
      {

      var len = $scope.historial.length;
      var j = 0;

      $scope.videos_historial = [];

      for(var i=0;i<len;i++)
      { 
        
        var idvideo = $scope.historial[i].video_id; 

        $http.get(serverIp +'videos/get-by-id/'+ idvideo).success(function(data) {
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

    $http.get(serverIp +'histories/get-by-user-ordered-by-date/'+id_face)
     .success(function(data) {
             $scope.historial = data;
              if(data.message == "el usuario no tiene user histories asociadas "){
                  $ionicPopup.alert({
                    content: 'El usuario no tiene historial.'
                  }).then(function(res) {
                    console.log('error en el alert');
                  });
              }else{

              var len = $scope.historial.length;
              var j = 0;
              $scope.videos_historial = [];
              for(var i=0;i<len;i++){ 
                var idvideo = $scope.historial[i].video_id; 
                $http.get(serverIp +'videos/get-by-id/'+ idvideo).success(function(data) {
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

.controller('HomeCtrl', function($scope, $stateParams, $sce, $state, $http, $ionicModal, $window, $ionicPopup, $ionicPopover){

  var serverIp = window.localStorage.getItem('serverIp');

  if($scope.videos == null){
    //hacer query y pedir toodos los videos
     $http.get(serverIp +'videos').success(function(data) {
        $scope.videos = data.videos;
        var len = $scope.videos.length;

        for(var i=0;i< len;i++)
        { 
          var src= $scope.videos[i].url; 
          //var src = "http://img.youtube.com/vi/6uG9vtckp1U/mqdefault.jpg"
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
          $ionicPopup.alert({
            content: "No se encontraron resultados"
          }).then(function(res) {
            console.log('error en el alert');
          });
        }
        else
        {

         $scope.modal.hide();
         var json = angular.toJson(data.videos, false);
         $state.go('app.busqueda', { videos: json});
        }

      });
    
  };

  $ionicPopover.fromTemplateUrl('templates/reordenar.html', {
    scope: $scope,
  }).then(function(popover) {
    $scope.popover = popover;
  });

  $scope.closePopover = function() {
    var promise = $scope.popover.hide();
  };
  $scope.pedirVideosPopulares = function(){

    $http.get(serverIp +'videos/get-most-populars/').success(function(data) {
        $scope.videos = data.videos;
        var len = $scope.videos.length;

        for(var i=0;i< len;i++)
        { 
          var src= $scope.videos[i].url; 

          $scope.videos[i].url = $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
        }
       $scope.closePopover();
    });
    
  };

  $scope.pedirVideosFecha = function(){

    $http.get(serverIp +'videos/get-recents/').success(function(data) {
        $scope.videos = data.videos;
        var len = $scope.videos.length;
        for(var i=0;i< len;i++)
        { 
          var src= $scope.videos[i].url; 

          $scope.videos[i].url = $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
        }

        $scope.closePopover();

    });
  };

  $scope.doRefresh = function() {


    $http.get(serverIp +'videos/get-recents/').success(function(data) {
        $scope.videos = data.videos;
        var len = $scope.videos.length;
        for(var i=0;i< len;i++)
        { 
          var src= $scope.videos[i].url; 

          $scope.videos[i].url = $sce.trustAsHtml('<iframe width="250px" height="150px" src="'+src+'" frameborder="0" allowfullscreen></iframe>');
        }

    })       
    .finally(function() {
         // Stop the ion-refresher from spinning
         $scope.$broadcast('scroll.refreshComplete');
       });

  };

})

.controller('FavoritosCtrl', function ($scope, $state, $localstorage, $ionicPopup, $http, $sce) {

  var id_face = $localstorage.getObject('user').id;
  var serverIp = window.localStorage.getItem('serverIp');
 //var id_face='10154179806703835';
    $http.get(serverIp +'favourites/get-with-user/'+id_face).
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
        $http.get(serverIp +'videos/get-by-id/'+ idvideo).success(function(data) {
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
          $ionicPopup.alert({
            content: 'No se encontraron favoritos de este usuario.'
          }).then(function(res) {
            console.log('error en el alert');
          });
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
      $http.get(serverIp +'favourites/get-with-user/'+id_face)
       .then(function(data) {
          $scope.lista_favoritos = data.data;
          var len = $scope.lista_favoritos.length;
          var j = 0;
          $scope.favoritos = [];
          for(var i=0;i<len;i++){ 
            var idvideo = $scope.lista_favoritos[i].video_id; 
            $http.get(serverIp +'videos/get-by-id/'+ idvideo).success(function(data) {
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

});