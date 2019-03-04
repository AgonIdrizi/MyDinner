require 'rails_helper'

RSpec.feature "User can't do a checkout", type: :feature do
  
  scenario "with empty cart" do
    
  	visit root_path

  	visit cart_path

    click_on 'Checkout'

    expect(page).to have_content('You need to sign in or sign up before continuing.')

    click_for_sign_up
    
    fill_sign_up_form


  	expect(page).to have_content('Your cart is empty, please add items to your cart')
  end

  def click_for_sign_up
    find('a[href$="/users/sign_up"]').click
  end

  def fill_sign_up_form
    fill_in 'First name',            with: 'James'
    fill_in 'Last name',             with: 'Hameson'
    fill_in 'Email',                 with: 'james@testrspec.com'
    fill_in 'Password',              with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
  end
end