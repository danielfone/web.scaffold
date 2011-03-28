class AddResponseHeadersToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :response_headers, :string
  end

  def self.down
    remove_column :requests, :response_headers
  end
end
