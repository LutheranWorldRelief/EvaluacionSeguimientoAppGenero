# == Schema Information
#
# Table name: surveys
#
#  id                 :bigint           not null, primary key
#  name               :string
#  status             :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  indications        :text
#  code               :string
#  recommendation_one :text
#  recommendation_two :text
#  advice_message     :text
#

class Survey < ApplicationRecord
	has_many :sections, dependent: :destroy
end
