class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.json :history
      t.json :question, null: false
      t.json :answer, null: false, array: true, default: []

      t.timestamps
    end
  end
end
