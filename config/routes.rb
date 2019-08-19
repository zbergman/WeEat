Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reviews do
    member {
      get :delete
    }
  end

  resources :restaurants do
    member {
      get :delete
    }
  end
end
