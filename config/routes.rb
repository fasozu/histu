Rails.application.routes.draw do
  get 'shorten_url/index'
  
  post 'shorten_url/index', to: 'shorten_url#generate'
  get 'shorten_url/debug', to: 'shorten_url#debug'

  get '/s/:short_code', to: 'shorten_url#redirect_url', as: 'shorten_url'

  root 'shorten_url#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
