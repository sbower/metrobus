module Metrobus
  # Direction class - domain object representing the directions for a route
  class Direction < Base
    # Path for the direction endpoint
    DIRECTIONS_PATH = 'Directions/'.freeze

    attr_accessor :text, :value

    alias direction_name text
    alias direction_id value

    # Get direction information for a a given route
    # @param route_id [String] route_id for a metro route
    # @return [array] of Metrobus::Direction objects
    def self.get(route_id, connection = Metrobus.connection)
      directions = connection.request(DIRECTIONS_PATH + route_id)
      directions.map { |hash| new(hash) }
    end
  end
end
