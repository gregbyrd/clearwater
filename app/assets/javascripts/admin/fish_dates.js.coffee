# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

AddDate =
  replace_html: () ->
    $('#newdate').html('<input type="text" name="datestr" id="pick">')
    elt = $('#newdate')
    $('#pick').datepicker({dateFormat: 'yy-mm-dd', maxDate: elt.data('max-date'), minDate: elt.data('min-date'), defaultDate: elt.data('default-date')})

$(AddDate.replace_html)


