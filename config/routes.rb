Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "short_urls#new"
  resources :short_urls, only: [:index, :create, :new, :show]
  get '/:short_url', to: "short_urls#redirect", as: :shorten
end
