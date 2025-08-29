class PwaController < ApplicationController
  skip_before_action :authenticate_user!
  skip_forgery_protection

  def service_worker
  end

  def manifest
  end
end
