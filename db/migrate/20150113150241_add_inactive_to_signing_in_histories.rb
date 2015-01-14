class AddInactiveToSigningInHistories < ActiveRecord::Migration
  def up
    add_column :signing_in_histories, :inactive, :boolean, default: false
  end

  def down
    remove_column :signing_in_histories, :inactive, :boolean
  end
end
