# app/controllers/stripe_checkouts_controller.rb
class StripeCheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create]

  # def config
  #   price = 5
  #   render json: {
  #     publicKey: ENV['STRIPE_PUBLISHABLE_KEY'],
  #     unitAmount: price,
  #     currency: 'USD'
  #   }
  # end

  def checkout_session
    session_id = params[:sessionId]
    session = Stripe::Checkout::Session.retrieve(session_id)
    render json: session
  end

  def success
  end

  def create
      session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: [{
        price: "price_1Rcp7BQwcAe6QheoqiE2Bk2p",
        quantity: 1,
      }],
      mode: 'payment',
      return_url: stripe_success_path,
    })

    puts "XXXXXXXXXXXXXXXXX", session
    # redirect_to session.url, allow_other_host: true, status: :see_other

    render json: {clientSecret: session.client_secret}
  end

  def webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    webhook_secret = ENV['STRIPE_WEBHOOK_SECRET']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, webhook_secret)
    rescue JSON::ParserError => e
      render json: { error: 'Invalid payload' }, status: 400 and return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.warn '⚠️  Webhook signature verification failed.'
      render json: { error: 'Invalid signature' }, status: 400 and return
    end

    case event.type
    when 'checkout.session.completed'
      Rails.logger.info '🔔 Payment succeeded!'
      # You can handle order creation, email sending, etc. here.
    end

    render json: { status: 'success' }
  end
end
