require 'sidekiq/web'

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq_web'
  mount Whenever::Web => '/whenever'

  resources :contacts
  # use_doorkeeper
  devise_for :users,controllers: { confirmations: 'users/confirmations'}, defaults: { format: :json }
  namespace :v1 do
    post 'scrapper/input' => 'scrapper/scrapper#input'

    use_doorkeeper scope: 'auth' do
      controllers tokens: 'api_auth'
      skip_controllers :authorizations, :applications, :authorized_applications, :tokens
    end
    scope :auth do
      post 'login' => 'auth#create'
      post 'logoff' => 'auth#logoff'
      post 'forget_password' => 'auth#forget_password'
      post 'reset_password' => 'auth#reset_password'
    end
    get 'my/tenders', to: 'users#my_tenders'
    get 'marketplace/invites', to: 'users#invites'
    get 'marketplace/invited_by_me', to: 'users#invited_by_me'
    
    namespace :marketplace do
      # namespace :compete do
      #   resources :bid_no_bid_answers
      # end
      get :requests, to: 'user#requests'
      resources :bid_no_bid_answers
      resources :bid_no_bid_questions do
        member do
          post :assign, to: 'bid_no_bid_questions#create_assign'
          patch :assign, to: 'bid_no_bid_questions#update_assign'
          delete :assign, to: 'bid_no_bid_questions#delete_assign'
          get :bid_no_bid_question_comments, to: 'bid_no_bid_questions#bid_no_bid_question_comments'
          get :bid_no_bid_question_notes, to: 'bid_no_bid_questions#bid_no_bid_question_notes'
        end
      end
      resources :bid_results
      resources :tenders do
        collection do
          get :my_favourites
        end
        member do
          put :publish
          get :compete
          get :best_bidsense_profiles
          get :current_buyer_company_won_list
          get :complete_organization_tenders_list
          get :similar_opportunities_tenders
          put :add_favourite, to: 'tenders#add_favourite'
          delete :delete_favourite, to: 'tenders#delete_favourite'
          get :bid_result
          post :user_awaiting_result_tender
        end
        member do
          scope :compete do
            get :bid_no_bid_answers, to: 'tenders#get_bnb_data'
            post :bid_no_bid_answer, to: 'tenders#process_bnb_data'
          end
        end
        resources :collaborations, only: [:index] do
          post :accept
          post :ignore
          get :collaboration_assignments
          collection do
            post :apply
            post :remove
          end
        end
        resources :collaboration_interests  
        resources :tender_collaborators, path: 'collaborators'
        resources :tender_award_criteria, path: 'award_criteries' do
          delete :files, to: 'tender_award_criterias#delete_files'
          resources :tender_award_criteria_answer, path: 'answers' do
            member do
              put :close
            end
          end
        end
        resources :tender_qualification_criterias, path: 'qualification_criteria' do
          delete :files, to: 'tender_qualification_criterias#delete_files'
          member do
            post :assign, to: 'tender_qualification_criterias#create_assign'
            patch :assign, to: 'tender_qualification_criterias#update_assign'
            delete :assign, to: 'tender_qualification_criterias#delete_assign'
            get :tender_qualification_criteria_comments, to: 'tender_qualification_criterias#tender_qualification_criteria_comments'
            get :tender_qualification_criteria_notes, to: 'tender_qualification_criterias#tender_qualification_criteria_notes'
            put :update_deadline
          end
          resources :tender_qualification_criteria_answers, path: 'answers' do
            member do
              put :close
            end
          end
        end
        resources :tender_criteria_sections, path: 'criteria_sections' do
          collection do
            post :bulk_create
          end
        end
        resources :tender_award_criteria_sections, path: 'award_criteria_sections' do
          collection do
            post :bulk_create
          end
        end
        resources :tender_award_criteria, path: 'award_criteria' do
          member do
            post :assign, to: 'tender_award_criteria#create_assign'
            patch :assign, to: 'tender_award_criteria#update_assign'
            delete :assign, to: 'tender_award_criteria#delete_assign'
            get :tender_award_criteria_comments, to: 'tender_award_criteria#tender_award_criteria_comments'
            get :tender_award_criteria_notes, to: 'tender_award_criteria#tender_award_criteria_notes'
            put :update_deadline
          end
        end
        resources :tender_attachments
        resources :tender_collaboration_documents
        resources :tender_qualification_criteria_sections, path: 'qualification_criteria_sections' do
          collection do
            post :bulk_create
          end
        end
        resources :tender_suppliers, path: 'suppliers' do
          member do
            put :invite_approve
          end
        end
        resources :tender_compete_comments, path: 'compete_comments' do
          member do
            post :answer
          end
        end
      end
    end
    put :update_password, to: 'users#update_password', path: 'users/password/update'
    get :my_compete_tenders, to: 'users#my_compete_tenders'
    resources :assistances
    namespace :users do
      get :current
      resources :upgrade_requests, only: [:index, :destroy] do
        member do
          post :approve
        end
      end
    end
    resources :users do
      collection do
        get :available_in_marketplace
        get :search
      end
      member do
       put :change_user_role
      end
      resources :profiles do
        member do
          post :avatar, to: 'profiles#create_avatar'
          delete :avatar, to: 'profiles#destroy_avatar'
          post :cover_img, to: 'profiles#create_cover_img'
          delete :cover_img, to: 'profiles#destroy_cover_img'
        end

        resources :case_studies, path: 'case_study' do
          member do
            delete :remove_image, path: 'image/:image_id', to: 'case_studies#remove_image'
          end
        end
      end
    end
    get :user_tender_statistic, to: 'users#user_tender_statistic'
    resources :comments do
      member do
        get :childrens, to: 'comments#comment_childrens'
      end
    end
    resources :notes
    resources :profiles, path: 'my/profiles'
    get 'my/upgrade', to: 'users#upgrade'
    get 'bidder/monitor/all/result', to: 'search_monitors#all_monitor_result'
    get 'bidder/monitor/profile/result', to: 'search_monitors#profile_monitor_result'
    get 'bidder/monitor/favourite/result', to: 'search_monitors#favourite_monitor_result'
    get 'bidder/monitor/compete/result', to: 'search_monitors#compete_monitor_result'
    resources :search_monitors, path: 'bidder/monitor' do
      member do
        put :archive
        post :share
        put :favourite, to: 'search_monitors#add_favourite'
        delete :favourite, to: 'search_monitors#delete_favourite'
        get :result
        get :export
      end
      collection do
        get 'all_result', to: 'search_monitors#all_monitor_result'
        post :preview
        get :search
        get :profile, to: 'search_monitors#profile_monitor'
        get 'index_buyer', to: 'search_monitors#index_buyer'
        get 'profile/result', to: 'search_monitors#profile_monitor_result'
        get 'favourite/result', to: 'search_monitors#favourite_monitor_result'
        get 'compete/result', to: 'search_monitors#compete_monitor_result'

      end
    end
    post 'bidder/monitor/preview' => 'search_monitors#preview'
    post 'create_ticket', to: 'zen_service#create_ticket'
    get 'sign_into_zendesk', to: 'zen_service#sign_into_zendesk'
    resources :sign_up_requests
    resources :registration_requests, path: 'user/registration_request' do
      member do
        put 'process', to: 'registration_requests#update'
      end
    end

    namespace :dictionaries do
      resources :countries
      resources :roles
      resources :industries
      resources :industry_codes
      get :all_codes, path: 'all_codes', to: 'industry_codes#all_codes'
      resources :african_codes
      resources :classification_codes
      resources :gsin_codes
      resources :ngip_codes
      resources :nigp_codes
      resources :sfgov_codes
    end
  end

  namespace :v2 do
    namespace :marketplace do
      resources :tenders do
        resources :collaborations, only: [:index] do
          post :accept
          post :ignore
          get :collaboration_assignments
          collection do
            post :apply
            post :remove
          end
        end
        resources :collaboration_interests  
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
