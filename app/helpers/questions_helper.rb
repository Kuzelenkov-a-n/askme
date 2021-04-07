module QuestionsHelper
  def correct_of_declination(question_count)
    ostatok10 = question_count % 10
    ostatok100 = question_count % 100
    return "#{question_count} вопросов" if ostatok100.between?(11, 14)
    return "#{question_count} вопрос" if ostatok10 == 1
    return "#{question_count} вопроса" if ostatok10.between?(2, 4)
    return "#{question_count} вопросов" if ostatok10.between?(5, 9) || ostatok10.zero?
  end
end
