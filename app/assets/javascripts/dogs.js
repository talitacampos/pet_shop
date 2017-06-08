petShop
  .controller('DogsController', ['$scope', '$http',
    function($scope, $http) {
      $scope.dogs = [];
      $scope.loading = true;
      $scope.hasError = false;
      $scope.filters = {
        query: '',
        genre: 'all',
        castrated: 'all',
        breed: 'all'
      };
      $scope.currentPage = 1;
      $scope.totalPages = 0;
      $scope.totalDogs = 0;
      $scope.refreshingTable = false;

      var consumeBackend = function(params) {
        $scope.refreshingTable = true;

        var config = {
          params: {}
        };

        if (params)
          config.params = angular.copy(params);

        config.params.page = $scope.currentPage;

        $http.get('/dogs', config)
          .then(function(response) {
            $scope.dogs = response.data.items;
            $scope.totalPages = response.data.pages;
            $scope.totalDogs = response.data.total;
          })
          .catch(function(error) {
            console.log('error', error);
            $scope.hasError = true;
          })
          .finally(function() {
            $scope.loading = false;
            $scope.refreshingTable = false;
          });
      };

      $scope.searchDogs = function() {
        var params = {};

        if ($scope.filters.query !== '')
          params.query = $scope.filters.query;

        if ($scope.filters.genre !== 'all')
          params.genre = $scope.filters.genre;

        if ($scope.filters.castrated !== 'all')
          params.castrated = $scope.filters.castrated === 'yes' ? true : false;

        if ($scope.filters.breed !== 'all')
          params.breed = $scope.filters.breed;

        // Return current page to first
        $scope.currentPage = 1;
        consumeBackend(params);
      };

      $scope.clearFilters = function() {
        $scope.filters = {
          query: '',
          genre: 'all',
          castrated: 'all',
          breed: 'all'
        };

        // Return current page to first
        $scope.currentPage = 1;
        consumeBackend();
      };

      $scope.previousPage = function() {
        $scope.currentPage--;
        consumeBackend();
      };

      $scope.nextPage = function() {
        $scope.currentPage++;
        consumeBackend();
      };

      $http.get('/dogs/breeds')
        .then(function(response) {
          $scope.breeds = response.data;
          consumeBackend();
        })
        .catch(function(error) {
          console.log('error', error);
          $scope.hasError = true;
          $scope.loading = false;
        });
    }
  ]);