class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :update, :destroy]
  before_action :authenticate_client!, only: [:currentmoney]
  before_action :authenticate_shop_keeper!, only: [:currentmoney_admin]

  # GET /wallets
  def index
    @wallets = Wallet.all

    render json: @wallets
  end

  # GET /wallets/1
  def show
    render json: @wallet
  end

  # GET /user/current-money
  def currentmoney
    puts @current_user
    if !Wallet.where(user_id: @current_user.id).empty?
      render json: {
        data: {
          current: Wallet.current_money(@current_user.id)
        }
      }, status: :ok
    else
      render json: {
        error: {
          user: "not exist"
        }
      }, status: 204
    end
  end

  # GET /user/current-money
  def currentmoney_admin
    puts @current_user
    if !Wallet.where(user_id: @current_user.id).empty?
      render json: {
        data: {
          current: Wallet.current_money(@current_user.id)
        }
      }, status: :ok
    else
      render json: {
        error: {
          user: "not exist"
        }
      }, status: 204
    end
  end

  # POST /wallets
  def create
    @wallet = Wallet.new(wallet_params)

    if @wallet.save
      render json: @wallet, status: :created, location: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /wallets/1
  def update
    if @wallet.update(wallet_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wallets/1
  def destroy
    @wallet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wallet_params
      params.require(:wallet).permit(:activation_date, :last_activity_date, :maximum_value, :current_value, :User)
    end
end
