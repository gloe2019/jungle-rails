require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
 
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "user visits homepage and clicks an 'Add to Cart' button - the cart num gets updated" do
    #ACT
    visit root_path
    #click add to cart
    click_on "Add", :match => :first
    #DEBUG/VERIFY
    #check class for cart in top_nav, ensure that text rendered is "My Cart (1)"
    expect(page).to have_text "My Cart (1)"
    save_screenshot
  end

end
