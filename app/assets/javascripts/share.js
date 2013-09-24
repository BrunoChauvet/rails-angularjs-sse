var shareModule = angular.module('shares', []);

shareModule.factory('Shares', function() {
  return {};
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