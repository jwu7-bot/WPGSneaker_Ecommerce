class PagesController < ApplicationController
  def show
    @page = Page.find_by(permalink: params[:permalink])

    if @page.nil?
      render file: Rails.root.join("public", "404.html"), status: :not_found
    end
  end
end
