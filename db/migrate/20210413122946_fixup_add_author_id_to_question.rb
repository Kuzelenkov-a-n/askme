require_relative '20210412124413_add_author_id_to_question'

class FixupAddAuthorIdToQuestion < ActiveRecord::Migration[6.1]
  def change
    revert AddAuthorIdToQuestion

    add_column :questions, :author_id, :integer
    add_index :questions, :author_id
  end
end
