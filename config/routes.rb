# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    resources :events
    resources :places
    resources :rules
    resources :rulesplaces

    root to: 'events#index'
  end
  post 'rule_token' => 'rule_token#create'
  post 'event_token' => 'event_token#create'
  post 'place_token' => 'place_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # place
  namespace :api do
    namespace :v1 do
      get 'places', to: 'places#index'
      post 'place_post', to: 'places#create'
      get 'place/rule/:id', to: 'places#showrule'
      get 'place/:id', to: 'places#show'
      delete 'places/delete/:id', to: 'places#delete'
      put 'place/update/:id', to: 'places#update'

      # event
      get 'events', to: 'events#index'
      post 'event_post', to: 'events#create'
      get 'event/rule/:id', to: 'events#showrule'
      get 'event/:id', to: 'events#show'
      delete 'events/delete/:id', to: 'events#delete'
      put 'event/update/:id', to: 'events#update'

      # rule
      get 'rules', to: 'rules#index'
      post 'rule_post', to: 'rules#create'
      get 'rules/:id', to: 'rules#show'
      delete 'rules/delete/:id', to: 'rules#delete'
      put 'rule/update/:id', to: 'rules#update'

      #eventsPlace
      get 'rules_place', to: 'rulesplace#index'

    end
  end
end
