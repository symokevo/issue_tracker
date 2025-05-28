class CreateIssues < ActiveRecord::Migration[8.0]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.string :status, null: false, default: "New"
      t.integer :priority, null: false, default: 3
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
