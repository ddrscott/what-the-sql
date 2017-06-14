Rails.application.routes.draw do
  mount Blazer::Engine, at: 'blazer'

  root 'user#sign_in'

  match '/user/sign_in', controller: 'user', action: 'sign_in', as: :sign_in, via: %i(get post)
  get '/user/sign_out', controller: 'user', action: 'sign_out', as: :sign_out
end
