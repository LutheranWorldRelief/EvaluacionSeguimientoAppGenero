# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  phone_number           :string
#  country                :string
#  organization_name      :string
#  zipcode                :string
#  organization_type      :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diagnostics, -> { where(:archived_date => nil).order('created_at DESC') }
  has_many :diagnostics_archived, -> { where.not(:archived_date => nil).order('created_at DESC') }, foreign_key: :user_id, class_name: 'Diagnostic'
  has_many :diagnostics_all, -> { order('created_at DESC') }, foreign_key: :user_id, class_name: 'Diagnostic'
  has_one :admin, primary_key: 'email', foreign_key: 'email'

  def is_admin
    !!admin
  end

  def country_name
    country = self.country
    ISO3166::Country[country]
  end

  def is_women_exclusive
    return organization_type == 'Exclusiva para mujeres'
  end

  def is_men_exclusive
    return organization_type == 'Exclusiva para hombres'
  end

end
