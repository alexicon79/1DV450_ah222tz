
// Declare app level module which depends on filters, and services
angular.module('myApp', [
  'ngRoute',
  'ngCookies',
  'myApp.filters',
  'myApp.services',
  'myApp.directives',
  'myApp.controllers'
]).
config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider.when('/authenticated', {templateUrl: 'partials/auth.html', controller: 'AuthController'});
  $routeProvider.when('/resources', {templateUrl: 'partials/resources.html', controller: 'ResourceListController'});
  $routeProvider.when('/resources/new', {templateUrl: 'partials/resource-new.html', controller: 'ResourceNewController'});
  $routeProvider.when('/resources/:id', {templateUrl: 'partials/resource.html', controller: 'ResourceDetailController'});
  $routeProvider.when('/resources/:id/edit', {templateUrl: 'partials/resource-edit.html', controller: 'ResourceEditController'});
  $routeProvider.when('/users', {templateUrl: 'partials/users.html', controller: 'UsersController'});
  $routeProvider.otherwise({redirectTo: '/resources'});

  $locationProvider
  .html5Mode(false);
}])
.constant('toerh', {
    appAuthToken: '19dc569a484de5286e3a7141b4ba8c6c',
    baseUri: 'http://127.0.0.1:3000/api/v1/',
    callbackUri: 'http://127.0.0.1:3000/authenticate?callback=http://127.0.0.1:8000/app/index.html',
    paginateLimitKey: "?limit=",
    paginateDefaultLimitValue: 8,
    paginateOffsetKey: "&offset=",
    resources: 'resources',
    users: 'users',
    licences: 'licences',
    tags: 'tags',
    resourceTypes: 'resource_types'
});
