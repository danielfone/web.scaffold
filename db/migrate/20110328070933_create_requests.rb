class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string  :method
      t.string  :url
      t.boolean :redirects

      t.text :raw_body
      t.text :raw_headers

      t.text    :sent_headers
      t.text    :response_headers
      t.text    :response_body
      t.string  :response_type

      t.string :slug

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
