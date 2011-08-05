class StoreController < ApplicationController
  @@per_page = 10
  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      @products = Product.paginate:page=>params[:page],
                                  :order => 'created_at DESC',
                                  :per_page => @@per_page
      @cart = current_cart
      @comment_flag = false
      @hot_three = current_hot_three
    end
  end

end
