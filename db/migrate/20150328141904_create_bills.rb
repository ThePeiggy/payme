class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :public_key, null: false
      t.string :private_key, null: false
      t.string :qr_name, null: false
      t.float  :initial_balance

      t.timestamps
    end
  end
end
