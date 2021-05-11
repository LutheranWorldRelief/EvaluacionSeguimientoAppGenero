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

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
