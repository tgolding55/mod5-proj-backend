class CreateProjectMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :project_messages do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
