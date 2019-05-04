class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :service, foreign_key: true
      t.references :mddtransaction, foreign_key: true

      t.timestamps
    end
  end
end
