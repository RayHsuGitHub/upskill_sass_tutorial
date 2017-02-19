/* global $, Stripe */
//Document ready
$(document).on('turbolinks:load',function(){
  
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn')
  
  //Set stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  //When user clicks form submit btn
  submitBtn.click(function(event){
    //Prevent default submissions behavior.
    event.preventDefault();
    
  //Collect the credit card fields.
  var ccNum = $('#card_number').val(),
      cvcNum = $('#card_code').val(),
      expMonth = $('#card_month').val(),
      expYear = $('#card_year').val();
      
  //Send the card information to Stripe.
  Stripe.createToken({
    number:ccNum,
    cvc: cvcNum,
    exp_month: expMonth,
    exp_year: expYear
   }, stripeResponseHandler);
  });
  
  
  //Collect the credit card fields.
  //Send the card information to Stripe.
  //Stripe will return back a card token.
  //Inject card token as hidden field into form.
  //Submit form to our Rails App.
});