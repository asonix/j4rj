Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles do
    resources :comments
  end

  root 'welcome#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'signup' => 'individual_users#new'
  post 'signup' => 'individual_users#create'

  get 'profile' => 'individual_users#show'
  get 'edit/profile' => 'individual_users#edit'
  patch 'edit/profile' => 'individual_users#update'

  get 'profiles' => 'users#index'
  get 'profile/:id' => 'users#show'
  get 'edit/profile/:id' => 'users#edit'
  patch 'edit/profile/:id' => 'users#update'
  resources :users

  get 'new/page' => 'pages#new'
  post 'new/page' => 'pages#create'

  get 'edit/page/:id' => 'pages#edit'
  post 'edit/page/:id' => 'pages#update'
  resources :pages

  #MUST GO LAST
  # get ':url1' => 'pages#show'
  # get ':url1/:url2' => 'pages#show'
  # get ':url1/:url2/:url3' => 'pages#show'
  # get ':url1/:url2/:url3/:url4' => 'pages#show'
  # get ':url1/:url2/:url3/:url4/:url5' => 'pages#show'

  #MUST GO LAST
  url = ":url1"
  get url => 'pages#show'
  m_url = Rails.application.config.max_url_length
  (2..m_url).each do |x|
    url += "/:url#{x}"
    get url => 'pages#show'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
