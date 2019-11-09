Rails.application.routes.draw do
  resources :universities
  devise_scope :user do
    match '/users/auth/facebook/callback(.:format)', to: 'omniauth_callbacks#facebook', via: [:get, :post]
  end
  devise_for :users, controllers: { users: "users" }
  get 'books/all/' => 'books#all'
  resources :books
  resources :hold_requests
  resources :home
  resources :librarians
  resources :libraries
  resources :users
  resources :bookmarks, :except => [:create]
  root to: 'home#index'
  get '/books/:id/showBookByLibraryId' => 'books#show_book_by_library_id'
  post '/users/create' => 'users#create'
  post '/users/make_new' => 'users#create'
  post 'books/orders/:book_id/create' => 'orders#create_order'
  post 'orders/:book_id/return' => 'orders#return_order'
  resources :orders, only: [:index]
  post '/bookmarks/:book_id/create' => 'bookmarks#create'
  get 'users/edit' => 'users#edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
