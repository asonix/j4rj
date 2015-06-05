class PagesController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :require_editor, except: [:show]

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to "/#{@page.url}"
    else
      render 'new'
    end
  end

  def edit
    @page = Page.find_by(url: params[:url])
  end

  def update
    @page = Page.find_by(url: params[:url])

    if @page.update(page_params)
      redirect_to "/#{@page.url}"
    else
      render 'edit'
    end
  end

  def show
    @page = Page.find_by(url: params[:url])
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
