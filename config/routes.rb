Rails.application.routes.draw do
  root 'toppages#index'
  devise_for :users
  resources 'requests'  
end
