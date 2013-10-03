/**
 * Javascript run on each load.
 */
$(document).ready(function() {

    // Make all external links open in new window
    $('a').each(function() {
       var regex = new RegExp('/' + window.location.host + '/');
       if(!regex.test(this.href)) {
           $(this).attr('target', '_blank');
       }
    });
});
