class Mddtransaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :transaction_type

  def self.egress(wallet:)
    transactions = Mddtransaction.where(wallet_id: wallet).joins("LEFT JOIN payments ON payments.mddtransaction_id = mddtransactions.id").joins("LEFT JOIN services ON payments.service_id = services.id").select("payments.*,services.*, mddtransactions.*").each do |p|
      p['ingress'] = false
    end

    return transactions
  end

  def self.ingress(wallet:)
    transactions = Mddtransaction.where(transaction_type_id: 1).where(target_id: wallet).each do |p|
      p['ingress'] = true
    end

    return transactions
  end

end
