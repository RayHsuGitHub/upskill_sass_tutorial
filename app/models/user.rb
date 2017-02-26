class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  has_one :profile
  
  attr_accessor :stripe_card_token
  # If Pro users passes validations (email, password, etc...)
  # then call stripe and tell stripe to set up a subcription upon charging
  # the customers card.
  # stripe responds back with customers data.
  # Store customer.id as customer token and save the user.
    def save_with_subscription
    
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
    end
end
