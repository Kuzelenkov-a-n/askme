module QuestionsHelper
  def correct_of_declination(question_count)
    ostatok100 = (question_count % 100).to_s
    case ostatok100
    when /^.*[5-90]$|^.*11$/ then "#{question_count} вопросов"
    when /^.*[2-4]$/ then "#{question_count} вопроса"
    else "#{question_count} вопрос"
    end
  end
end
