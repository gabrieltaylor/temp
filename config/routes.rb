Rails.application.routes.draw do

  namespace :public do
    namespace :api do
      namespace :v1 do
        resources :anonymized_connections, only: [:create]

        namespace :callback do
          resources :sms, only: :create
        end
      end
    end
  end
end
