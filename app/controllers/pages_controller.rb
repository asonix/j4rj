class PagesController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :require_editor, except: [:show]

  include NavigationHelper
  include PagesHelper

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if page_exists?(@page.url, @page.parent_page_id, @page.id)
      render 'new'
      return
    end

    if @page.save
      redirect_to custom_url(@page)
    else
      render 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if page_exists?(params[:page][:url], params[:page][:parent_page_id], params[:id])
      render 'edit'
      return
    end

    if @page.update(page_params)
      redirect_to custom_url(@page)
    else
      render 'edit'
    end
  end

  def show
    m_url = Rails.application.config.max_url_length
    @page = Page.find_by(url: params["url1"], parent_page_id: nil)
    (2..m_url).each do |x|
      unless params["url#{x}"].nil?
        puts "url#{x} not nill"
        @page = Page.find_by(url: params["url#{x}"], parent_page_id: @page.id)
      else
        break
      end
    end
  end

  def destroy
    @page = Page.find_by(url: params[:url])
    @page.destroy

    redirect_to '/'
  end

  private
  def page_params
    params.require(:page).permit('parent_page_id', 'url', 'title', 'body', 'has_left_sidebar', 'left_sidebar', 'has_right_sidebar', 'right_sidebar')
  end
end
