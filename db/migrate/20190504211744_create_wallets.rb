class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.datetime :activation_date
      t.datetime :last_activity_date
      t.float :maximum_value
      t.float :current_value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
