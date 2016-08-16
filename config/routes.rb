Rails.application.routes.draw do

  

 	get 'admin' => 'admin#index'
	controller :sessions do
		get 'login' => :new
		post 'login' => :create
		delete 'logout' => :destroy
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	get "store/index"
  	get "previous_orders/:id"  => 'orders#previous_orders', :as => "previous_orders"

  	root :to => 'store#index', :as => 'store'  
  	resources :orders
	resources :products
	resources :carts
	resources :line_items
	resources :users
	
	
end
