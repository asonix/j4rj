module NavigationHelper

  def custom_url(page)
    output = page.url
    until page.parent_page_id.nil?
      page = Page.find(page.parent_page_id)
      output = "#{page.url}/#{output}"
    end
    output = "/#{output}"
    return output
  end

end
