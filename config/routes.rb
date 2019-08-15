Rails.application.routes.draw do
  root 'flights#index'

  get '/purchase', to: 'flights#purchase'
  get '/checkout', to: 'flights#checkout'
  get '/transactions', to: 'flights#transactions'

end
