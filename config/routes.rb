Rails.application.routes.draw do
  root 'main#index'
  get '/test', to: 'main#test', as: 'test'
end
