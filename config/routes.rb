Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  root 'reports#home'

  # savings
  get 'savings', to: 'savings#index', as: :savings 
  post 'savings/create'
  post 'savings/edit'
  delete 'savings/delete'

  # expenses
  get 'expenses', to: 'expenses#index', as: :expenses
  post 'expenses/create'
  post 'expenses/edit'
  delete 'expenses/delete'

  # incomes
  get 'incomes', to: 'incomes#index', as: :incomes  
  post 'incomes/create'
  post 'incomes/edit' # update through form
  delete 'incomes/delete'

  # loans
  get 'loans', to: 'loans#index', as: :loans
  post 'loans/create'
  post 'loans/edit'
  delete 'loans/delete'

  # profile
  get 'profiles/:id', to: "profiles#index", as: :profiles
  post 'profiles/create'
  post 'profiles/edit'


  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
