class CreateProjectComments < ActiveRecord::Migration[6.0]
  def change
    create_table :project_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
