require 'rspec'
require 'json'
require '../processor'

RSpec.describe Processor do
  it 'returns free interval' do
    data = Processor.process(JSON.load(File.open('./data/get_shipping_rates_free_interval.json').read()))

    expect(data).to eq(code: :found_interval,
                       interval: {
                           'delivery_window' => {
                               "available"=>true,
                               "date"=>"2020-04-11",
                               "ends_at"=>"2020-04-11T12:00:00.000+03:00",
                               "human_interval"=>"10:00-12:00",
                               "id"=>865888,
                               "serial"=>1,
                               "starts_at"=>"2020-04-11T10:00:00.000+03:00",
                               "surge_amount"=>0.0,
                               "time_zone"=>"Europe/Moscow"},
                           "is_boost"=>false,
                           "is_drop"=>false,
                           "is_free"=>false,
                           "total_value"=>198.0,
                           "value"=>289.0},
                       success: true)
  end

  it 'returns no intervals' do
    data = Processor.process(JSON.load(File.open('./data/get_shipping_rates_no_intervals.json').read()))

    expect(data).to eq(code: :no_intervals,
                       success: false)
  end

  it 'returns not ready' do
    data = Processor.process(JSON.load(File.open('./data/get_shipping_rates_not_ready.json').read()))

    expect(data).to eq(code: :not_ready,
                       success: false)
  end
end