Panacompra::Application.routes.draw do


  resources :alerts


  resources :compras, only: [:index, :show, :create] do
    get 'all' ,on: :collection
    post 'create_many', on: :collection
  end
  match '/stats' => 'home#index'

  root :to => "compras#index"
end
