Rails.application.routes.draw do
  mount Blazer::Engine, at: 'blazer'

  root 'user#sign_in'

  match '/user/sign_in', controller: 'user', action: 'sign_in', as: :sign_in, via: %i(get post)
end
