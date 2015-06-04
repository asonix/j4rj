class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :parent_page_id
      t.string  :url
      t.string  :title
      t.string  :body
      t.boolean :has_left_sidebar
      t.string  :left_sidebar
      t.boolean :has_right_sidebar
      t.string  :right_sidebar

      t.datetime "created_at"
      t.datetime "updated_at"

      t.timestamps null: false
    end
  end
end
