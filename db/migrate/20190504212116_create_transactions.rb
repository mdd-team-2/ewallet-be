class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :mddtransactions do |t|
      t.references :wallet, foreign_key: true, column: :target_id
      t.references :wallet, foreign_key: true, column: :source_id
      t.references :transaction_type, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
