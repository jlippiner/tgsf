// Common jQuery and Javascript methods for all apps
// Requires facebox and flash renderer
//  (c) Joshua Lippiner 2009
//
$(document).ready(function() {

    // $('a[rel*=facebox]').facebox()
    $('a[rel*=facebox]').livequery(function() {
        $(this).facebox()
    });

    $('a[rel*=facebox_no_close]').facebox().click(function() {
        $('#faceBoxClose').hide();
    })

    $('a[rel*=facebox]').livequery(function() {
        $(this).each(function(index, item) {
            try {
                $($(item).attr('href')).hide();
            } catch(err) {

                }
        })
    });

    $('a[rel*=facebox_no_close]').each(function(index, item) {
        $($(item).attr('href')).hide();
    });

    $(document).bind('reveal.facebox',
    function() {
        $('#faceBoxClose').show();
    })

    $(document).ajaxSend(function(event, request, settings) {
        if (settings.type == 'post') {
            settings.data = (settings.data ? settings.data + "&": "")
            + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
        }
    });

    jQuery.ajaxSetup({
        'beforeSend': function(xhr) {
            xhr.setRequestHeader("Accept", "text/javascript")
        },
        complete: function(XMLHttpRequest, textStatus) {
            }
    })

    $('.spinner').hide()

    $('form[rel*=remote]').livequery('submit',
    function() {
        spinner = $(this).find('.spinner');
        spinner.show();

        fb = $(this).closest("#facebox");
        var y = {
            clearForm: true
        };
        if ($(this).find('#ajax_options').attr('value') != undefined) eval("y = {" + $(this).find('#ajax_options').attr('value') + "}")
        settings = jQuery.extend({
            dataType: 'json',
            success: function showResponse(responseText, statusText) {
                if (fb.text()!='') {
                  flash(responseText.flash, '#facebox'); }
                else {
                  flash(responseText.flash); }
                  
                if (responseText.eval) eval(responseText.eval.method);
                
                spinner.hide();
                $("input").labelify({
                    labelledClass: "labelOverlay"
                });
            }
        },
        y);

        $(this).ajaxSubmit(settings);

        return false;
    })

    $('a[rel*=remote]').livequery("click",
    function() {
        fb = $(this).closest("#facebox")
        $.ajax({
            dataType: 'json',
            url: this.href,
            success: function showResponse(responseText, statusText) {
                if (fb != null)
                if (responseText.eval) flash(responseText.flash, '#facebox');
                // requires flash.js
                else
                if (responseText.eval) flash(responseText.flash);
                // requires flash.js
                if (responseText.eval) eval(responseText.eval.method);
            }
        });

        return false;
    })

    $.fn.extend({
        reset: function() {
            return this.each(function() {
                $(this).is('form') && this.reset();
            })
        }
    });

    $('select[rel*=autopost]').livequery("change",
    function() {
        if (this.value != '') this.form.submit();
    });

    $.fn.autoPost = function() {
        $(this.selector).change(function() {
            this.form.submit();
        })
    }

    $('a[rel*=toggle]').bind('click',
    function() {
        var el = this;

        $('a[rel*=toggle]').each(function() {
            if (this.id != el.id)
            $(this.id).hide();
        })

        $(this.id).toggle();
        return false;
    })

    $('a[rel*=toggle]').each(function() {
        $(this.id).hide();
    })

    $("label[rel*=checkit]").click(function() {
        cb = $(this).prev();
        $(cb).attr('checked', !$(cb).attr('checked'))
    })

    $('.load_me').each(function() {
        url = $(this).attr('rel');
        $(this).load(url).show();
    });

    $.extend($.fn.disableTextSelect = function() {
        return this.each(function() {
            if ($.browser.mozilla) {
                //Firefox
                $(this).css('MozUserSelect', 'none');
            } else if ($.browser.msie) {
                //IE
                $(this).bind('selectstart',
                function() {
                    return false;
                });
            } else {
                //Opera, etc.
                $(this).mousedown(function() {
                    return false;
                });
            }
        });
    });


    reset_class_overrides()

})

 function reset_class_overrides() {
    $("input[type='text']:first", document.forms[0]).focus();
}

function log(message, type) {
    if (type == null) {
        type = "log"
    }
    if (typeof(console) != "undefined") {
        console[type](message);
    } else {
        window.status = message;
    }
}


