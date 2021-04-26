$(document).on('turbolinks:load', function () {
  $('#ask-button').click(function () {
    $('#ask-form').slideToggle(300);
    return false;
  });
});
