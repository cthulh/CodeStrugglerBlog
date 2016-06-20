class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :confirmed, default: false
      t.timestamps null: false
    end
  end
end
