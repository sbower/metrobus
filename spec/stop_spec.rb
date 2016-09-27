require 'spec_helper'

describe Metrobus::Stop do
  before do
    data = %([{"Text":"Blegen Hall ","Value":"BLHA"},
      {"Text":"23rd Ave TCF Bank Stadium","Value":"23TC"},
      {"Text":"Transitway Commonwealth","Value":"TWCO"},
      {"Text":"St Paul Student  Center","Value":"SPSC"}])
    stub_request(:get, Metrobus::NEXT_TRIP + '/' + Metrobus::Stop::STOPS_PATH + '121/2')
      .to_return(body: data, status: 200)

    data = %([])
    stub_request(:get, Metrobus::NEXT_TRIP + '/' + Metrobus::Stop::STOPS_PATH + '121/4')
      .to_return(body: data, status: 200)
  end

  it 'will return valid stops for route 121 direction 2' do
    stops = Metrobus::Stop.get('121', '2')
    expect(stops.length).to be 4
    expect(stops[0].stop_id).to eq 'BLHA'
  end

  it 'will find the stop named Blegen' do
    found_stops = Metrobus::Stop.find('Blegen', '121', '2')
    expect(found_stops.length).to eq 1
    expect(found_stops[0].stop_id).to eq 'BLHA'
  end

  it 'will not find a stop named Arnold' do
    found_stops = Metrobus::Stop.find('Arnold', '121', '2')
    expect(found_stops).to be_empty
  end

  it 'will not find the stop named Blegen going the wrond direction' do
    found_stops = Metrobus::Stop.find('Blegen', '121', '4')
    expect(found_stops).to be_empty
  end
end
