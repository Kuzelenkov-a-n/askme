require_relative '20210409202316_add_color_to_user'

class FixupAddColorToUser < ActiveRecord::Migration[6.1]
  def change
    revert AddColorToUser

    add_column :users, :color, :string, default: '#005a55'
  end
end
