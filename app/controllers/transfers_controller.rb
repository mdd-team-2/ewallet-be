class TransfersController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]
  before_action :authenticate_shop_keeper!, except: [:transfer]
  before_action :authenticate_client!, only: [:transfer]

  # GET /transactions
  def index
    @transactions = Mddtransaction.all

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transfer
  def transfer
    puts "-----------Transferencia------------"
    
    if Wallet.has_money(@current_user.id, params[:transfer][:value])
      puts "Tiene el dinero suficiente"
      @transaction = Mddtransaction.new()
      puts @current_user.id
      @transaction.target_id = params[:transfer][:wallet]
      @transaction.wallet_id = @current_user.id
      @transaction.transaction_type_id = 1
      @transaction.amount = params[:transfer][:value]


      if @transaction.save
        ActiveRecord::Base.transaction do
          Wallet.get_money(@current_user.id, params[:transfer][:value])
          Wallet.give_money(params[:transfer][:wallet], params[:transfer][:value])
        end
        render json: {
          data: {
            transaction: @transaction.id,
            date: @transaction.created_at,
            amount: @transaction.amount
          }
        }, status: :ok
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    else
      render json: {
        data: {
          errors: {
            message: "Saldo insuficiente"
          }
        }
      }, status: :unauthorized
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Mddtransaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:wallet_id, :wallet_id, :transaction_type_id, :amount)
    end
end
