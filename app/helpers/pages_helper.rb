module PagesHelper

  def page_exists?(url, parent, id)
    if parent == ""
      parent = nil
    end
    existing_page = Page.find_by(parent_page_id: parent, url: url)
    puts "Checking if pages is nil: #{existing_page.nil?}"
    return false if existing_page.nil?
    puts "Checking if page is same: #{existing_page.id} == #{id}"
    return false if "#{existing_page.id}" == "#{id}"
    puts "Page is not unique, bail"
    true
  end

end
