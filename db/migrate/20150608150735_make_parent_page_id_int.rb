class MakeParentPageIdInt < ActiveRecord::Migration
  def change
    change_column :pages, :parent_page_id, 'integer USING NULLIF(parent_page_id, \'\')::int'
  end
end
