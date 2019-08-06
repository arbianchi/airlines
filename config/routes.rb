Rails.application.routes.draw do
  root 'flights#index'

  post '/purchase', to: 'flights#purchase'

end
