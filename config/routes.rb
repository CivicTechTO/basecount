# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  
  devise_for :users
  
  scope :api do

    put     '/users/:id', to: 'users#edit'
    
    scope :sites do
      post    '/new', to: 'sites#create', as: 'sites_new'
      get     '/:id', to: 'sites#show', as: 'sites_show'
      put     '/:id', to: 'sites#update', as: 'sites_update'
      get     '/:id/users', to: 'sites#users', as: 'sites_users_show'
      post    '/:id/users', to: 'sites#add_user', as: 'sites_user_add'
      put     '/:id/users/:uid', to: 'sites#edit_user', as: 'sites_user_edit'
      delete  '/:id/users/:uid', to: 'sites#remove_user', as: 'sites_user_remove'
      get     '/:id/headcounts', to: 'sites#headcounts', as: 'sites_headcounts'
    end
    
    scope :orgs do
      get     '/:id/sites', to: 'orgs#sites', as: 'orgs_sites'
      get     '/:id/users', to: 'orgs#users', as: 'orgs_users_show'
      post    '/:id/users', to: 'orgs#add_user', as: 'orgs_user_add'
      delete  '/:id/users/:uid', to: 'orgs#remove_user', as: 'orgs_user_remove'
      put     '/:id/users/:uid', to: 'orgs#edit_user', as: 'orgs_user_edit'
    end
    
    scope :headcounts do
      post    '/', to: 'headcounts#create', as: 'headcounts_new'
      get     '/:id', to: 'headcounts#show', as: 'headcounts_show'
      put     '/:id', to: 'headcounts#update', as: 'headcounts_update'
    end
    
    get     '/base_state', to: 'state#index', as: 'base_state'
    
  end

  root to: 'home#index'

  if Rails.env.production?
    scope :app do
      get '/', to: 'home#app'
      get '*path', to: 'home#app'
    end
  end

end
