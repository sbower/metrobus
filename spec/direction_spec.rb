require 'spec_helper'

describe Metrobus::Direction do
  before do
    data = %([{"Text":"NORTHBOUND","Value":"4"},{"Text":"SOUTHBOUND","Value":"1"}])
    stub_request(:get, Metrobus::NEXT_TRIP + '/' + Metrobus::Direction::DIRECTIONS_PATH + '5')
      .to_return(body: data, status: 200)
  end

  it 'will return valid directions for route 5' do
    directions = Metrobus::Direction.get('5')
    expect(directions.length).to be 2
    expect(directions[0].direction_id).to eq '4'
  end
end
