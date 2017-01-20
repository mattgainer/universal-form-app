Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :firsts
  root to: "firsts#test"
  get "/test", to: "firsts#test"
end
