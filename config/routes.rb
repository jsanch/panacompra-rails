Panacompra::Application.routes.draw do


  resources :compras, only: [:index, :show, :create] do
    get 'all' ,on: :collection
  end

  root :to => "compras#index"
end
