require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examlpers here
    #each example needs its own @category, and then @product initialized with that category
    before do
      @category = Category.create(name: 'Outdoors')
    end

    it "should successfully create a product when all fields are present" do
     details = {
       name: 'Treehouse Tent',
       description: Faker::Hipster.paragraph(4),
       price: 150.59,
       quantity: 25,
     }
      @product = @category.products.create(details)
      expect(@product.errors.full_messages.length()).to eq(0)
    end
    
    it "should not create a product without a name" do
      details = {
        name: nil,
        description: Faker::Hipster.paragraph(4),
        price: 150.59,
        quantity: 25,
      }
      @product = @category.products.create(details)
      expect(@product.errors.full_messages.length()).to eq(1) 
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not create a product without a price" do
      details = {
        name: 'Treehouse Tent',
        description: Faker::Hipster.paragraph(4),
        price: nil,
        quantity: 25,
      }
      @product = @category.products.create(details)
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product.errors.full_messages).to include("Price is not a number")
    end
    
    it "should not create a product without a quantity" do
      details = {
        name: 'Treehouse Tent',
        description: Faker::Hipster.paragraph(4),
        price: 150.59,
        quantity: nil,
      }
      @product = @category.products.create(details)
      expect(@product.errors.full_messages.length()).to eq(1) 
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it "should not create a product without a category" do
      details = {
          name: 'Treehouse Tent',
          description: Faker::Hipster.paragraph(4),
          price: 150.59,
          quantity: 25,
          category: nil
        }
        @product = Product.new(details)
        puts @product.inspect
        expect(@product).not_to be_valid
      end
    end
end
