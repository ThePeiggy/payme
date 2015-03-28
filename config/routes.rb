Myapp::Application.routes.draw do
  root 'home#landing'

  get "home/landing"

  resources :bills, only: [:update, :show] do
  	get :unused_bill, on: :collection
  end
end