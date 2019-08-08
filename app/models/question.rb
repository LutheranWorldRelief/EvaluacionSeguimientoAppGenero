# == Schema Information
#
# Table name: questions
#
#  id             :bigint           not null, primary key
#  question       :text
#  question_type  :string
#  status         :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  section_id     :bigint
#  recommendation :text
#

class Question < ApplicationRecord
	belongs_to :section, required: true
	has_many :answers, dependent: :destroy
end
