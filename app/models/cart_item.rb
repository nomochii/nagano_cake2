class CartItem < ApplicationRecord
   belongs_to :customer
   belongs_to :item

   # ↓税込小計
   def subtotal
      item.add_tax_price * amount
   end
end
