class Request < ActiveRecord::Base

  serialize :sent_headers

  before_validation :default_url_protocol
  before_save :do_request

  def default_url_protocol
    self.url = 'http://' + url unless url.start_with? 'http://' or url.start_with? 'https://'
  end

  def do_request
    @curl = Curl::Easy.new(url)
    @curl.follow_location = redirects?
    self.sent_headers = []
    @curl.on_debug { |type, data| self.sent_headers << data if type == Curl::CURLINFO_HEADER_OUT }

    @curl.http_get

    self.response_headers  = @curl.header_str
    #self.type    = url =~ /(\.js)$/ ? 'js' : @curl.content_type
    #self.body    = @curl.body_str
  end

  def self.method_options
    ['GET']
  end

end
