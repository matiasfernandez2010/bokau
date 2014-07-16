Rails.application.routes.draw do
  root 'welcome#index'  
  
  get 'users/new'
  match '/signup', to: 'users#new', via: 'get'
end
