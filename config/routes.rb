Rails.application.routes.draw do
  root "projects#index"
  
  resources :projects do
    resources :issues do
      get 'reports', on: :collection
      get 'export', on: :collection, defaults: { format: :xlsx }
    end
  end
end
