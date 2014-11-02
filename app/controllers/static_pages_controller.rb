class StaticPagesController < ApplicationController
  def index
  	@flickr_id = params["flickr_id"] if params["flickr_id"]
  end

end
