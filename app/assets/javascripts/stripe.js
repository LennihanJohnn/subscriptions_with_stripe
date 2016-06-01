function stripeResponseHandler(status, response) {

  if (response.error) { // Problem!

    // Show the errors on the form:
    $('#payment-form').find('.payment-errors').text(response.error.message);
    $('#payment-form').find('.submit').prop('disabled', false); // Re-enable submission

  } else { // Token was created!

    // Get the token ID:
    var token = response.id;

    // Insert the token ID into the form so it gets submitted to the server:
    $('#payment-form').append($('<input type="hidden" name="stripeToken">').val(token));

    $('#payment-form').append($('<input type="hidden" name="card_last4">').val(response.card.last4));
    $('#payment-form').append($('<input type="hidden" name="card_exp_month">').val(response.card.exp_month));
    $('#payment-form').append($('<input type="hidden" name="card_exp_year">').val(response.card.exp_year));
    $('#payment-form').append($('<input type="hidden" name="card_brand">').val(response.card.brand));

    // Submit the form:
    $('#payment-form').get(0).submit();
  }
};

$(document).on('ready page:change', function() {
  Stripe.setPublishableKey($("meta[name='stripe-key']").attr("content"));
  $('#payment-form').submit(function(event) {
    // Disable the submit button to prevent repeated clicks:
    $(this).find('.submit').prop('disabled', true);

    // Request a token from Stripe:
    Stripe.card.createToken($(this), stripeResponseHandler);

    // Prevent the form from being submitted:
    return false;
  });
})
