$.validator.addMethod("custom_email_validation", function(value, element)
  {
    var email_regex = new RegExp(/\A[^@\s]+@getmainstreet.com/i)
    
    if (value.length == 0 ) return true;
    let match = /^[^@\s]+@getmainstreet.com$/i.test(value)
      if (match)
      {
        return true;
      }
      else
      {
        return false;
      }
  });