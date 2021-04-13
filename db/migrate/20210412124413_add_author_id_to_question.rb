class AddAuthorIdToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :author_id, :integer, null: true
    add_index :questions, :author_id
  end
end
