class Admin::HomesController < ApplicationController

  def top
    @customers = Customer.all
    @orders = Order.all
  end
end
