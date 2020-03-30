require 'rest-client'
require 'date'
require 'json'

url = ARGV[0]

today = Date.today

(0..6).to_a.reverse.each do |offset|
  watchup_date = today + offset

  data = RestClient.get "#{url}?date=#{watchup_date}", {accept: :json}

  shipping_rates = JSON.load(data)['shipping_rates']

  if shipping_rates == []
    puts "#{watchup_date} — not ready"
  else
    free_intervals = shipping_rates.select { |rate| rate['is_free'] }

    if free_intervals == []
      puts "#{watchup_date} — no intervals"
    else
      puts "#{watchup_date} — found free interval"
    end
  end

  puts "\n"

  sleep(2)
end
