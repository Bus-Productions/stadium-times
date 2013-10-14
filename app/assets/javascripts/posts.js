
$(function() {
    $( ".editable-post-field" ).keyup(function() {
      var id = $('#current-post-id').val();
      update_post(id);
    });
});

function update_post(id) {
  var url = '/posts/'+id+'.js';
  $.ajax({
    type: 'PUT',
    url: url,
    dataType: 'JSON',
    data: {
      post: {
        id: id,
        title: $('#top-title-div').html(),
        text: $('#body-text-div').html(),
      }
    }
  });
}