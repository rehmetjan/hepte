class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_action :login_required, :admin_required
end
