class CreateSigningInHistories < ActiveRecord::Migration
  def change
    create_table :signing_in_histories do |t|
      t.string :login
      t.string :ip_address
      t.string :details
      t.boolean :sign_succeed
      t.integer :user_id

      t.timestamps
    end
  end
end
