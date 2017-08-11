class CreateJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :posts, :tags do |t|
      t.index :post_id #fk from post
      t.index :tag_id #fk from tag
    end
  end
end
