Depot::Application.routes.draw do

  

  get "store/index"
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end  
  controller :line_items do
    get 'increase_quantity' => :increase_quantity
    get 'decrease_quantity' => :decrease_quantity
  end
  controller :comments do
    post 'show_comments' => :show_comments
    get 'hide_comments' => :hide_comments
    post 'create_for_product_show' => :create_for_product_show
  end
  controller :products do
    get 'change_score' => :change_score
    get 'change_score_for_show' => :change_score_for_show

  end
scope '(:locale)' do
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :comments
  resources :products do
    get :who_bought, :on => :member
  end
  root :to => 'store#index', :as => 'store'
end  
  get 'admin' => 'admin#index'
  
 
  # get "line_items/increase_quantity",:to => "line_items#increase_quantity"
  # match "line_items/decrease_quantity",:to => "line_items#decrease_quantity"
  
  
#####################
  # resources :sessions do
    # get 'new', :on => :member
  # end
  
  # map.connect 'sessions/new',:controller => sessions,:action => "create"
#######################
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
