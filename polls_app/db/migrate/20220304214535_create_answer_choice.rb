class CreateAnswerChoice < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_choices do |t|
      t.text :text, null:false

      t.timestamps
    end
  end
end
