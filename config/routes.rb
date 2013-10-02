Panacompra::Application.routes.draw do


  devise_for :users


  resources :alerts


  resources :compras, only: [:index, :show, :create] do
    get 'all' ,on: :collection
    post 'create_many', on: :collection
  end
  match '/stats' => 'home#index'
  match '/about' => 'home#about'

  root :to => "compras#index"
end
