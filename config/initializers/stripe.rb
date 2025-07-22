# config/initializers/stripe.rb
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)


# Stripe.api_key = ENV['STRIPE_SECRET_KEY']
# Stripe.api_version = '2020-08-27'
# Stripe.set_app_info(
#   'stripe-samples/checkout-one-time-payments',
#   version: '0.0.1',
#   url: 'https://github.com/stripe-samples/checkout-one-time-payments'
# )


