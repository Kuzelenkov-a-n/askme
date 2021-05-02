class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(text: params[:text])
  end
end
