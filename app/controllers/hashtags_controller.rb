class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.find_by!(text: params[:text])
  end
end