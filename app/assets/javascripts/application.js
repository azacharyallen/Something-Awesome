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
//= require jquery.bootstrap-growl.min
//= require bootbox.min
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

    setAlertTimers();
  }

  function displayMessage(message) {
        var $message = "<div class='alert alert-info alert-dismissable'>\
    <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>\
    <strong>"+ message + "</strong></div>";

    $('body').prepend($message);

    setAlertTimers();
  }

  function setAlertTimers(){
    window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
          $(this).remove();
      });
    }, 5000);
  }

  $(document).ready(function(){

    setAlertTimers();

    var top = $('#giant-info-button').offset().top - parseFloat($('#giant-info-button').css('marginTop').replace(/auto/, 0));
    $(window).scroll(function (event) {
      // what the y position of the scroll is
      var y = $(this).scrollTop();

      // whether that's below the form
      if (y >= top) {
        // if so, ad the fixed class
        $('#giant-info-button').addClass('fixed');
      } else {
        // otherwise remove it
        $('#giant-info-button').removeClass('fixed');
      }
    });

    $('#login-form').submit(function(event){
      event.preventDefault();
      var loginData = $(event.target).serializeJSON();
      $.ajax({
        url: "/session",
        method: "POST",
        data: loginData,
        success: function(response){
          if (response.success) {
            location.reload(true);
          } else {
            $('#login-form').trigger("reset");
            $('#sign-in-username-input').trigger("focus");
            displayError("Invalid Username and/or Password");
          }
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
      $(event.target.parentElement).prop('disabled', true);
      $(event.target.parentElement).toggleClass("disabled");
      // alert("Bookmarking a thread!");
      var state = event.currentTarget.dataset.state;
      var targetThread = event.currentTarget.dataset.threadId;

      if (state === "unmarked") {
        $.ajax({
          url: "/bookmarks",
          method: "POST",
          data: {bookmark: {post_thread_id: targetThread}},
          success: function(response){
          $.bootstrapGrowl("Bookmark Added!", {width: "auto"});
            $(event.target).toggleClass("glyphicon-star-empty glyphicon-star");
            $(event.target.parentElement).attr("data-state", "marked");
          },
          error: function(response){
            alert("Oh No!");
          },
          complete: function(response){
            $(event.target.parentElement).prop('disabled', false);
            $(event.target.parentElement).toggleClass("disabled");
          },
        });
      } else {
        $.ajax({
        url: "/bookmarks/" + targetThread,
        method: "DELETE",
        success: function(response){
          $.bootstrapGrowl("Bookmark Removed!", {width: "auto"});
          $(event.target).toggleClass("glyphicon-star-empty glyphicon-star");
          $(event.target.parentElement).attr("data-state", "unmarked");
        },
        error: function(response){
          alert("Oh No!");
        },
        complete: function(response){
          $(event.target.parentElement).prop('disabled', false);
          $(event.target.parentElement).toggleClass("disabled");
        },
      });
      }
    });

    $('body').on('click', '.pm-delete-button', function(event){
      event.preventDefault();
      $(event.target.parentElement).prop('disabled', true);
      var targetPM = event.currentTarget.dataset.id;

      bootbox.confirm("Are you sure?  Deleted PMs are gone FOREVER.", function(result){
        if (result){
          $.ajax({
            url: "/private_messages/" + targetPM,
            method: "DELETE",
            complete: function(response){
              location.reload(true);
            }
          });
        } else {
          $(event.target.parentElement).prop('disabled', false);
        }
      });
    });


    $('.close-thread-button').click(function(event){
      event.preventDefault();
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

    $('.page.current').parent().toggleClass('disabled');

    $('body').on('hidden.bs.modal', '.modal', function () {
      $(this).removeData('bs.modal');
    });
    
  });