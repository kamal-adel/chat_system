Rails.application.routes.draw do
  resources :applications, param: :token, only: [:create, :show, :update] do
    resources :chats, only: [:index, :create, :show], param: :number do
      resources :messages, only: [:index, :create] do
        collection do
          get 'search'
        end
      end
    end
  end

  get 'hello', to: 'welcome#index'
end


