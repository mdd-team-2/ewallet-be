class ReportsController < ApplicationController
  before_action :authenticate_client!, only: [:report]

  
  # POST /payments
  def report
    puts "-----------Reporte------------"
    @wallet = Wallet.where(user_id: @current_user.id)
    if !@wallet.empty?
      @wallet = @wallet.first
      @transactions = Mddtransaction.where(wallet_id: @wallet.id).joins("LEFT JOIN payments ON payments.mddtransaction_id = mddtransactions.id").joins("LEFT JOIN services ON payments.service_id = services.id").joins("LEFT JOIN users ON mddtransactions.id = users.id").select("users.*,payments.*,services.*, mddtransactions.*").each do |p|
        p['ingress'] = false
      end

      @transactions += Mddtransaction.where(transaction_type_id: 1).where(target_id: @wallet.id).each do |p|
        p['ingress'] = true
      end
      
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
