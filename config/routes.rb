Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'reports#home'

  get 'savings', to: 'savings#index', as: :savings 
  post 'savings/create'
  post 'savings/edit'
  delete 'savings/delete'

  get 'expenses', to: 'expenses#index', as: :expenses
  post 'expenses/create'
  post 'expenses/edit'
  delete 'expenses/delete'

  get 'incomes', to: 'incomes#index', as: :incomes
  post 'incomes/create'
  post 'incomes/edit' # update through form
  delete 'incomes/delete'

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
