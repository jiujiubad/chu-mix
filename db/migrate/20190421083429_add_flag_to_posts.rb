class AddFlagToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :flag_at, :datetime
  end
end
