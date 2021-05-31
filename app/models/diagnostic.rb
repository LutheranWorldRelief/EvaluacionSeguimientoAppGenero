# == Schema Information
#
# Table name: diagnostics
#
#  id         :bigint           not null, primary key
#  user_email :string
#  counter    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#

class Diagnostic < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :surveys, -> { group 'surveys.id'},
           through: :answers,
           :source => :survey_obj

  def complete_porc(surveys_total)
    len = surveys.length
    result = 0
    if surveys_total > 0
      result = 100 * (len.to_f / surveys_total.to_f)
    end
    result.round
  end

  def is_complete(surveys_total)
    surveys_total > 0 ?
        surveys.length == surveys_total :
        false
  end

  def surveys_ids
    surveys.map {|s| s.id }
  end

  # @param [Survey] survey
  def has_survey(survey)
    has_survey_id(survey.id)
  end

  # @param [Integer] survey_id
  def has_survey_id(survey_id)
    ids = surveys_ids
    ids.include? survey_id
  end

  def self.counter_next(user_id)
    self.where({ user_id: user_id })
        .maximum(:counter)
        .next
  end

end
