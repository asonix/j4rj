module PagesHelper

  def page_exists?(url, parent, id)
    if parent == ""
      parent = nil
    else
      parent = parent.to_i
    end
    existing_page = Page.find_by(parent_page_id: parent, url: url)
    puts "Checking if pages is nil: #{existing_page.nil?}"
    return false if existing_page.nil?
    puts "Checking if page is same: #{existing_page.id} == #{id}"
    return false if "#{existing_page.id}" == "#{id}"
    puts "Page is not unique, bail"
    true
  end

  def page_selector(id)
    id ||= -1
    invalid_ids = get_page_id_tree_down(id).push(id)
    pages = Page.where("id not in (?)", invalid_ids)
    unless id == -1
      page = Page.find(id)
      parent_title = page.parent_page_id.nil? ? 'No Parent' : Page.find(page.parent_page_id).title
      parent_id = page.parent_page_id.nil? ? '' : page.parent_page_id
    else
      parent_title = 'No Parent'
      parent_id = ''
    end

    output  = '<div class="dropdown">'
    output += '<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >'
    output += "<input type=\"hidden\" name=\"page[parent_page_id]\" value=\"#{parent_id}\">"
    output += "<span id=\"selected\" data-id=\"#{parent_id}\">"
    output += "#{parent_title}"
    output += '</span>&nbsp;&nbsp;'
    output += '<span class="caret"></span>'
    output += '</button>'
    output += '<ul class="dropdown-menu" role="menu" aria-labelledby="DropdownMenu1">'

    output += '<li role="presentation">'
    output += '<a role="menuitem" class="page-title" tabindex="-1" href="#" '
    output += "data-id=\"\">No Parent</a>"
    output += '</li>'

    pages.each do |x|
      output += '<li role="presentation">'
      output += '<a role="menuitem" class="page-title" tabindex="-1" href="#" '
      output += "data-id=\"#{x.id}\">#{x.title}</a>"
      output += '</li>'
    end

    output += "</ul></div>"

    return output
  end

  def get_page_id_tree_up(id)
    # Find all pages that are parents
    page = Page.find(id)
    ids = []

    until page.parent_page_id.nil?
      page = Page.find(page.parent_page_id)
      ids.push(page.id)
    end
    return ids
  end

  def get_page_id_tree_down(id)
    # Find all pages that are children
    pages = Page.where(parent_page_id: id)
    ids = []

    pages.each do |x|
      ids.push(x.id)
      ids += get_page_id_tree_down(x.id)
    end
    return ids
  end

end
