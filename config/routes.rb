SimpleNewsAggregation::Application.routes.draw do
  root :to => 'categories#index'
  resources :categories, :feeds, :entries

  resources :categories do
    resources :feeds do
      resources :entries
    end
  end

  namespace :admin do
    resources :categories do
      resources :feeds do
        resources :entries
      end
    end
    resources :feeds
    root :to => 'categories#index'
  end
  match 'last_entries/:id' => 'categories#last_entries'
  match 'admin/feed/accept/:id' => 'admin/feeds#accept'
  match 'admin/feed/reject/:id' => 'admin/feeds#reject'
  match 'admin/feed/update_feeds' => 'admin/feeds#update_feeds'
  match 'last_entries/:id/feeds' => 'feeds#create'
end
