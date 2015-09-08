Rails.application.routes.draw do
  resources :pins do
      member do
        put "like", to: "pins#upvote"
      end
  end

  devise_for :users
  root "pins#index"
  get "about" => "pages#about"

end
