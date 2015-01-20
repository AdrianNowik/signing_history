class AddInactiveToSigningInHistories < ActiveRecord::Migration
  def change
    add_column :signing_in_histories, :inactive, :boolean, default: false
  end
end
