// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


function cancelPostShare() {
  $("#new_post").empty();
  $("#share_button")[0].style.visibility = "visible";
  $("#share_button")[0].style.height = "auto";
}

function cancelPostEdit(index) {
  $("#edit_post_" + index).empty();
  $("#post_content_" + index)[0].style.visibility = "visible";
  $("#post_content_" + index)[0].style.height = "auto";
}

function cancelComment(index) {
  $("#new_comment_" + index).empty();
  $("#comment_button_" + index)[0].style.visibility = "visible";
  $("#comment_button_" + index)[0].style.height = "auto";
}

function cancelCommentEdit(index) {
  $("#edit_comment_" + index).empty();
  $("#comment_content_" + index)[0].style.visibility = "visible";
  $("#comment_content_" + index)[0].style.height = "auto";
}
