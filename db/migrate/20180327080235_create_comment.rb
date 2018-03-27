class CreateComment < ActiveRecord::Migration[5.1]
  def change

  	create_table :comments do |t|
  		t.text :name
  		t.text :content
        t.integer :post_id

  		t.timestamps
  	end
  end
end
