class ApplicationController < ActionController::Base
    include SessionsHelper
    include UsersHelper  

    private

        def logged_in_user
            unless logged_in?
                flash[:alert] = "ログインしてください"
                redirect_to login_url
            end
        end
end
