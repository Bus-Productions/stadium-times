(function(f){function l(g,h){function d(a){if(!e){e=true;c.start&&c.start(a,b)}}function i(a,j){if(e){clearTimeout(k);k=setTimeout(function(){e=false;c.stop&&c.stop(a,b)},j>=0?j:c.delay)}}var c=f.extend({start:null,stop:null,delay:400},h),b=f(g),e=false,k;b.keypress(d);b.keydown(function(a){if(a.keyCode===8||a.keyCode===46)d(a)});b.keyup(i);b.blur(function(a){i(a,0)})}f.fn.typing=function(g){return this.each(function(h,d){l(d,g)})}})(jQuery);

$(function() {

    $('.editable-post-field').typing({
        start: function (event, $elem) {
          $('#save-status').text('...saving...');
        },
        stop: function (event, $elem) {
          var id = $('#current-post-id').val();
          update_post(id);
        },
        delay: 1000
    });

    $('#top-title-div').bind('keypress', function(e) {
      if ((e.keyCode || e.which) == 13) {
        return false;
      }
    });

    $('#top-title-div').get(0).focus();

});

function update_post(id) {
  var url = '/posts/'+id+'.js';
  $.ajax({
    type: 'PUT',
    url: url,
    dataType: 'script',
    data: {
      post: {
        id: id,
        title: $('#top-title-span').text(),
        text: $('#body-text-div').html(),
      }
    }
  });
}

