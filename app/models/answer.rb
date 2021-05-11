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
#

class Answer < ApplicationRecord
	belongs_to :question
end
