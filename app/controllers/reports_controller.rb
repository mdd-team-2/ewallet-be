class ReportsController < ApplicationController
  before_action :authenticate_client!, only: [:report]
  before_action :authenticate_shop_keeper!, only: [:report_admin]
  
  # POST /reports
  def report
    puts "-----------Reporte------------"
    @wallet = Wallet.where(user_id: @current_user.id)
    if !@wallet.empty?
      @wallet = @wallet.first
      @transactions = Mddtransaction.egress(wallet: @wallet.id)
      @transactions += Mddtransaction.ingress(wallet: @wallet.id)
      
      #Order desc
      @transactions = @transactions.sort_by{|e| e[:created_at]}.reverse!

      if !@transactions.empty?
        
        render json: {
          data: @transactions
        }, status: 200
      else
        render json: {
          data: {
            errors: {
              message: "No se encontraron transacciones asociadas a ese usuario"
            }
          }
        }, status: 204
      end
    else
      render json: {
        data: {
          errors: {
            message: "No se encontraron billeteras asociadas"
          }
        }
      }, status: 204
    end
  end

  # POST /payments
  def report_admin
    puts "-----------Reporte------------"
    @wallet = Wallet.where(user_id: @current_user.id)
    if !@wallet.empty?
      @wallet = @wallet.first
      @transactions = Mddtransaction.egress(wallet: @wallet.id)
      @transactions += Mddtransaction.ingress(wallet: @wallet.id)
      
      #Order desc
      @transactions = @transactions.sort_by{|e| e[:created_at]}.reverse!

      if !@transactions.empty?
        
        render json: {
          data: @transactions
        }, status: 200
      else
        render json: {
          data: {
            errors: {
              message: "No se encontraron transacciones asociadas a ese usuario"
            }
          }
        }, status: 204
      end
    else
      render json: {
        data: {
          errors: {
            message: "No se encontraron billeteras asociadas"
          }
        }
      }, status: 204
    end
  end

end
