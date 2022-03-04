class DeleteQuestionId < ActiveRecord::Migration[5.2]
  def change
    remove_column :responses, :question_id
  end
end
