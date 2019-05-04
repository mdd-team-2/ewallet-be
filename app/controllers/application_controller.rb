class ApplicationController < ActionController::API
  include Secured
  after_action :set_header

  private
  def set_header
    response.headers['token'] = @token
  end

end
