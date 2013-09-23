var shareModule = angular.module('shares', ['ngResource']);

shareModule.factory('Shares', function($resource) {
  return $resource('/shares/:id');
});

shareModule.controller('SharesCtrl', function($scope, Shares) {

  $scope.init = function() {
    var source = new EventSource('/shares');
    source.onmessage = function(event) {
      $scope.$apply(function () {
        $scope.entries = JSON.parse(event.data)
      });
    };
  };

});