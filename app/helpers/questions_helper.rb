module QuestionsHelper
  def correct_of_declination(count, vopros, voprosa, voprosov)
    ostatok10 = count % 10
    ostatok100 = count % 100
    voprosov if ostatok100.between?(11, 14)
    vopros if ostatok10 == 1
    voprosa if ostatok10.between?(2, 4)
    voprosov
  end
end
