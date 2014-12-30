Rails.application.routes.draw do
  namespace :admin do
    resources :signing_in_histories, only: :index
    resources :signing_histories_searches, only: :new
  end

end
