Rails.application.routes.draw do
  get 'trading/:market_id', to: 'markets#show'
end
