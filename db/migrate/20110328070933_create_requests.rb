class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string :method
      t.string :url
      t.boolean :redirects
      t.text :params
      t.text :headers
      t.string :slug
      t.text :raw_request
      t.text :raw_response

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
