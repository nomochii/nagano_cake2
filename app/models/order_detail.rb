class OrderDetail < ApplicationRecord
   belongs_to :order
   belongs_to :item

   def subtotal
      item.add_tax_price * amount
   end
end
