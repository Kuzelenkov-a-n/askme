module QuestionsHelper
  def correct_of_declination(count, vopros, voprosa, voprosov)
    ostatok10 = count % 10
    ostatok100 = count % 100
    return voprosov if ostatok100.between?(11, 14)
    return vopros if ostatok10 == 1
    return voprosa if ostatok10.between?(2, 4)
    return voprosov
  end
end
