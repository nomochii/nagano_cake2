class Item < ApplicationRecord

   has_one_attached :image
   # belongs_to :admin

   def  add_tax_price
      (self.price * 1.10).round
   end

end
