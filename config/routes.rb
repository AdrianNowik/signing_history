Rails.application.routes.draw do
  namespace :admin do
    resources :signing_in_histories, only: :index
  end

end
