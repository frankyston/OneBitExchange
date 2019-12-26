$(document).ready ->

  $('#amount').keyup ->
    value = $(this).val()
    source_currency = $("#source_currency").val()
    target_currency = $("#target_currency").val()
    console.log(value)
    if value != "" && target_currency != "BITCOIN"
      ajax_currency(value)
    else
      ajax_bitcoin(value, source_currency)


  $("#reverse").click (event) ->
    event.preventDefault()
    source_currency_element = $("#source_currency")
    target_currency_element = $("#target_currency")

    new_source_currency_val = target_currency_element.val()
    new_target_currency_val = source_currency_element.val()

    source_currency_element.val(new_source_currency_val)
    target_currency_element.val(new_target_currency_val)

  ajax_currency = (value) ->
    $.ajax '/convert',
      type: 'GET'
      dataType: 'json'
      data: {
              source_currency: $("#source_currency").val(),
              target_currency: $("#target_currency").val(),
              amount: value
            }
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').val(data.value)
    return false;

  ajax_bitcoin = (value, currency) ->
    $.ajax 'https://blockchain.info/tobtc?currency='+currency+'&value='+value,
      type: 'GET'
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').val(data)
    return false;