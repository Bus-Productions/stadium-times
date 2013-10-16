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

    $('#top-title-span').bind('keypress', function(e) {
      if ((e.keyCode || e.which) == 13) {
        return false;
      }
    });

    //$('#top-title-span').get(0).focus();


    var title_text_placeholder = 'Type your title'
    var title_text = $('#top-title-span').text();
    if (title_text == title_text_placeholder) {
      $('#top-title-span').css('color', 'grey');
    };
    $('#top-title-span').click(function () {
        var $this = $(this),
            text = $.trim($this.text());

        // Force cursor at the beginning
        if (text === title_text_placeholder) {
            $this.text('');
            $this.focus();
            $this.text(title_text_placeholder);
        }
    });

    $('#top-title-span').keydown(function (event) {
        var $this = $(this),
            text = $.trim($this.text());

        if (text === title_text_placeholder) {
            $this.text('');
            $this.css('color', 'black');
        }
    });
    $('#top-title-span').keyup(function (event) {

        check_formatting_title();

        var $this = $(this),
            text = $.trim($this.text());

        if (text === '') {
            $this.text(title_text_placeholder);
            $this.css('color', 'grey');
        }
    });

    $('#body-text-div').keyup(function (event) {
        check_formatting_body();        
    });


});

function check_formatting_title() {
  var text = $('#top-title-span').text();
  $('#top-title-span').html(text);
}

function check_formatting_body() {
  $('article#body-text-div p').each(function(){
    $(this).removeAttr('style');
    $(this).removeAttr('name');
    $(this).find('a').removeAttr('style');
  });
}

function save_post() {
  $('#save-status').text('...saving...');
  var id = $('#current-post-id').val();
  setTimeout(function() {
    update_post(id);
  }, 800);
}

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