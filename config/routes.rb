Rails.application.routes.draw do
  get 'calendar/show'

  devise_for :users

  #root to: 'site#index'
  get '/', to: 'site#index', as: 'home'
  get '/about', to: 'site#about', as: 'about'
  get '/contact', to: 'site#contact', as: 'contact'

  resource :calendar, only: [:show], controller: :calendar
  root to: 'users#show'

  resources :users do
    resources :profiles
    resources :dailies do
      resources :items
    end
  end

=begin 
                  Prefix Verb   URI Pattern                                                Controller#Action

        new_user_session GET    /users/sign_in(.:format)                                   devise/sessions#new
            user_session POST   /users/sign_in(.:format)                                   devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)                                  devise/sessions#destroy
           user_password POST   /users/password(.:format)                                  devise/passwords#create
       new_user_password GET    /users/password/new(.:format)                              devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format)                             devise/passwords#edit
                         PATCH  /users/password(.:format)                                  devise/passwords#update
                         PUT    /users/password(.:format)                                  devise/passwords#update
cancel_user_registration GET    /users/cancel(.:format)                                    devise/registrations#cancel
       user_registration POST   /users(.:format)                                           devise/registrations#create
   new_user_registration GET    /users/sign_up(.:format)                                   devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)                                      devise/registrations#edit
                         PATCH  /users(.:format)                                           devise/registrations#update
                         PUT    /users(.:format)                                           devise/registrations#update
                         DELETE /users(.:format)                                           devise/registrations#destroy

                    root GET    /                                                          site#index
                   about GET    /about(.:format)                                           site#about
                 contact GET    /contact(.:format)                                         site#contact

           user_profiles GET    /users/:user_id/profiles(.:format)                         profiles#index
                         POST   /users/:user_id/profiles(.:format)                         profiles#create
        new_user_profile GET    /users/:user_id/profiles/new(.:format)                     profiles#new
       edit_user_profile GET    /users/:user_id/profiles/:id/edit(.:format)                profiles#edit
            user_profile GET    /users/:user_id/profiles/:id(.:format)                     profiles#show
                         PATCH  /users/:user_id/profiles/:id(.:format)                     profiles#update
                         PUT    /users/:user_id/profiles/:id(.:format)                     profiles#update
                         DELETE /users/:user_id/profiles/:id(.:format)                     profiles#destroy

        user_daily_items GET    /users/:user_id/dailies/:daily_id/items(.:format)          items#index
                         POST   /users/:user_id/dailies/:daily_id/items(.:format)          items#create
     new_user_daily_item GET    /users/:user_id/dailies/:daily_id/items/new(.:format)      items#new
    edit_user_daily_item GET    /users/:user_id/dailies/:daily_id/items/:id/edit(.:format) items#edit
         user_daily_item GET    /users/:user_id/dailies/:daily_id/items/:id(.:format)      items#show
                         PATCH  /users/:user_id/dailies/:daily_id/items/:id(.:format)      items#update
                         PUT    /users/:user_id/dailies/:daily_id/items/:id(.:format)      items#update
                         DELETE /users/:user_id/dailies/:daily_id/items/:id(.:format)      items#destroy

            user_dailies GET    /users/:user_id/dailies(.:format)                          dailies#index
                         POST   /users/:user_id/dailies(.:format)                          dailies#create
          new_user_daily GET    /users/:user_id/dailies/new(.:format)                      dailies#new
         edit_user_daily GET    /users/:user_id/dailies/:id/edit(.:format)                 dailies#edit
              user_daily GET    /users/:user_id/dailies/:id(.:format)                      dailies#show
                         PATCH  /users/:user_id/dailies/:id(.:format)                      dailies#update
                         PUT    /users/:user_id/dailies/:id(.:format)                      dailies#update
                         DELETE /users/:user_id/dailies/:id(.:format)                      dailies#destroy
                         
                   users GET    /users(.:format)                                           users#index
                         POST   /users(.:format)                                           users#create
                new_user GET    /users/new(.:format)                                       users#new
               edit_user GET    /users/:id/edit(.:format)                                  users#edit
                    user GET    /users/:id(.:format)                                       users#show
                         PATCH  /users/:id(.:format)                                       users#update
                         PUT    /users/:id(.:format)                                       users#update
                         DELETE /users/:id(.:format)                                       users#destroy
=end 

end
