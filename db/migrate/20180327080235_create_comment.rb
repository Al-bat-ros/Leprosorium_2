class CreateComment < ActiveRecord::Migration[5.1]
  def change

  	create_table :comments do |t|
  		t.belongs_to :post, index: true
  		t.text :name
  		t.text :content

  		t.timestamps
  	end
  end
end
