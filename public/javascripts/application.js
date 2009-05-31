// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {

    var keepImage;
    $('.rollover').hover(function() {
        var currentImg = $(this).find('img');
        keepImage = currentImg.attr('src').indexOf('_down')>0
        if(!keepImage) {
            log('over')
            var hoverImg = currentImg.attr('src').replace(/.gif/,'_down.gif');
            currentImg.attr('src', hoverImg);
            currentImg.attr('hover', currentImg.attr('src'));
        }
    }, function() {
        if(!keepImage) {
            var currentImg = $(this).find('img');
            var hoverImg = currentImg.attr('src').replace(/_down/,'');
            currentImg.attr('src', hoverImg);
            currentImg.attr('hover', currentImg.attr('src'));
        }
    });

    jQuery.fn.showFlash = function() {
        log(this.selector)
        $(this.selector).show('normal').fadeTo(5000, 1).fadeOut(2000)
    }

    $('#flash_messages').showFlash();

    $('#flash').click(function(){
        $('#flash').fadeOut(500);
    })

    jQuery.flash = {
        notice: function(message) {
            $('#flash_messages').html(message).addClass('notice').showFlash();
        },
        message: function(message) {
            $('#flash_messages').html(message).addClass('message').showFlash();
        },
        warning: function(message) {
            $('#flash_messages').html(message).addClass('warning').showFlash();
        },
        error: function(message) {
            log('error: ' + message)
            $('#flash_messages').html(message).addClass('error').showFlash();
        }
    }


    $('a[rel*=toggle]').bind('click', function(){
        var el = this;

        $('a[rel*=toggle]').each(function(){
            if (this.id!=el.id)
                $(this.id).hide();
        })

        $(this.id).toggle();
        return false;
    })

    $('a[rel*=toggle]').each(function(){
        $(this.id).hide();
    })

    $("label[rel*=checkit]").click(function(){
        cb = $(this).prev();
        $(cb).attr('checked', !$(cb).attr('checked'))
    })

});


function log(message, type) {
    if(type == null) {
        type = "log"
    }
    if(typeof(console) != "undefined" ) {
        console[type](message);
    } else {
        window.status = message;
    }
}


