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

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
