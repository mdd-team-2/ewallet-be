class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :wallet, foreign_key: true
      t.references :wallet, foreign_key: true
      t.references :transaction_type, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
