class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.belongs_to :user, index: true
      t.belongs_to :permission, index: true

      t.timestamps null: false
    end
  end
end
