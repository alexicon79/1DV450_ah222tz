/* Services */

angular.module('myApp.services', [])

.factory('authService', function () {

  var auth = {};

  auth.isLoggedIn = false;
  auth.userName = "";
  auth.userAuthToken = "";
  auth.expires = 0;

  auth.checkIfValid = function(number) {
    if (Date.now() < number) {
      return true;
    } else {
      return false;
    }
  };

  return auth;
})

.factory('toerhAPIservice', ['$http', 'toerh', function($http, toerh) {

  var toerhAPI = {};

  toerhAPI.getAll = function(resourceUri) {
    return $http({
      url: toerh.baseUri + resourceUri,
      method: 'GET',
      isArray: true,
      headers: {
        'APP-AUTH-TOKEN': toerh.appAuthToken
      }
    });
  };

  toerhAPI.getFiltered = function(resourceUri, filterUri) {
    return $http({
      url: toerh.baseUri + resourceUri + filterUri,
      method: 'GET',
      isArray: true,
      headers: {
        'APP-AUTH-TOKEN': toerh.appAuthToken
      }
    });
  };

  toerhAPI.getSelection = function(resourceUri, limit, offset) {

    return $http({
      url: toerh.baseUri + resourceUri + toerh.paginateLimitKey + limit + toerh.paginateOffsetKey + offset,
      method: 'GET',
      isArray: true,
      headers: {
        'APP-AUTH-TOKEN': toerh.appAuthToken
      }
    });
  };


  toerhAPI.getOne = function(resourceUri, id) {
    return $http({
      url: toerh.baseUri + resourceUri + '/' + id,
      method: 'GET',
      headers: {
        'APP-AUTH-TOKEN': toerh.appAuthToken
      }
    });
  };

  toerhAPI.put = function(resourceUri, id, params, userAuthToken) {
    return $http({
      url: toerh.baseUri + resourceUri + '/' + id,
      method: 'PUT',
      data: params,
      isArray: false,
      headers: {
        'APP-AUTH-TOKEN': toerh.appAuthToken,
        'Content-Type': 'application/json',
        'USER-AUTH-TOKEN': userAuthToken
      }
    });
  };

  toerhAPI.post = function(resourceUri, params, userAuthToken) {
    return $http({
      url: toerh.baseUri + resourceUri,
      method: 'POST',
      data: params,
      isArray: false,
      headers: {
        'APP-AUTH-TOKEN': toerh.appAuthToken,
        'Content-Type': 'application/json',
        'USER-AUTH-TOKEN': userAuthToken
      }
    });
  };

  toerhAPI.delete = function(resourceUri, id, userAuthToken) {
    return $http({
      url: toerh.baseUri + resourceUri + '/' + id,
      method: 'DELETE',
      headers: {
        'APP-AUTH-TOKEN': toerh.appAuthToken,
        'Content-Type': 'application/json',
        'USER-AUTH-TOKEN': userAuthToken
      }
    });
  };

  return toerhAPI;
}])

.factory("flash", function($rootScope) {
  var queue = [];
  var currentMessage = "";

  $rootScope.$on("$routeChangeSuccess", function() {
    currentMessage = queue.shift() || "";
  });

  return {
    setMessage: function(message) {
      queue.push(message);
    },
    getMessage: function() {
      return currentMessage;
    }
  };
});
