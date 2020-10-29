require 'page-object'

class ShoppingCart
    include PageObject

    text_field(:search_txt, id:'search-field')
    link(:search_btn, id:'btnSearch')
    span(:search_result_txt, id:'search-results-term')
    link(:first_search_result_lnk, css:'ul.shop-list.product-list li>div:nth-child(2)>quick-look~a')
    span(:product_price_txt, css:"ul.shop-list.product-list li>div:nth-child(2)>quick-look ~.product-price")
    div(:quicklookOverlay, id:'quicklookOverlay')
    button(:add_to_cart, css:"button[class='btn btn_addtobasket btn_addtobasket_add']")
    span(:cart_item_txt, id:'title')
    button(:checkout_btn, id:'anchor-btn-checkout')
    link(:checkout_item_txt, css:"div[class='cart-table-row-title']>a")
    link(:close, css:"a[title='Close']")
    div(:product_title_txt, css:'div.pip-summary h1')
    div(:product_price_txt, css:'div.pip-summary .price-state.price-standard .price-amount')

    def launchappURL
        $browser.navigate.to 'http://www.williams-sonoma.com/'
    end

    def searchItem(searchText)
        self.search_txt_element.send_keys searchText
        self.search_btn_element.click
        return self.search_result_txt_element.text
    end

    def addFirstSearchItemToCart
        sleep 10
        self.first_search_result_lnk_element.wait_until(&:present?)
        item_title=self.first_search_result_lnk_element.text
        sleep 5
        if self.close_elements.size() > 0
            self.close_element.click
        end
        sleep 5
        $browser.execute_script('arguments[0].scrollIntoView(true);', self.first_search_result_lnk_element)
        self.first_search_result_lnk_element.click
        self.add_to_cart_element.wait_until(&:present?)
        self.add_to_cart_element.click
        return item_title
    end

    def checkoutItem
        sleep 10
        self.checkout_btn_element.wait_until(&:present?)
        self.checkout_btn_element.click
        return self.checkout_item_txt_element.text
    end

    def clickOnQuickLookLink
        sleep 10
        self.first_search_result_lnk_element.wait_until(&:present?)
        item_title=self.first_search_result_lnk_element.text
        item_price=self.product_price_txt_element.text
        return item_title, item_price
    end

    def validateQuickLookOverLay
        sleep 10
        self.quicklookOverlay.displayed?
    end

    def getProductTItle
        sleep 10
        self.product_title_txt_element.wait_until(&:present?)
        self.product_title_txt_element.text
    end

    def getProductPrice
        sleep 10
        self.product_price_txt_element.wait_until(&:present?)
        self.product_price_txt_element.text
    end
end