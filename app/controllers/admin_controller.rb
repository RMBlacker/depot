class AdminController < ApplicationController
  before_filter :authorize
  def index
    @total_orders= Order.count
    
  end

end
