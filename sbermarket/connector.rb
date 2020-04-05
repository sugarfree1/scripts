require 'json'
require 'rest-client'

class Connector
  attr_accessor :url

  def initialize(url)
    self.url = url
  end

  def get_shipments(watchup_date)
    JSON.load(RestClient.get "#{url}?date=#{watchup_date}", {accept: :json})
  end
end
