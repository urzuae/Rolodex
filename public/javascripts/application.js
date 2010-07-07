// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('#new_contact_form').live('submit', function() {
    var data_param = $(this).serialize();
    var url_action = $(this).attr('action');
    $.ajax({
      url: url_action,
      data: data_param,
      type: 'POST'
    });
    return false;
});

$('#edit_contact_form').live('submit', function() {
  var data_param = $(this).serialize();
  var url_action = $(this).attr('action');
  $.ajax({
    url: url_action,
    data: data_param,
    type: 'POST'
  });
  return false;
});

$('#new_group_form').live('submit', function() {
  var data_param = $(this).serialize();
  var url_action = $(this).attr('action');
  $.ajax({
    url: url_action,
    data: data_param,
    type: 'POST'
  });
  return false;
});