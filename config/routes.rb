Panacompra::Application.routes.draw do


  resources :compras, only: [:index, :show, :create]

  root :to => "compras#index"
end
