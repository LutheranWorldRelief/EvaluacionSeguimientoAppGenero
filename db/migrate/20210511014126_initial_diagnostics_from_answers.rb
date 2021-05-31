class InitialDiagnosticsFromAnswers < ActiveRecord::Migration[5.2]
  def up
    answers = Answer.select('user_email, counter, MIN(created_at) AS min_created, MIN(updated_at) AS min_updated')
                    .where('diagnostic_id IS NULL')
                    .group('user_email, counter')

    diagnostic_values = []

    # @type answer [Answer]
    answers.each do |answer|

      # @type user [User]
      user = User.where(email: answer.user_email).last

      # @type user [Diagnostic]
      diagnostic_values.push({
                               user_id: user.id,
                               user_email: answer.user_email,
                               created_at: answer.min_created,
                               updated_at: answer.min_updated,
                               counter: answer.counter
                             })
    end

    diagnostics = Diagnostic.create!(diagnostic_values)

    diagnostics.each do |diagnostic|

      Answer.where(user_email: diagnostic.user_email, counter: diagnostic.counter)
            .update_all(diagnostic_id: diagnostic.id)

    end
  end

  def down
    Answer.update_all(diagnostic_id: nil)
    Diagnostic.delete_all
  end
end
