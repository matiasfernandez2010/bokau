Rails.application.routes.draw do
  resources :users
  root 'welcome#index'  
  match '/signup', to: 'users#new', via: 'get'
end
