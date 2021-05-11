# == Schema Information
#
# Table name: questions
#
#  id               :bigint           not null, primary key
#  question         :text
#  question_type    :string
#  status           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  section_id       :bigint
#  recommendation   :text
#  discard_question :string
#

class Question < ApplicationRecord
	belongs_to :section, required: true
	has_many :answers, dependent: :destroy

	def discard_when_women
		return discard_question == "Solo cuando la organización sea exclusiva de mujeres"
	end

	def discard_when_mem
		return discard_question == "Solo cuando la organización sea exclusiva de hombres"
	end
end
