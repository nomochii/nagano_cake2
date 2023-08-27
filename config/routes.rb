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

    # 退会確認画面
    get  '/customers/unsubscribe' => 'customers#unsubscribe'
    # 論理削除用のルーティング
    patch  '/customers/withdraw' => 'customers#withdraw'

    post "orders/confirm"=> "orders#confirm"
    get "orders/complete"=> "orders#complete"
    resources :orders, only: [:new, :create, :index, :show]

    delete "cart_items/destroy_all"=> "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]

    resources :items, only: [:show, :index]
  end

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    get "admin" => "homes#top", as: "/"

    resources :items, only: [:show, :edit, :update, :index, :new, :create]

    resources :customers, only: [:show, :edit, :update, :index]

    get "order_details" => "admin/order_details#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
