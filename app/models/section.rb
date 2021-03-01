# == Schema Information
#
# Table name: sections
#
#  id                      :bigint           not null, primary key
#  name                    :string
#  status                  :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  survey_id               :bigint
#  gap_porcent             :integer
#  recommendation          :text
#  gap_max                 :integer
#  recommendation_negative :text
#  recommendation_gap_max  :text
#  recommendation_no_data  :text
#

class Section < ApplicationRecord
	belongs_to :survey, required: true
	has_many :questions, dependent: :destroy

	def question_types
		values = [];
		questions.each do | question |
			values << question.question_type
		end
		return values
	end

	def is_numeric
		questionTypes = question_types()

		(questionTypes.include?("Número") ||
			questionTypes.include?("Moneda") ||
			questionTypes.include?("Decimal")) && questionTypes.include?("Checkbox No data")
	end

	def is_range
		questionTypes = question_types()

		(questionTypes.include?("Rango de Numeros"))
	end

	def is_checkbox
		questionTypes = question_types()

		(questionTypes.include?("Checkbox"))
	end

end
