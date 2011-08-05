class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  before_filter :logined
  before_filter :isuser,:only => [:change_score,:change_score_for_show]
  before_filter :authorize,:only => [:index,:destroy,:new,:create]
  @@per_page = 6
  def index
    @products = Product.all
#    @cart = current_cart
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @show_product = Product.find(params[:id])
    @comments = Comment.paginate:page=>params[:page],
                                  :order => 'created_at DESC',
                                  :conditions =>["product_id = :pid",{:pid => @show_product.id}],
                                  :per_page => @@per_page
    @new_comment = Comment.new
    @comment_flag =true

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @show_product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
      format.xml {render :xml => @product}
    end
  end
  
  def change_score
    @product = Product.find(params[:id])
    @comment_flag = false
    
    score = params[:score]
    total_score = @product.score_number * @product.score
    total_score += score.to_f
    
    number = @product.score_number + 1
    @product.update_attribute('score_number',number)
    
    @product.update_attribute('score',(total_score/number).round(2))
    
    respond_to do |format|
      format.html { redirect_to(product_url)}
      format.js do
        render :update do |page|
          page.replace_html("product"+"#{@product.id}",render(@product))
        end
      end
      format.xml  {head :ok}
    end
  end
  def change_score_for_show
    @show_product = Product.find(params[:id])
    
    score = params[:score]
    total_score = @show_product.score_number * @show_product.score
    total_score += score.to_f
    
    number = @show_product.score_number + 1
    @show_product.update_attribute('score_number',number)
    
    @show_product.update_attribute('score',(total_score/number).round(2))
    
    @comments = Comment.paginate:page=>params[:page],
                                  :order => 'created_at DESC',
                                  :conditions =>["product_id = :pid",{:pid => @show_product.id}],
                                  :per_page => @@per_page
    @new_comment = Comment.new
    @comment_flag = true
    respond_to do |format|
      format.html { redirect_to(product_path)}
      format.js do
        render :update do |page|
          page.replace_html("product_for_show",render(:partial => "show_product",:object =>@show_product))
        end
      end
      format.xml  {head :ok}
    end
  end
end
