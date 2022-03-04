class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_column :polls, :author_id, :integer, null: false
    add_column :questions, :poll_id, :integer, null: false
    add_column :answer_choices, :question_id, :integer, null: false


    
  end
end
