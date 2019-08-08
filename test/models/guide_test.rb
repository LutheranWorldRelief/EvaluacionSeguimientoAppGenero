# == Schema Information
#
# Table name: guides
#
#  id         :bigint           not null, primary key
#  title      :string
#  file       :string
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GuideTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
