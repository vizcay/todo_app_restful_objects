// Generated by CoffeeScript 1.8.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $((function(_this) {
    return function() {
      return _this.Tasks = (function(_super) {
        __extends(Tasks, _super);

        function Tasks() {
          _this.delete_all = __bind(_this.delete_all, this);
          return Tasks.__super__.constructor.apply(this, arguments);
        }

        Tasks.prototype.url = function() {
          return "" + (appServer.get('currentServer')) + "/services/Application/actions/get_all_tasks/invoke";
        };

        Tasks.prototype.model = Task;

        Tasks.prototype.parse = function(response) {
          var tasks;
          tasks = [];
          $(response.result.value).each(function(index, value) {
            return $.ajax(value.href, {
              async: false,
              success: function(task_response) {
                return tasks.push(task_response);
              }
            });
          });
          return tasks;
        };

        Tasks.prototype.delete_all = function() {
          return $.ajax({
            url: "" + (appServer.get('currentServer')) + "/services/Application/actions/clear_tasks/invoke",
            success: function() {
              return app.navigate('tasks_list', {
                trigger: true
              });
            }
          });
        };

        return Tasks;

      })(Backbone.Collection);
    };
  })(this));

}).call(this);
