# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

set_date = (text, picker) ->
  alert("setting date to #{text}")
  $('#datestr').val(text)

AddDate =
  replace_html: () ->
    $('#newdate').html('<div id="pick"></div><input type="hidden" name="datestr" id="datestr">')
    elt = $('#newdate')
    $('#pick').datepicker({dateFormat: 'yy-mm-dd', maxDate: elt.data('max-date'), minDate: elt.data('min-date'), defaultDate: elt.data('default-date'), onSelect: set_date })


$(AddDate.replace_html)


