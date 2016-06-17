Rails.application.routes.draw do


  devise_for :users, 
    path_names: { sign_in: 'login',sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' },
    controllers: { registrations: 'registrations' }

 resources :posts do
 	resources :comments, only: [:create, :destroy]
 end

 root "posts#index"

 get "/about" => "pages#about"

	as :user do
  	get 'login' => 'devise/sessions#new'
    get 'logout' => 'devise/sessions#destroy'
    get 'sign_up' => 'devise/registrations#new'
  end
 
end
