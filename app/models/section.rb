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
	attr_accessor :answers_idx, :questions_idx_type, :questions_idx
	belongs_to :survey, required: true
	has_many :questions, dependent: :destroy

	after_find do |section|
		section.answers_idx = {}
		section.questions_idx	 = questions.index_by{ |q| q.id }
		section.questions_idx_type = questions.index_by{ |q| q.question_type }
	end

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

	def is_no_data(type="Checkbox No data", value="No data")
		values = answers_idx.values.map{ |a| a.answer_question }
		questions_idx_type.keys.include? type and values.include? value
	end

	def is_confirm(type="Checkbox No data", value="Confirm")
		values = answers_idx.values.map{ |a| a.answer_question }
		questions_idx_type.keys.include? type and values.include? value
	end

	def is_confirm_or_no_data(type="Checkbox No data", confirm="Confirm", no_data="No data")
		is_confirm(type, confirm) || is_no_data(type, no_data)
	end

end
