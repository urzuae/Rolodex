$(function() {

  $('.add_new_element').each(function() {
    var url_action = '/' + $(this).attr('name') + '/display_new';
    $(this).click(function() {
      $.ajax({
        url: url_action,
        type: 'post'
      });
      return false;
    });
  });

  $('.element_form').live('submit', function() {
    var data_param = $(this).serialize();
    var url_action = $(this).attr('action');
    $.ajax({
      url: url_action,
      data: data_param,
      type: 'POST'
    });
    return false;
  });

  $('.contact_link').live('click', function() {
    var url_action = '/contacts/display_contact/' + $(this).attr('id');
    var data_param = $(this).attr('id');
    $.ajax({
      url: url_action,
      data: data_param,
      type: 'POST'
    });
    return false;
  });

  $('.group_link').live('click', function() {
    var url_action = '/groups/show_contacts/' + $(this).attr('id');
    var data_param= $(this).attr('id');
    $.ajax({
      url: url_action,
      data: data_param,
      type: 'POST'
    });
    return false;
  });

  $('.delete_contact').live('click', function() {
    var data_param = $(this).attr('id');
    var url_action = '/contacts/destroy_single_contact/' + data_param;
    $.ajax({
      url: url_action,
      data: data_param,
      type: 'POST'
    });
    return false;
  });

  $('.edit_contact_btn').live('click', function() {
    var data_param = $(this).attr('id');
    var url_action = '/contacts/display_edit/' + data_param;
    $.ajax({
      url: url_action,
      data: data_param,
      type: 'post'
    });
    return false;
  });

  $('#select_all').click(function() {
    $(':checkbox').attr('checked', 'checked');
  });
  $('#select_none').click(function() {
    $(':checkbox').removeAttr('checked');
  });
  
  $('#all_contacts').click(function () {
    $.ajax({
      url: '/contacts/show_all_contacts',
      type: 'post'
    });
    return false;
  });
  
  $('#searching').keyup(function() {
    var url_action = '/contacts/show_filtered/';
    var data_param = {data_param: $(this).val()};
    $.ajax({
      url: url_action,
      data: data_param,
      type: 'post',
      dataType: "json",
      success: function(response) {
        $('#results_container').text("");
        for(var i=0;i < response.length ;i++){
          $('#results_container').append('<div>' + response[i].contact.name + '</div>');
        }
      }
    });
    return false;
  });
  
});