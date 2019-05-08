Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create] do
        collection do
          get 'top_by_avg_rate'
          get 'find_authors_with_same_ip'
        end
      end

      resources :rates, only: [:create]
    end
  end
end
