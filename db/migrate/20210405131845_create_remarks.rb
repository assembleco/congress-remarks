class CreateRemarks < ActiveRecord::Migration[6.0]
  def change
    create_table :remarks do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.string :place, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
