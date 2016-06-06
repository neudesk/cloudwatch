Rails.application.routes.draw do
  namespace :api do
    resources :metrics do
      collection do
        get :cpu_utilization
        get :disk_read_bytes
        get :disk_write_bytes
        get :disk_read_opts
        get :disk_write_opts
        get :cpu_credit_balance
        get :cpu_credit_usage
        get :get_instance_operation_names
      end
    end
  end
end
