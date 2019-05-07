class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_shop_keeper!, only: [:consult_wallet_admin]
  before_action :authenticate_client!, only: [:consult_wallet]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # POST /signup
  def signup
    @user = User.new(user_params)
    @user.role_id = 1
    ActiveRecord::Base.transaction do
      if @user.save
        @wallet = Wallet.new
        @wallet.activation_date = DateTime.now.to_date
        @wallet.last_activity_date = DateTime.now.to_date
        @wallet.maximum_value = 10000000
        @wallet.current_value = 1000
        @wallet.user_id = @user.id
        if @wallet.save
          render json: @user.slice(:name,:lastname, :email), status: :created
        else
          render json: @wallet.errors, status: :unprocessable_entity
        end
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # POST /consult-wallet
  def consult_wallet
    user = User.by_email(params[:wallet][:email])
    if user
      @wallet = Wallet.where(user_id: user.id)
      if !@wallet.empty?
        @wallet = @wallet.first
        user = User.find(@wallet.user_id)
        render json: {
          data: {
            user: user.name + " " + user.lastname,
            wallet: @wallet.id 
          }
        }, status: :ok
      else
        render json: {
          data: {
            errors: {
              message: "No hay una billetera asociada a ese usuario"
            }
          }
        }, status: :unauthorized
      end
    else
      render json: {
        data: {
          errors: {
            message: "No se encontro ese correo asociado a un usuario"
          }
        }
      }, status: :unauthorized
    end
  end

  # POST /consult-wallet
  def consult_wallet_admin
    user = User.by_email(params[:wallet][:email])
    if user
      @wallet = Wallet.where(user_id: user.id)
      if !@wallet.empty?
        @wallet = @wallet.first
        user = User.find(@wallet.user_id)
        render json: {
          data: {
            user: user.name + " " + user.lastname,
            wallet: @wallet.id 
          }
        }, status: :ok
      else
        render json: {
          data: {
            errors: {
              message: "No hay una billetera asociada a ese usuario"
            }
          }
        }, status: :unauthorized
      end
    else
      render json: {
        data: {
          errors: {
            message: "No se encontro ese correo asociado a un usuario"
          }
        }
      }, status: :unauthorized
    end
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation)
    end
end
