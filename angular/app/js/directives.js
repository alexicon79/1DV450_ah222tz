/* Directives */

angular.module('myApp.directives', [])

.directive("customPagination", function($compile) {
  var addCurrentClass = function(scope, element, attrs) {
    var listItem = element[0];
    var firstItem = element[0].parentNode.children[0];

    firstItem.className = "current";

    angular.element(listItem).on("click", function() {
      var all = element[0].parentNode.children;
      for (var i = 0; i < all.length; i++) {
        all[i].className = "";
      };
      this.className = "current";
    });
  };
  return {
    restrict: "AE",
    link: addCurrentClass
  };
});
