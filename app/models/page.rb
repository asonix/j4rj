class Page < ActiveRecord::Base
  belongs_to :parent, :class_name => "Page", :foreign_key => "parent_page_id"
  has_many :child_pages, :class_name => "Event", :foreign_key => "parent_page_id"
end
