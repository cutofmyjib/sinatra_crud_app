class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content, null: false
      t.boolean :complete, :default => false

      t.timestamps null: false
    end
  end
end

