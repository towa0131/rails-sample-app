class CreateReplyRelationShips < ActiveRecord::Migration[7.1]
  def change
    create_table :reply_relation_ships do |t|
      t.integer :main_post_id
      t.integer :reply_post_id

      t.timestamps
    end
    add_index :reply_relation_ships, :main_post_id
    add_index :reply_relation_ships, :reply_post_id
  end
end
