class CommentsController < ApplicationController
  before_filter :logined
  before_filter :isuer,:only=>[:edit]
  before_filter :authorize,:only => [:destroy]
  # GET /comments
  # GET /comments.xml
  @@per_page = 5
  def index
    @comments = Comment.all
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])
    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    
  end

  # POST /comments
  # POST /comments.xml
  def create
    @product = Product.find(params[:product_id])
    
    @comment = Comment.new(params[:new_comment])
    @comment.update_attribute('product_id',@product.id)
    
    @comments = Comment.paginate:page=>params[:page],
                                  :order => 'created_at DESC',
                                  :conditions =>["product_id = :pid",{:pid => @product.id}],
                                  :per_page => @@per_page
    @comment_flag = true

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.js
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  def create_for_product_show
    @show_product = Product.find(params[:product_id])
    
    @comment = Comment.new(params[:new_comment])
    @comment.update_attribute('product_id',@show_product.id)
    
    @comments = Comment.paginate:page=>params[:page],
                                  :order => 'created_at DESC',
                                  :conditions =>["product_id = :pid",{:pid => @show_product.id}],
                                  :per_page => @@per_page
    @comment_flag = true

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.js do
          render :update do |page|
            page.replace_html("product_for_show",render(:partial => "show_product",:object =>@show_product))
          end
        end
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])
    

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  
  def show_comments
    @product = Product.find(params[:product_id])
#    @comments = Comment.where(:product_id => @product.id)
#    @comments = Comment.find(:all,:conditions =>["product_id = :pid",{:pid => @product.id}])
    @comments = Comment.paginate:page=>params[:page],
                                  :order => 'created_at DESC',
                                  :conditions =>["product_id = :pid",{:pid => @product.id}],
                                  :per_page => @@per_page
    @comment_flag = true
    @new_comment = Comment.new
    
    respond_to do |format|
      format.html {redirect_to(comments_url)}
      format.js   
      format.xml  {head :ok}
    end
  end
  
  def hide_comments
    @comment_flag = false
    @product = Product.find(params[:product_id])
    
    respond_to do |format|
      format.html {redirect_to(comments_url)}
      format.js
      format.xml  {head :ok}
    end
  end
end
