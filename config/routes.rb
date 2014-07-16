Rails.application.routes.draw do
  get 'users/new'

  root 'welcome#index'
  match '/signup', to: 'users#new', via: 'get'
end
