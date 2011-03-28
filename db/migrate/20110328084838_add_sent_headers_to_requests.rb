class AddSentHeadersToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :sent_headers, :string
  end

  def self.down
    remove_column :requests, :sent_headers
  end
end
