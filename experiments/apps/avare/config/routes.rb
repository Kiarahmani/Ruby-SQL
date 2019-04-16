Avare::Application.routes.draw do

  root :to => "specifications#index"
  devise_for :users
  resources :users, :only => :show
  resources :categories
  resources :projects
  resources :specifications do
    collection do
      put 'fsm'
    end
  end

  resources :upload, :only => ['index', 'upload_file', 'handle'] do
    collection do
      put 'handle'
    end
  end

  match "/upload/file", :controller => "upload", :action => "upload_file", :via => :post, :as => :upload_file
end
