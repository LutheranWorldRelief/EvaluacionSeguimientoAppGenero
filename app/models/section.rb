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
end
