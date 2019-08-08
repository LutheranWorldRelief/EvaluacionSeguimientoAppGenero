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

class Guide < ApplicationRecord
	mount_uploader :file, FileUploader
end
