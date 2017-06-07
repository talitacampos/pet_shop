var petShop = angular.module('petShop', [
  'templates',
  'ngRoute'
]);

petShop
  .config(['$routeProvider',
    function($routeProvider) {
      $routeProvider
        .when('/', {
          templteUrl: 'index.html'
        });
    }
  ]);