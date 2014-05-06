/* Controllers */

angular.module('myApp.controllers', [])

  .controller('AuthController', ['$scope', '$location', 'toerh', 'authService',
    function($scope, $location, toerh, authService) {

    $scope.index = function () {
      $location.url('/resources');
    };

    $scope.confirm = function() {
      authService.isLoggedIn = true;
      $scope.isLoggedIn = authService.isLoggedIn;

      var name = ($location.search()).name.replace('+', ' ');
      var auth = ($location.search()).auth_token;
      var expires = ($location.search()).token_expires;

      authService.userName = name;
      authService.userAuthToken = auth;
      authService.expires = expires;

      $scope.userName = authService.userName;

      $location.url('/resources');
    };

  }])

  .controller('ResourceListController', ['$scope', '$routeParams', '$location', 'toerhAPIservice', 'authService', 'flash', 'toerh',
    function($scope, $routeParams, $location, toerhAPIservice, authService, flash, toerh) {

    $scope.id = $routeParams.id;
    $scope.userName = authService.userName;
    $scope.resourceFilter = null;
    $scope.resources = [];
    $scope.paginatedResources = [];
    $scope.flash = flash;
    $scope.resourcesPerPage = toerh.paginateDefaultLimitValue;
    $scope.isLoggedIn = authService.isLoggedIn;
    $scope.userName = authService.userName;
    $scope.userAuthToken = authService.userAuthToken;
    $scope.expires = authService.expires;
    $scope.valid = authService.checkIfValid($scope.expires);
    $scope.resourceTypes = null;
    $scope.users = null;
    $scope.licences = null;

    $scope.amount = toerhAPIservice.getAll(toerh.resources);

    toerhAPIservice.getAll(toerh.resources).then(function(result){
      $scope.itemAmount = result.data.length;
      $scope.pages = Math.ceil($scope.itemAmount / $scope.resourcesPerPage);
    });

    /* GET resources */
    toerhAPIservice.getAll(toerh.resources).success(function (response) {
        var resources = response;
        var temp = [];
        for (var i = 0; i < toerh.paginateDefaultLimitValue; i++) {
          temp.push(resources[i]);
        }
        $scope.resources = temp;
    });

    // GET ResourceTypes
    toerhAPIservice.getAll(toerh.resourceTypes).success(function (response) {
      $scope.resourceTypes = response;
    });

    // GET Users
    toerhAPIservice.getAll(toerh.users).success(function (response) {
       $scope.users = response;
    });

    // GET Licences
    toerhAPIservice.getAll(toerh.licences).success(function (response) {
       $scope.licences = response;
    });

    var filter = "";

    $scope.filterByType = function(value) {
      $scope.licenceValue = "";
      $scope.userValue = "";

      filter = "?filter=true&type=" + value;

      if (value === null) {
        filter = "";
      }

      console.log(filter);

      toerhAPIservice.getFiltered(toerh.resources, filter).success(function (response) {
        $scope.resources = response;
      });
    };

    $scope.filterByUser = function(value) {
      $scope.typeValue = "";
      $scope.licenceValue = "";

      filter = "?filter=true&user=" + value;

      if (value === null) {
        filter = "";
      }

      toerhAPIservice.getFiltered(toerh.resources, filter).success(function (response) {
        $scope.resources = response;
      });
    };


    $scope.filterByLicence = function(value) {
      $scope.typeValue = "";
      $scope.userValue = "";

      filter = "?filter=true&licence=" + value;

      if (value === null) {
        filter = "";
      }

      toerhAPIservice.getFiltered(toerh.resources, filter).success(function (response) {
        $scope.resources = response;
      });
    };

    $scope.showAll = function(value) {
      /* GET resources */
      toerhAPIservice.getAll(toerh.resources).success(function (response) {
          var resources = response;
          var temp = [];
          for (var i = 0; i < toerh.paginateDefaultLimitValue; i++) {
            temp.push(resources[i]);
          }
          $scope.resources = temp;
      });
    };


    $scope.showNextSet = function(page) {
      var pageTrigger = page.$index+1;
      var limit = toerh.paginateDefaultLimitValue;
      var offsetValue = (pageTrigger * limit) - limit;

      toerhAPIservice.getSelection(toerh.resources, toerh.paginateDefaultLimitValue, offsetValue).success(function (response) {
        $scope.resources = response;
      });
    };

    $scope.searchFilter = function(data) {
      var keyword = new RegExp($scope.resourceFilter, 'i');
      return  !$scope.resourceFilter ||
              keyword.test(data.resource.info.title) ||
              keyword.test(data.resource.user.name) ||
              keyword.test(data.resource.info.resourceType);
    };

    $scope.showResource = function (resourceId) {
       $location.path('/resources/' + resourceId);
    };

    $scope.login = function() {
      window.location.href = toerh.callbackUri;
    };

    $scope.logout = function() {
      authService.isLoggedIn = false;
      authService.userName = "";
      authService.expires = 0;
      $scope.userName = authService.userName;
      $scope.isLoggedIn = authService.isLoggedIn;
      $location.path('/resources');
    };

    $scope.editResource = function(resourceId) {
      $location.path('/resources/' + resourceId + '/edit');
    };

    $scope.newResource = function() {
      $location.path('/resources/new');
    };

    $scope.deleteResource = function(resourceId, element) {

      var deleteConfirm = confirm('Are you sure you want to delete this resource?');

        if (deleteConfirm) {
          angular.element(element.target.parentNode).remove();

          toerhAPIservice.delete(toerh.resources, resourceId, $scope.userAuthToken).success(function (response) {
            $location.path('/resources');
          });

        }
    };
  }])

  .controller('ResourceDetailController', ['$scope', '$routeParams', '$location', 'toerhAPIservice', 'authService', 'toerh', 'flash',
    function($scope, $routeParams, $location, toerhAPIservice, authService, toerh, flash) {

    $scope.id = $routeParams.id;
    $scope.resource = null;
    $scope.flash = flash;
    $scope.baseUrl = $location.path;
    $scope.isLoggedIn = authService.isLoggedIn;
    $scope.expires = authService.expires;
    $scope.valid = authService.checkIfValid($scope.expires);

    /* GET resource by id */
    toerhAPIservice.getOne(toerh.resources, $scope.id).success(function (response) {
        $scope.resource = response.resource;
        $scope.tags = response.resource.tags;
    });

    $scope.editResource = function(resourceId) {
      $location.path('/resources/' + resourceId + '/edit');
    };
  }])

  .controller('ResourceEditController', ['$scope', '$routeParams', '$location', '$filter', 'toerhAPIservice', 'authService', 'toerh', 'flash',
    function($scope, $routeParams, $location, $filter, toerhAPIservice, authService, toerh, flash) {

    $scope.id = $routeParams.id;
    $scope.resource = null;
    $scope.formData = {};
    $scope.licenceFormData = {};
    $scope.resourceTypeFormData = {};
    $scope.tagFormData = {};
    $scope.flash = flash;
    $scope.message = "";
    $scope.isLoggedIn = authService.isLoggedIn;
    // $scope.isLoggedIn = true;

    $scope.expires = authService.expires;
    $scope.valid = authService.checkIfValid($scope.expires);
    $scope.userAuthToken = authService.userAuthToken;


    toerhAPIservice.getOne(toerh.resources, $scope.id).success(function (response) {
      $scope.resource = response.resource;
      $scope.resourceTags = response.resource.tags;

      $scope.formData.resource_type_id = response.resource.info.resourceTypeId;
      $scope.formData.licence_id = response.resource.info.licenceId;
      $scope.formData.user_id = response.resource.user.id;
      $scope.formData.name = response.resource.info.title;
      $scope.formData.description = response.resource.info.description;
      $scope.formData.url = response.resource.info.url;

      $scope.formData.tag = [];

      var tags = response.resource.tags;
      var tagArray = [];
      for (var i = 0; i < tags.length; i++) {
        // tagArray.push(" " + tags[i].tag.tagName);
        $scope.formData.tag.push(tags[i].tag.tagName);
      }

      // $scope.formData.tag = tagArray;

    });

    $scope.users = null;
    $scope.licences = null;
    $scope.resourceTypes = null;

    toerhAPIservice.getAll(toerh.users).success(function (response) {
       $scope.users = response;
    });

    toerhAPIservice.getAll(toerh.licences).success(function (response) {
       $scope.licences = response;
    });

    toerhAPIservice.getAll(toerh.resourceTypes).success(function (response) {
       $scope.resourceTypes = response;
    });

    $scope.updateResource = function() {
      toerhAPIservice.put(toerh.resources, $scope.id, $scope.formData, $scope.userAuthToken).success(function (response) {
        flash.setMessage("The resource has been updated!");
        $location.path('/resources/' + $scope.id);
      });
    };

    $scope.editLicences = function() {
      $scope.showLicences = true;
    };

    $scope.editResourceTypes = function() {
      $scope.showResourceTypes = true;
    };


    $scope.editTags = function() {
      $scope.showTags = true;
    };


    $scope.createLicence = function () {
      toerhAPIservice.post(toerh.licences, $scope.licenceFormData, $scope.userAuthToken).success(function (response) {
        $scope.message = "Updated";
      });
    };

    $scope.createResourceType = function () {
      toerhAPIservice.post(toerh.resourceTypes, $scope.resourceTypeFormData, $scope.userAuthToken).success(function (response) {
        $scope.message = "Updated";
      });
    };

    $scope.createTag = function () {

      $scope.formData.tag.push($scope.tagFormData.tag_name);

      toerhAPIservice.put(toerh.resources, $scope.id, $scope.formData, $scope.userAuthToken).success(function (response) {
        $scope.message = "Updated";
      });
    };

    $scope.hide = function () {
      $scope.message = "";
      $location.path('/resources/' + $scope.id +'/edit/');
    };

  }])

  .controller('ResourceNewController', ['$scope', '$routeParams', '$location', 'toerh', 'toerhAPIservice', 'authService', 'flash',
    function($scope, $routeParams, $location, toerh, toerhAPIservice, authService, flash) {

    $scope.id = $routeParams.id;
    $scope.formData = {};
    $scope.flash = flash;
    $scope.message = "";
    $scope.resource = null;
    $scope.isLoggedIn = authService.isLoggedIn;

    $scope.users = null;
    $scope.licences = null;
    $scope.resourceTypes = null;
    $scope.userAuthToken = authService.userAuthToken;

    toerhAPIservice.getAll(toerh.users).success(function (response) {
       $scope.users = response;
    });

    toerhAPIservice.getAll(toerh.licences).success(function (response) {
       $scope.licences = response;
    });

    toerhAPIservice.getAll(toerh.resourceTypes).success(function (response) {
       $scope.resourceTypes = response;
    });

    $scope.createResource = function() {

      toerhAPIservice.post(toerh.resources, $scope.formData, $scope.userAuthToken).success(function (response) {

        flash.setMessage("The resource has been created!");
        $location.path('/resources');
      });
    };

  }])

  .controller('LicenceEditController', ['$scope', '$routeParams', '$location', '$filter', 'toerhAPIservice', 'authService', 'toerh', 'flash',
    function($scope, $routeParams, $location, $filter, toerhAPIservice, authService, toerh, flash) {

    alert("licence!");

  }])

  .controller('tagsController', ['$scope', '$routeParams', 'toerhAPIservice',
    function($scope, $routeParams ,toerhAPIservice) {

    $scope.id = $routeParams.id;

  }]);



