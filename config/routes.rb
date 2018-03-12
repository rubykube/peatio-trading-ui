Rails.application.routes.draw do
  get 'markets/:id', to: 'markets#show'
end
