Panacompra::Application.routes.draw do
  resources :compras do
    post :create_many, on: :collection
  end


  root :to => "home#index"
end
