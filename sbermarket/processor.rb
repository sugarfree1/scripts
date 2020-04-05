class Processor
  class << self
    def process(data)
      shipping_rates = data['shipping_rates']

      if shipping_rates == []
        { code: :not_ready, success: false }
      else
        free_intervals = shipping_rates.select do |rate|
          rate['delivery_window']['available']
        end

        if free_intervals.length.zero?
          { code: :no_intervals, success: false }
        else
          interval = free_intervals.first

          { code: :found_interval, success: true, interval: interval }
        end
      end
    end
  end
end
