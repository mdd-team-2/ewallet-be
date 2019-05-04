module Secured
  extend ActiveSupport::Concern
  attr_reader :current_user,:current_admin,:token

  def authenticate_client!
    begin
      obj = auth_token
      @current_user = User.find_by_id(obj["id"])
      unless @current_user and @current_user.role.id == 1
        raise JWT::VerificationError
      end
      generate_token @current_user

    rescue JWT::VerificationError, JWT::DecodeError
      response_message
    end
  end

  def authenticate_shop_keeper!
    begin
      obj = auth_token
      puts "-----------aca decodifico--------"
      puts obj
      puts obj["id"]
      puts obj.id
      @current_user = User.find_by_id(obj["id"])
      unless @current_user and @current_user.role.id == 2
        raise JWT::VerificationError
      end
      generate_token @current_user

    rescue JWT::VerificationError, JWT::DecodeError
      response_message
    end
  end
  

  private
  def generate_token(object)
    @token = JsonWebToken.encode(playload: {id: 1,type: 1})
  end
  
  def response_message
    render json: {
      data: {
        errors: ['Not authorized']
      }
    }, status: :unauthorized
  end

  def auth_token
    JsonWebToken.decode(http_token)  
  end

  def http_token
    if request.headers['Authorization'].present?
      values = request.headers['Authorization'].split(" ")
      if values[0] == 'Bearer'
        return values.last
      else  
        return nil
      end
    end
    nil
  end
end