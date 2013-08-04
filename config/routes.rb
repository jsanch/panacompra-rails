Panacompra::Application.routes.draw do


  resources :compras, only: [:index, :show, :create] do
    get 'all' ,on: :collection
    post 'create_many', on: :collection
  end

  root :to => "compras#index"
end
