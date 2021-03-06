Rails.application.routes.draw do
  resources :wishlist_items
  resources :gifts
  resources :wishlists
  devise_for :admins
  resources :events
  devise_for :users
  resources :welcome
  resources :events do
   resources :participations
 end
  resources :users

  get '/events/:id/participations', to: 'participations#create'
  post '/events/:id/participations', to: 'participations#create'

  root to: redirect('/welcome/show')
  post '/search', to: 'gifts#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
