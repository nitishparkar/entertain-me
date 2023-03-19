Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'generate_recommendations', to: 'home#recommendations'
  get 'recommendations', to: 'home#recommendations_template'

  root "home#index"
end
