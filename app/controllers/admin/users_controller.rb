module Admin
  class Admin::UsersController < Admin::BaseController
      skip_before_action :require_login, only: %i[new create]
      skip_before_action :check_admin, only: %i[new create]
    def index
    end

    def new
    end

    def show
    end

    def edit
    end
  end
end
