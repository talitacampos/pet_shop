var petShop = angular
  .module('petShop', [
    'templates',
    'ngRoute'
  ])
  .config(['$routeProvider',
    function($routeProvider) {
      // When the angularjs is loaded, the loading should be
      // removed and the class with the main content of the
      // screen displayed. Therefore, the following two lines
      angular.element('.loading').addClass("hidden");
      angular.element('.main-content').removeClass("hidden");

      $routeProvider
        .when('/', {
          templteUrl: 'index.html'
        });
    }
  ]);