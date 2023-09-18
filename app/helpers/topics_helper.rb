module TopicsHelper

  def check_topic(title)
    if title[0] == "N"
      "Correct"
    else
      "Incorrect"
    end
  end
end
