// Common jQuery and Javascript methods for all apps
// Requires facebox and flash renderer
//  (c) Joshua Lippiner 2009
//
$(document).ready(function() {

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
        complete: function (XMLHttpRequest, textStatus) {
        }
    })
    
    $('.spinner').hide()

    $('form[rel*=remote]').livequery('submit',function() {
        spinner = $(this).find('.spinner');
        spinner.show();
        
	      fb = $(this).closest("#facebox");
		    var y = {clearForm: true};
    		if($(this).find('#ajax_options').attr('value')!=undefined) eval("y = {" + $(this).find('#ajax_options').attr('value') + "}")
    		settings = jQuery.extend({
        	  dataType: 'json',
             success: function showResponse(responseText, statusText) {
                 if(fb!=null) 
                   if (responseText.eval) flash(responseText.flash,'#facebox');			// requires flash.js
                 else
                   if (responseText.eval) flash(responseText.flash);    // requires flash.js
                 if (responseText.eval) eval(responseText.eval.method);
                 spinner.hide();
             }
    		},y);

        $(this).ajaxSubmit(settings);

        return false;
    })
    
	$('a[rel*=remote]').livequery("click",function() {
	      fb = $(this).closest("#facebox")
        $.ajax({
            dataType: 'json',
			      url: this.href,
            success: function showResponse(responseText, statusText) {
                if(fb!=null) 
                  if (responseText.eval) flash(responseText.flash,'#facebox');			// requires flash.js
                else
                 if (responseText.eval) flash(responseText.flash);		// requires flash.js
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

})

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


