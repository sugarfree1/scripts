require 'date'

require './connector'
require './processor'

today = Date.today

connector = Connector.new(ARGV[0])

(0..7).to_a.reverse.each do |offset|
  watchup_date = today + offset

  result = Processor.process(connector.get_shipments(watchup_date))

  if result[:success]
    interval = result[:interval]

    puts "#{watchup_date} — found free interval #{interval['delivery_window']['starts_at']} - #{interval['delivery_window']['ends_at']}"
  else
    if result[:code] == :not_ready
      puts "#{watchup_date} — not ready"
    elsif result[:code] == :no_intervals
      puts "#{watchup_date} — no intervals"
    end
  end

  sleep(2)
end
