class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.text :title
      t.text :description
      t.text :technologies_used
      t.integer :collaborator_size_limit
      t.text :status

      t.timestamps
    end
  end
end
