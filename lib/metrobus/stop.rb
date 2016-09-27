module Metrobus
  # Stop class - domain object representing stops for a route going a specific direction
  class Stop < Base
    # Path for the stop endpoint
    STOPS_PATH = 'Stops/'.freeze

    attr_accessor :text, :value

    alias stop_name text
    alias stop_id value

    # Get stop information for a a given route and direction
    # @param route_id [String] route_id for a metro route
    # @param direction_id [String] direction_id attached to the route
    # indicating north, south, east or west
    # @return [array] of Metrobus::Stop objects
    def self.get(route_id, direction_id, connection = Metrobus.connection)
      stops = connection.request(STOPS_PATH + "#{route_id}/#{direction_id}")
      stops.map { |hash| new(hash) }
    end

    # Finds stops containing the passed in stop name
    # @param stop_name [String] stop_name a user is looking for
    # @param route_id [String] route_id for a metro route
    # @param direction_id [String] direction_id attached to the route
    # indicating north, south, east or west
    # @return [array] of Metrobus::Stop objects
    def self.find(stop_name, route_id, direction_id, stops = get(route_id, direction_id))
      if stops
        stops.find_all { |stop| stop.stop_name.downcase.include?(stop_name.downcase) }
      end
    end
  end
end
