Rails.application.routes.draw do
# 顧客用
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about", as: "about"
    get "customers/my_page"=> "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers" => "customers#update"
    resources :orders
    resources :cart_items
    resources :items, only: [:show, :index]
  end

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    resources :items
    resources :customers, only: [:show, :edit, :update, :index]
    get "order_details" => "admin/order_details#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
