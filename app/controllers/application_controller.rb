class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :serve_dropdown
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def require_admin
    redirect_to '/' unless current_user.has_permission?('admin')
  end

  def require_editor
    redirect_to '/' unless current_user.has_permission?('editor')
  end

  def require_tester
    redirect_to '/' unless current_user.has_permission?('tester')
  end

  def require_permission(permission)
    redirect_to '/' unless current_user.has_permission?(permission)
  end

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
          output += make_dropdown(title, url, id)
        end
      else
        if parent == page_id
          unless @page_ids.include?(id)
            if parent.nil?
              output += make_link(title, url)
            else
              output += make_item(title, url, id)
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

  private
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
