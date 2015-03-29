Myapp::Application.routes.draw do
  root 'home#landing'

  get "home/landing"

  resources :bills, only: [:update, :show] do
  	get :unused_bill, on: :collection
    get :bill_custom_create, on: :collection
  end
end
