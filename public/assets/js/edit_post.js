(function(f){function l(g,h){function d(a){if(!e){e=true;c.start&&c.start(a,b)}}function i(a,j){if(e){clearTimeout(k);k=setTimeout(function(){e=false;c.stop&&c.stop(a,b)},j>=0?j:c.delay)}}var c=f.extend({start:null,stop:null,delay:400},h),b=f(g),e=false,k;b.keypress(d);b.keydown(function(a){if(a.keyCode===8||a.keyCode===46)d(a)});b.keyup(i);b.blur(function(a){i(a,0)})}f.fn.typing=function(g){return this.each(function(h,d){l(d,g)})}})(jQuery);

(function($) {
    $.extend($.fn, {
        makeCssInline: function() {
            this.each(function(idx, el) {
                var style = el.style;
                var properties = [];
                for(var property in style) { 
                    if($(this).css(property)) {
                        properties.push(property + ':' + $(this).css(property));
                    }
                }
                this.style.cssText = properties.join(';');
                $(this).children().makeCssInline();
            });
        }
    });
}(jQuery));


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

    $("#top-title-span").bind('copy', function() {
      $('#top-title-span').makeCssInline();
    });
    $("#body-text-div").bind('copy', function() {
      $('#body-text-div').makeCssInline();
    });
    $("#top-title-span").bind('cut', function() {
      $('#top-title-span').makeCssInline();
    });
    $("#body-text-div").bind('cut', function() {
      $('#body-text-div').makeCssInline();
    });

    $("#body-text-div").bind('paste', function() {
      $('#save-status').text('...saving...');
      setTimeout(function () {
        check_formatting_body();
        var id = $('#current-post-id').val();
        update_post(id);
      }, 0);
    });

    //$('#top-title-span').get(0).focus();


    var title_text_placeholder = 'Type your title'
    var title_text = $('#top-title-span').text();
    console.log(title_text);
    if (title_text == title_text_placeholder) {
      $('#top-title-span').css('color', 'grey');
      console.log('changed to grey');
    };
    $('#top-title-span').click(function () {

        console.log('click');

        var $this = $(this),
            text = $.trim($this.text());

        // Force cursor at the beginning
        if (text === title_text_placeholder) {
          console.log('force cursor');
            $this.text('');
            $this.focus();
            $this.text(title_text_placeholder);
        }
    });

    $('#top-title-span').keydown(function (event) {
      console.log('keydown');
        var $this = $(this),
            text = $.trim($this.text());

        var code = event.keyCode || event.which;
        if (code == '9') {
          console.log('tab pressed');
        }

        if (text === title_text_placeholder && code != '9') {
          console.log('keydown ==');
          console.log($this.text());
            $this.text('');
            $this.css('color', 'black');
        }
        console.log($this.text());
    });
    $('#top-title-span').keyup(function (event) {

      var $this = $(this);
      console.log($this.text());
      console.log('keyup');

        var $this = $(this),
            text = $.trim($this.text());

        if (text === '') {
          console.log('keyup ==');
            $this.text(title_text_placeholder);
            $this.css('color', 'grey');
        } else {
          check_formatting_title();
        }
        console.log($this.text());
        
    });

    $('#body-text-div').keyup(function (event) {
      check_formatting_body_typing();
    });


});

function check_formatting_title() {
  var text = $('#top-title-span').text();
  $('#top-title-span').find('a').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('hr').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('span').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h1').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h2').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h3').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h4').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h5').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h6').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h7').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h8').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h9').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('h10').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('b').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('i').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('header').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('footer').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('nav').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('section').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('frame').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('small').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('aside').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('article').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('p').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('table').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('tr').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('td').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('ul').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('li').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('ol').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('dt').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('dd').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('dl').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('form').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('iframe').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('audio').length > 0 ? replace_text(text) : 0;
  $('#top-title-span').find('video').length > 0 ? replace_text(text) : 0;
}

function replace_text(text) {
  $('#top-title-span').html(text);
}

function check_formatting_body() {

  if ($.trim($('#body-text-div').text()) == '') {
    $('#body-text-div').html('<p>Type here...</p>');
  }

  // $( '#body-text-div' ).contents().eq( '0' ).filter( function(){
  //     return this.nodeType != 1;
  // } ).wrap( '<p />' );

  // $( '#body-text-div' ).contents().each(function(){
  //   console.log($(this).html());
  //   console.log($(this).nodeType);
  //   if ($(this).nodeType == 3) {
  //     $(this).wrap('<p />');
  //   }
  // });

  $( "#body-text-div" )
  .contents()
    .filter(function() {
      return this.nodeType === 3;
    })
      .wrap( "<p></p>" )
      .end()
    .filter( "br" )
    .remove();

  var index = 0;
  var empties = [];
  $('article#body-text-div p').each(function(){
    // if ($.trim($(this).text())=='') {
    //   ++index;
    //   empties.push($(this));
    //   if (index > 3) {
    //     empties[0].remove();
    //   };
    // };
    $(this).removeAttr('style');
    $(this).removeAttr('name');
    $(this).removeAttr('class');
    $(this).find('a').removeAttr('style');
  });
  $('article#body-text-div blockquote').each(function(){
    $(this).removeAttr('style');
    $(this).removeAttr('name');
    $(this).removeAttr('class');
    $(this).find('a').removeAttr('style');
  });
  $('article#body-text-div span').each(function(){
    $(this).replaceWith($(this).text());
  });
  $('article#body-text-div div').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h1').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h2').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h3').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h4').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h5').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h6').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h7').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h8').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h9').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div h10').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div ul').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div li').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div dl').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div dt').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div dd').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div pre').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div article').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div section').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div header').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div footer').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div frame').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div table').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div tr').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div td').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div form').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div iframe').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div hr').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
  });
  $('article#body-text-div img').each(function(){
    $(this).remove();
  });
  $('article#body-text-div audio').each(function(){
    $(this).remove();
  });
  $('article#body-text-div video').each(function(){
    $(this).remove();
  });
}


function check_formatting_body_typing() {

  if ($.trim($('#body-text-div').text()) == '') {
    $('#body-text-div').html('');
    $('#body-text-div').prepend('<p>Type here...</p>');
  }

  // $( '#body-text-div' ).contents().eq( '0' ).filter( function(){
  //     return this.nodeType != 1;
  // } ).wrap( '<p />' );

  // $( '#body-text-div' ).contents().each(function(){
  //   console.log($(this).html());
  //   console.log($(this).nodeType);
  //   if ($(this).nodeType == 3) {
  //     $(this).wrap('<p />');
  //   }
  // });

  $( "#body-text-div" )
  .contents()
    .filter(function() {
      return this.nodeType === 3;
    })
      .wrap( "<p></p>" )
      .end()
    .filter( "br" )
    .remove();

  var index = 0;
  var empties = [];
  $('article#body-text-div p').each(function(){
    // if ($.trim($(this).text())=='') {
    //   ++index;
    //   empties.push($(this));
    //   if (index > 3) {
    //     empties[0].remove();
    //   };
    // };
    $(this).removeAttr('style');
    $(this).removeAttr('name');
    $(this).removeAttr('class');
    $(this).find('a').removeAttr('style');
  });
  $('article#body-text-div blockquote').each(function(){
    $(this).removeAttr('style');
    $(this).removeAttr('name');
    $(this).removeAttr('class');
    $(this).find('a').removeAttr('style');
  });
  $('article#body-text-div span').each(function(){
    $(this).replaceWith($(this).text());
  });
  $('article#body-text-div div').each(function(){
    var this_text = $(this).text();
    $(this).replaceWith("<p>"+this_text+"</p>");
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