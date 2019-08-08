class AddUserEmailToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :user_email, :string
  end
end
