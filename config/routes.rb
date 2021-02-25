Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  # root 'groups#index'
  root 'reports#index'

  get 'groups', to: 'groups#index', as: :home
  get 'groups/:id/notifications', to: 'reports#notifications', as: :notifications
  get 'setting', to: 'groups#setting', as: :setting

  # group
  post '/groups/create'
  get 'groups', to: 'groups#index', as: :groups
  get '/groups/:id', to: 'groups#show', as: :group

  # memberships
  post '/memberships/create'
  get '/memberships/invitations', as: :invitations
  post '/memberships/accept_membership'
  delete '/memberships/reject_membership'

  # profile
  get 'profiles/:id', to: 'profiles#index', as: :profiles
  post 'profiles/create'
  post 'profiles/edit'

  # savings
  get '/groups/:id/savings', to: 'savings#index', as: :savings
  post '/groups/:id/savings/create', to: 'savings#create'
  post '/groups/:id/savings/edit', to: 'savings#edit'
  delete '/groups/:id/savings/delete', to: 'savings#delete'

  # expenses
  get '/groups/:id/expenses', to: 'expenses#index', as: :expenses
  post '/groups/:id/expenses/create', to: 'expenses#create'
  post '/groups/:id/expenses/edit', to: 'expenses#edit'
  delete '/groups/:id/expenses/delete', to: 'expenses#delete'

  # incomes
  get '/groups/:id/incomes', to: 'incomes#index', as: :incomes
  post '/groups/:id/incomes/create', to: 'incomes#create'
  post '/groups/:id/incomes/edit', to: 'incomes#edit' # update through form
  delete '/groups/:id/incomes/delete', to: 'incomes#delete'

  # loans
  get '/groups/:id/loans', to: 'loans#index', as: :loans
  post '/groups/:id/loans/create', to: 'loans#create'
  post '/groups/:id/loans/edit', to: 'loans#edit'
  delete '/groups/:id/loans/delete', to: 'loans#delete'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
