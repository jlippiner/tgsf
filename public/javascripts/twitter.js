$(function(){
  $('#box').corners();
  
  $("input[type='text']:first", document.forms[0]).focus();
  
  $('#tweet_form').submit(function(){
    $('#submit').hide();
    $('#please_wait').show();
    
    return true;
  })
})