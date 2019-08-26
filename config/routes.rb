Rails.application.routes.draw do
  #### Restaurants ####
  resources :restaurants

  #### Reviews ####
  REVIEWS_ROUTE = 'restaurants/:restaurant_id/reviews'
  #Create
  get REVIEWS_ROUTE + '/new', to: 'reviews#new'
  match REVIEWS_ROUTE, to: 'reviews#create', via: [:post]

  # Read
  get REVIEWS_ROUTE, to: 'reviews#index'
  get REVIEWS_ROUTE + '/:id', to: 'reviews#show'

  #Update
  get REVIEWS_ROUTE + '/:id/edit', to: 'reviews#edit'
  match REVIEWS_ROUTE + '/:id/update', to: 'reviews#update', via: [:patch, :put]

  #Delete
  match REVIEWS_ROUTE + '/:id/destroy', to: 'reviews#destroy', via: [:delete]

end