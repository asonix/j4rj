class RemoveUniquePagesUrl < ActiveRecord::Migration
  def change
    remove_index :pages, :url
    add_index :pages, :url
  end
end
