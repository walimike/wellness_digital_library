class StripeCheckoutsController < ApplicationController
  def create
  book = Book.find(params[:id]) # instead of params[:book_id]

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
    success_url: "#{stripe_success_url}?session_id={CHECKOUT_SESSION_ID}",
    cancel_url: checkout_book_url(book)
  )

  BookPurchase.create!(
    user: current_user,
    book: book,
    stripe_session_id: session.id,
    paid: false
  )

  redirect_to session.url, allow_other_host: true
end


  def cancel
    redirect_to root_url, notice: "Purchase Unsuccessful"
  end

  def success
    puts ">>>>>>>>>>>>>>>>>>>> start getting success guy"
    redirect_to root_url, notice: "Purchase Successful"
  end


 

end
