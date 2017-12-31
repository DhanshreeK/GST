Rails.application.routes.draw do
  
  get 'settings/new'

  get 'job_work_inwards/new'

  resources :unit_of_measures
  resources :business_sales
  resources :customers do 
    collection do
      get :add_item
      post :add
      get :load_customer_data
    end
  end

  resources :invoices do
    collection do
      get :export
    end
    member do
      get :show_invoice
    end
  end

  resources :export_invoices do
     member do
      get :show_export_invoice
    end
  end


  resources :purchase_bills do
    member do
      get :show_invoice
    end
  end


  resources :export_purchase_bills do
    member do
      get :show_invoice
    end
  end



  resources :nillrate_exempt_bills do
    member do
      get :show_invoice
    end
  end

  
   resources :exempt_invoices do
     member do
      get :show_exempt_invoice
    end
  end


   resources :credit_debit_notes do
     member do
      get :show_credit_debit_note
    end
  end

  resources :issue_notes do
     member do
      get :show_issue_note
    end
  end

  resources :refund_vouchers do
    member do
      get :show_refund_voucher
    end
  end

   resources :receipt_vouchers do
    member do
      get :show_receipt_voucher
    end
  end

  resources :reports do
    collection do
      get :export_excels
      post :excel_lists
    end
  end

  resources :job_works do 
    member do
     get :show_job_work
    end
  end

  resources :job_work_inwards do 
    member do
     get :show_job_work_inward
    end
  end

  resources :other_challans do 
    member do
     get :show_other_challan
    end
  end

 


   get 'invoices/attributes_for/:model' => 'invoices#get_attributes_for'
  
  resources :items do
    collection do
      get :load_item_data
    end
  end

  resources :parties

  resources :charted_accountants do 
    member do
      get :show_parties
    end
  end
   devise_for :users, controllers: { registrations: 'registrations' }
   as :user do
     get '/users/sign_out' => 'devise/sessions#destroy'
   end
  root 'home#dashboard'
  # get 'dashboard/index'
  resources :tables do
    collection do
     get :basic_tables
   end
 end
  # defaults to dashboard
  # root :to => redirect('/dashboard')
  resources :users do
    collection do
      get :index
    end
  end
  
  resources :home do
    collection do 
    get :dashboard
    end
  end

  resources :settings
  

  resources :general_settings
  resources :hsn_summary_for_sale_bills
  resources :hsn_summary_for_purchase_bills
  # view routes
  # get '/dashboard' => 'dashboard#index'

 
end
