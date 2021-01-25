class UserAnswers

  # constructor
  def initialize(user_mail, survey, counter)
    @user_email = user_mail
    @survey = survey
    @count = counter
    @answers = Answer.where(user_mail: user_mail, survey: survey, counter: counter)
  end

end