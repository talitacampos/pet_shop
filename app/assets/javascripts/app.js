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

petShop
  .controller('DogsListController', ['$scope', '$http',
    function($scope, $http) {
      $scope.dogs = [];
      $scope.loading = true;
      $scope.hasError = false;

      $http.get('/dogs')
        .then(function(response) {
          $scope.dogs = response.data;
        })
        .catch(function(error) {
          console.log('error', error);
          $scope.hasError = true;
        })
        .finally(function() {
          $scope.loading = false;
        });
    }
  ]);