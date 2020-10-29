require 'rspec'
require 'selenium-webdriver'
require './pageobjects/ShoppingCart.rb'


describe 'Add a product to cart' do
       it "Add to cart" do 
            Selenium::WebDriver::Chrome::Service.driver_path="./drivers/chromedriver.exe"
            $browser = Selenium::WebDriver.for :chrome
            $browser.manage.timeouts.implicit_wait = 50
            $browser.manage.window.maximize
            $shoppingCart=ShoppingCart.new($browser)
            $shoppingCart.launchappURL

            result= $shoppingCart.searchItem 'chicken'
            expect(result).to eq "Chicken" 
       end
       it 'When click on "Add to cart" button, add to cart overlay appears' do 
            $item_title=$shoppingCart.addFirstSearchItemToCart
       end
       it 'When click on "Checkout" button then shopping cart page is displayed' do 
            $actual_item_title=$shoppingCart.checkoutItem
       end
       it 'The product you added to cart should be on shopping cart page' do 
            expect($item_title).to eq $actual_item_title
       end
 end


 describe 'See a Product on Quick Look Overlay' do 
    it "Search field takes to the results page" do 
        Selenium::WebDriver::Chrome::Service.driver_path="./drivers/chromedriver.exe"
        $browser = Selenium::WebDriver.for :chrome
        $browser.manage.timeouts.implicit_wait = 50
        $browser.manage.window.maximize
        $shoppingCart=ShoppingCart.new($browser)
        $shoppingCart.launchappURL
        result= $shoppingCart.searchItem 'chicken'
        expect(result).to eq "Chicken" 
    end
    it "Below the product's image display the quick look link" do
        ($item_title,$item_price)=$shoppingCart.clickOnQuickLookLink
    end
    it 'Click the quick look link show the product overlay' do 
        expect($shoppingCart.validateQuickLookOverLay).to be true
    end
    it 'The product clicked should have the same name and price as the product in the overlay' do 
        expect($shoppingCart.getProductTItle).to eq $item_title
        expect($shoppingCart.getProductPrice).to eq $item_price
    end
end
