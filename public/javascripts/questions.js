function limitChars(textid, limit, infodiv)
{
    var text = $('#'+textid).val();
    var textlength = text.length;
    if(textlength > limit)
    {
        $('#' + infodiv).html('0!');
        $('#'+ textid).val(text.substr(0,limit));
        return false;
    }
    else
    {
        $('#' + infodiv).html((limit - textlength));
        return true;
    }
}

$(function(){
    $('#answer_answer').keyup(function(){
        limitChars('answer_answer', 300, 'chars_left');
    }).focus();
});