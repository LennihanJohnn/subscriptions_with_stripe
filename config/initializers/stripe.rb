Stripe.api_key = STRIPE_SECRET

class RecordCharges
  def call(event)
    charge = event.data.object

    # Define subscriber behavior based on the event object
    #event.class       #=> Stripe::Event
    #event.type        #=> "charge.succeeded"
    #event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>

    #Lookup the user in our database
    user = User.find_by(stripe_id: charge.customer)

    #Record a charge in our database
    c = user.charges.where(stripe_id: charge.id).first_or_create
    c.update(
      amount: charge.amount,
      card_last4: charge.source.last4,
      card_brand: charge.source.brand,
      card_exp_month: charge.source.exp_month,
      card_exp_year: charge.source.exp_year
    )
  end
end

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', RecordCharges.new
end
