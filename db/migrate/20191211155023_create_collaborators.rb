class CreateCollaborators < ActiveRecord::Migration[6.0]
  def change
    create_table :collaborators do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.text :role

      t.timestamps
    end
  end
end
