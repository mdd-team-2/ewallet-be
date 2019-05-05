class AddIngressToMddtransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :mddtransactions, :ingress, :boolean
  end
end
