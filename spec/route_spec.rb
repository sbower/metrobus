require 'spec_helper'

describe Metrobus::Route do
  before do
    data = %([{"Description":"METRO Blue Line","ProviderID":"8","Route":"901"},
      {"Description":"METRO Green Line","ProviderID":"8","Route":"902"},
      {"Description":"METRO Red Line","ProviderID":"9","Route":"903"}])
    stub_request(:get, Metrobus::NEXT_TRIP + '/' + Metrobus::Route::ROUTES_PATH)
      .to_return(body: data, status: 200)

    data = %([{"Text":"NORTHBOUND","Value":"4"},{"Text":"SOUTHBOUND","Value":"1"}])
    stub_request(:get, %r{http:\/\/svc.metrotransit.org\/NexTrip\/Directions\/\d+})
      .to_return(body: data, status: 200)
  end

  it 'will find a route with substring blue' do
    expect(Metrobus::Route.find('blue')).to_not be_empty
  end

  it 'will not a route with find substring purple' do
    expect(Metrobus::Route.find('purple')).to be_empty
  end

  it 'will find the route id for METRO Green Line' do
    found_routes = Metrobus::Route.find('METRO Green Line')
    expect(found_routes.length).to eq 1
    expect(found_routes[0].route).to eq '902'
  end

  it 'will operate on a set of passed in routes' do
    routes = [
      Metrobus::Route.new(description: 'blue', providerid: '9', route: '1'),
      Metrobus::Route.new(description: 'purple', providerid: '9', route: '3'),
      Metrobus::Route.new(description: 'red', providerid: '9', route: '11')
    ]

    found_routes = Metrobus::Route.find('purple', routes)
    expect(found_routes.length).to eq 1
    expect(found_routes[0].route).to eq '3'
  end

  it 'will contain the valid directions for the route METRO Green Line' do
    found_routes = Metrobus::Route.find('METRO Green Line')
    expect(found_routes[0].directions.length).to be 2
    expect(found_routes[0].directions[1].direction_id).to eq '1'
  end

  it 'will find the correct direction id of METRO Green Line going north' do
    found_routes = Metrobus::Route.find('METRO Green Line')
    expect(found_routes[0].get_direction_id('north')).to eq '4'
  end

  it 'will find nil for direction id of METRO Green Line going east' do
    found_routes = Metrobus::Route.find('METRO Green Line')
    expect(found_routes[0].get_direction_id('east')).to be_nil
  end
end
