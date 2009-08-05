$(function(){
  $('#box').corners();
  
  $("input[type='text']:first", document.forms[0]).focus();
  
  $('#tweet_form').submit(function(){
    $('#submit').html('<b>Please wait.  This will take a minute or two...</b><p><img src="/images/spinner.gif"/></p>')
    
    return true;
  })
})