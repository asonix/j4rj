module ApplicationHelper

  def serve_dropdown
    @page_ids = []
    return make_dropdown
  end

  def make_dropdown(page_title="", page_url="", page_id=nil)
    output = ""
    if page_id.nil?
      info = Page.all.pluck(:title, :url, :id, :parent_page_id)
    else
      info = Page.where(parent_page_id: page_id).pluck(:title, :url, :id, :parent_page_id)
      output += open_expand(page_title, page_url, page_id)
    end
    info.each do |title, url, id, parent|
      if page_has_children(id)
        unless @page_ids.include?(id)
          unless page_url == ""
            output += make_dropdown(title, "#{page_url}/#{url}", id)
          else
            output += make_dropdown(title, url, id)
          end
        end
      else
        if parent == page_id
          unless @page_ids.include?(id)
            if parent.nil?
              unless page_url == ""
                output += make_link(title, "#{page_url}/#{url}")
              else
                output += make_link(title, url)
              end
            else
              unless page_url == ""
                output += make_item(title, "#{page_url}/#{url}", id)
              else
                output += make_item(title, url, id)
              end
            end
          end
        end
      end
    end
    unless page_id.nil?
      output += close_expand
    end
    return output
  end

  def page_has_children(id)
    Page.exists?(parent_page_id: id)
  end

  def make_title(page_title, page_url)
    output  = "<a href=\"/#{page_url}\">"
    output += "<div class=\"title\">#{page_title}</div>"
    output += "</a>"
    return output
  end
  
  def open_expand(page_title, page_url, page_id)
    @page_ids.push(page_id)
    output  = "<div class=\"expand\">"
    output += make_title(page_title, page_url)
    output += "<div class=\"content hide\">"
    return output
  end

  def close_expand
    return "</div></div>"
  end

  def make_link(page_title, page_url)
    output  = "<div class=\"link\">"
    output += make_title(page_title, page_url)
    output += "</div>"
    return output
  end
  
  def make_item(page_title, page_url, page_id)
    @page_ids.push(page_id)
    output  = "<a href=\"/#{page_url}\">"
    output += "<div class=\"item\">#{page_title}</div>"
    output += "</a>"
    return output
  end

end
