class Request < ActiveRecord::Base

  attr_accessor :data_keys, :data_values

  before_validation :default_url_protocol
  before_save :do_request

  def default_url_protocol
    self.url = 'http://' + url unless url.start_with? 'http://' or url.start_with? 'https://'
  end

  def do_request
    @curl = Curl::Easy.new(url)
    @curl.follow_location = redirects?
    self.sent_headers = ''
    @curl.on_debug { |type, data| self.sent_headers += data if type == Curl::CURLINFO_HEADER_OUT }

    execute_curl

    self.response_headers = @curl.header_str
    self.response_type    = url =~ /(\.js)$/ ? 'js' : @curl.content_type
    self.response_body    = @curl.body_str
  end

  def execute_curl
    case method
    when 'GET'
      @curl.http_get
    when 'POST'
      @curl.http_post raw_body
    end
  end

  def post_data
    # Hash[data_keys, data_values]
    Hash[raw_body.split("&").collect { |p| p.split '=' }] rescue []
  end

  def host
    url.match(/https?:\/\/([^\/]+)/)[1] rescue nil
  end

  def self.method_options
    ['GET', 'POST']
  end

end
