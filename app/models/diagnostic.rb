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

  @@survey_order = [5, 6, 7, 8]

  def self.first_survey_id_to_create
    order = @@survey_order
    order[0]
  end

  def self.counter_next(user_id)
    self.where({ user_id: user_id })
        .maximum(:counter)
        .next
  end

  def complete_porc(surveys_total)
    len = surveys.length
    result = 0
    if surveys_total > 0
      result = 100 * (len.to_f / surveys_total.to_f)
    end
    result.round
  end

  def can_create_survey_id(id)
    next_survey_id_to_create == id.to_i
  end

  def first_survey_id
    @@survey_order[0]
  end

  def next_survey_id_to_create
    order = @@survey_order
    order[next_survey_index_to_create]
  end

  def next_survey_index(id)

    order = @@survey_order
    if order.length == 0
      return nil
    end

    idx = order.index(id.to_i)
    if idx.nil?
      return nil
    end

    idx+1
  end

  def next_survey_id(id)

    order = @@survey_order
    idx = next_survey_index(id)
    if idx.nil?
      return nil
    end
    order[idx]
  end

  def next_survey_index_to_create
    idx = -1
    order = @@survey_order
    surveys_ids.each_with_index do |s, i|
      if	order[i] != s
        break
      end
      idx = i
    end

    idx+1
  end


  def is_complete(surveys_total)
    surveys_total > 0 ?
        surveys.length == surveys_total :
        false
  end

  def surveys_ids
    ids = surveys.map {|s| s.id }
    ids.sort
  end

  # @param [Survey] survey
  def has_survey(survey)
    has_survey_id(survey.id)
  end

  # @param [Integer] survey_id
  def has_survey_id(survey_id)
    if survey_id.nil?
      return false
    end
    ids = surveys_ids
    ids.include? survey_id
  end

end
