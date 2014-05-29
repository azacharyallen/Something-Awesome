// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require serializeJSON
//= require_tree .

  function displayError(message) {
    var $error = "<div class='alert alert-danger alert-dismissable'>\
    <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>\
    <strong>"+ message + "</strong></div>";

    if ($('.alert').length === 1) {
      $('.alert').replaceWith($error);
    } else {
      $('body').prepend($error);
    }

  }

  function displayMessage(message) {
        var $message = "<div class='alert alert-info alert-dismissable'>\
    <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>\
    <strong>"+ message + "</strong></div>";

    $('body').prepend($message);
  }

  $(document).ready(function(){
    $('#login-form').submit(function(event){
      event.preventDefault();
      var loginData = $(event.target).serializeJSON();
      $.ajax({
        url: "/session",
        method: "POST",
        data: loginData,
        success: function(response){
          location.reload(true);
        },
        error: function(response){
          $('#login-form').trigger("reset");
          displayError("Invalid Username and/or Password");
        },
      });
    });

    $('#sign-out-button').click(function(event){
      event.preventDefault();
      $.ajax({
        url: "/session",
        method: "DELETE",
        complete: function(response){
          //show goodbye message here
          location.reload(true);
        },
      });
    });

    $('body').on('click', '.bookmark-button', function(event){
      event.preventDefault();
      // alert("Bookmarking a thread!");
      var state = event.currentTarget.dataset.state;
      var targetThread = event.currentTarget.dataset.threadId;
      $(event.target.parentElement).toggleClass("disabled");

      if (state === "unmarked") {
        $.ajax({
          url: "/bookmarks",
          method: "POST",
          data: {bookmark: {post_thread_id: targetThread}},
          success: function(response){
            $(event.target).toggleClass("glyphicon-star-empty glyphicon-star");
            $(event.target.parentElement).attr("data-state", "marked");
          },
          error: function(response){
            alert("Oh No!");
          },
          complete: function(response){
            $(event.target.parentElement).toggleClass("disabled");
          },
        });
      } else {
        $.ajax({
        url: "/bookmarks/" + targetThread,
        method: "DELETE",
        success: function(response){
          $(event.target).toggleClass("glyphicon-star-empty glyphicon-star");
          $(event.target.parentElement).attr("data-state", "unmarked");
        },
        error: function(response){
          alert("Oh No!");
        },
        complete: function(response){
          $(event.target.parentElement).toggleClass("disabled");
        },
      });
      }
    });

    $('.close-thread-button').click(function(event){
      event.preventDefault();
      // alert("Closing thread!");
      var id = event.currentTarget.dataset.id;
      $.ajax({
        url: "/post_threads/" + id,
        method: "PATCH",
        data: {post_thread: {closed: true}},
        success: function(response) {
          location.reload(true);
        },
        error: function(response) {
          location.reload(true);
        }
      });
    });

    $('.open-thread-button').click(function(event){
      event.preventDefault();
      // alert("Closing thread!");
      var id = event.currentTarget.dataset.id;
      $.ajax({
        url: "/post_threads/" + id,
        method: "PATCH",
        data: {post_thread: {closed: false}},
        success: function(response) {
          location.reload(true);
        },
        error: function(response) {
          location.reload(true);
        }
      });
    });

    $('blockquote').toggleClass("well well-lg");

    $('body').on('hidden.bs.modal', '.modal', function () {
      $(this).removeData('bs.modal');
    });
    
  });