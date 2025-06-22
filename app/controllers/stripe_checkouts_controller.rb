class StripeCheckoutsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: book.title,
          },
          unit_amount: book.price,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: book_url(book), # Redirect after successful payment
      cancel_url: books_url,       # Redirect if user cancels
    )

    redirect_to session.url, allow_other_host: true
  end
end
