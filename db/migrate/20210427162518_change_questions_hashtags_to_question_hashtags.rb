class ChangeQuestionsHashtagsToQuestionHashtags < ActiveRecord::Migration[6.1]
  def change
    rename_table :questions_hashtags, :question_hashtags
  end
end
