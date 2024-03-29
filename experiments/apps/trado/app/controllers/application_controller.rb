class ApplicationController < ActionController::Base
    include ApplicationHelper
    before_action :authenticate_user!, :set_tracking_code
    helper_method :current_cart
    helper_method :theme_presenter

    protected

    def theme_presenter
      ThemePresenter.new(theme: Store::settings.theme)
    end

    def set_tracking_code
      gon.trackingCode = Store::settings.ga_code
    end

  	def current_cart
      Cart.find(session[:cart_id])
    #rescue ActiveRecord::RecordNotFound
  	#	cart = Cart.new 
    #  cart.save(validate: false)
   # 	session[:cart_id] = cart.id
    #  return cart
  	end

    def after_sign_out_path_for resource_or_scope
        admin_root_path
    end
end
