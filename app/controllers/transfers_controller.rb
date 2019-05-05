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
    
    if User.find(Wallet.find(params[:transfer][:wallet]).user_id).role_id == 1 
      if Wallet.has_money(@current_user.id, params[:transfer][:value]) 
        @wallet = Wallet.where(user_id: @current_user.id).first
        if @wallet.id != params[:transfer][:wallet]
          puts "Tiene el dinero suficiente"
          @transaction = Mddtransaction.new()
          puts @current_user.id
          @transaction.target_id = params[:transfer][:wallet]
          @transaction.wallet_id = @wallet.id
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
            render json: {
              data: {
                errors: {
                  message: "No es posible realizarte transferencias a ti mismo"
                }
              }
            }, status: 204
          end
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
        }, status: 204
      end
    else
      render json: {
        data: {
          errors: {
            message: "No es posible realizar transferencias a tenderos"
          }
        }
      }, status: 204
    end
  end

  # POST /transfer
  def transferadmin
    puts "-----------Transferencia desde admin------------"
    
    if User.find(Wallet.find(params[:transfer][:wallet]).user_id).role_id == 1
      puts "-----------1------------"
      if Wallet.has_money(@current_user.id, params[:transfer][:value]) 
        puts "-----------2------------"
        @wallet = Wallet.where(user_id: @current_user.id).first
        if @wallet.id != params[:transfer][:wallet]
          puts "Tiene el dinero suficiente"
          @transaction = Mddtransaction.new()
          puts @current_user.id
          @transaction.target_id = params[:transfer][:wallet]
          @transaction.wallet_id = @wallet.id
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
            render json: {
              data: {
                errors: {
                  message: "No es posible realizarte transferencias a ti mismo"
                }
              }
            }, status: 204
          end
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
        }, status: 204
      end
    else
      render json: {
        data: {
          errors: {
            message: "No es posible realizar transferencias a tenderos"
          }
        }
      }, status: 204
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
