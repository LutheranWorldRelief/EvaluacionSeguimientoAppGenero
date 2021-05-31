# == Schema Information
#
# Table name: answers
#
#  id              :bigint           not null, primary key
#  answer_question :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  question_id     :bigint
#  user_email      :string
#  survey          :string
#  counter         :integer
#  diagnostic_id   :bigint
#  survey_id       :bigint
#

class Answer < ApplicationRecord
	belongs_to :question
	has_one :section, through: :question
	belongs_to :survey_obj, foreign_key: "survey_id", class_name: 'Survey'
	belongs_to :diagnostic

	def value
		answer_question
	end

	def value=(value)
		answer_question = value
	end
end
