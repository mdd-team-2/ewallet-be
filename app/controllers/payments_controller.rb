class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :update, :destroy]
  before_action :authenticate_shop_keeper!, except: [:payment]
  before_action :authenticate_client!, only: [:payment]

  # GET /payments
  def index
    @payments = Payment.all

    render json: @payments
  end

  # GET /payments/1
  def show
    render json: @payment
  end

  # POST /payment
  def payment
    puts "-----------Payment------------"
    
    if Wallet.has_money(@current_user.id, params[:payment][:value])
      puts "Tiene el dinero suficiente para pagos"
      
      @transaction = Mddtransaction.new()
      puts @current_user.id
      #@transaction.target_id = params[:payment][:service]
      @transaction.wallet_id = @current_user.id
      @transaction.transaction_type_id = 2
      @transaction.amount = params[:payment][:value]

      if @transaction.save
        ActiveRecord::Base.transaction do
          @payment = Payment.new 
          @payment.service_id = params[:payment][:service]
          @payment.mddtransaction_id = @transaction.id
          Wallet.get_money(@current_user.id, params[:payment][:value])

          if @payment.save
        
          render json: {
            data: {
              transaction: @transaction.id,
              date: @transaction.created_at,
              amount: @transaction.amount
            }
          }, status: :ok
          else
            render json: @payment.errors, status: :unprocessable_entity
          end

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
      }, status: :unauthorized
    end
  end

  # POST /payments
  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      render json: @payment, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def payment_params
      params.require(:payment).permit(:service_id, :transaction_id)
    end
end
