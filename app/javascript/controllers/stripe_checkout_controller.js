import { Controller } from "@hotwired/stimulus"
// import { request } from '@rails/request.js'


// Connects to data-controller="stripe-checkout"
export default class extends Controller {
  static values = { publishableKey: String, url: String}
  async connect() {
    
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    const stripe = Stripe(this.publishableKeyValue)
    const response = await fetch(this.urlValue, {
      method: "POST", // or "POST", "PUT", "DELETE"
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken
      }
    })
    console.log(">>>>>>>>>>", csrfToken);
    
    const  clientSecret  = await response.json();
    
    const checkout = await stripe.initEmbeddedCheckout({
      clientSecret,
    });
    checkout.mount(this.element)
  }
}
