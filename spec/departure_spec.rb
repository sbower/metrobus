require 'spec_helper'

describe Metrobus::Departure do
  before do
    data = %([{"Actual":true,"BlockNumber":1115,"DepartureText":"3 Min",
      "DepartureTime":"\/Date(1474995180000-0500)\/",\
      "Description":"Emerson\/26Av-Broadway","Gate":"","Route":"5",
      "RouteDirection":"NORTHBOUND","Terminal":"F","VehicleHeading":0,
      "VehicleLatitude":44.9784,"VehicleLongitude":-93.27553},
      {"Actual":true,"BlockNumber":1139,"DepartureText":"12 Min",
      "DepartureTime":"\/Date(1474995720000-0500)\/",
      "Description":"Fremont Av\/Brklyn Ctr\/Transit Ctr","Gate":"","Route":"5",
      "RouteDirection":"NORTHBOUND","Terminal":"M",
      "VehicleHeading":0,"VehicleLatitude":44.966816,"VehicleLongitude":-93.262549}])
    stub_request(:get, Metrobus::NEXT_TRIP + '/5/4/7SOL')
      .to_return(body: data, status: 200)

    data = %([{"Actual":false,"BlockNumber":1143,"DepartureText":"12:17",
      "DepartureTime":"\/Date(#{(Time.now + 300).to_i * 1000}-0500)\/",
      "Description":"Fremont Av\/Brklyn Ctr\/Transit Ctr","Gate":"","Route":"5",
      "RouteDirection":"NORTHBOUND","Terminal":"M","VehicleHeading":0,
      "VehicleLatitude":44.94971,"VehicleLongitude":-93.26257}])
    stub_request(:get, Metrobus::NEXT_TRIP + '/121/2/BLHA')
      .to_return(body: data, status: 200)

    data = %([])
    stub_request(:get, Metrobus::NEXT_TRIP + '/5/1/7SOL')
      .to_return(body: data, status: 200)
  end

  it 'will return a valid depature time for route 5 direction 4 stop 7SOL (actual)' do
    departures = Metrobus::Departure.get('5', '4', '7SOL')
    expect(departures.length).to be 2
    expect(departures[0].get_next_departure_time).to eq '3 Min'
  end

  it 'will return a valid depature time for route 121 direction 2 stop BLHA (calculated)' do
    departures = Metrobus::Departure.get('121', '2', 'BLHA')
    expect(departures.length).to be 1
    expect(departures[0].get_next_departure_time).to eq '5 Min'
  end

  it 'will not find depatrues for route 5 direction 1 stop 7SOL' do
    departures = Metrobus::Departure.get('5', '1', '7SOL')
    expect(departures).to be_empty
  end
end
