class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(text: params[:text])

    render file: "#{Rails.root}/public/404.html", layout: false unless @hashtag.present?
  end
end