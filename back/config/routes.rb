Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # 認証が必要なルーティングはここ
  namespace :auth do
    resources :portfolios, only: %i[show create update destroy] do
      resource :likes, only: %i[create destroy]
    end
    resource :user, only: %i[create destroy]
  end

  # 認証が不要なルーティングはここ
  resources :portfolios, only: %i[show]
  resources :teches, only: %i[index]
  resources :test_posts, only: %i[index]
  # Defines the root path route ('/')
  # root 'posts#index'
end
