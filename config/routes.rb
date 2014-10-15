ActsAsTalented::Engine.routes.draw do
  devise_for :employers, class_name: "ActsAsTalented::Employer", module: :devise
	root "dashboard#index"

	namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :employers
    end
  end

end
