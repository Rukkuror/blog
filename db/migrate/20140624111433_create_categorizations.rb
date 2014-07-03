class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :tag_id
      t.integer :post_id
      t.timestamps
    end
  end
end
