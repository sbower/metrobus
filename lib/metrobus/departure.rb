module Metrobus
  # Departure class - domain object representing the departure times
  class Departure < Base
    attr_accessor :actual, :blockNumber, :departuretext, :departuretime,
                  :description, :Gate, :route, :routeDirection, :terminal, :vehicleheading,
                  :vehiclelatitude, :vehiclelongitude

    # Get next depature time in minutes
    # @return [String] of next departure time in mintues
    def get_next_departure_time
      if @actual
        @departuretext
      else
        @departuretime =~ /Date\((\d+)-\d+\)/
        departure_time = Time.at(Regexp.last_match(1).to_i / 1000)
        minutes = ((departure_time - Time.now) / 60).round
        "#{minutes} Min"
      end
    end

    # Get departure information for a a given route, direction and stop
    # @param route_id [String] route_id for a metro route
    # @param direction_id [String] direction_id attached to the route
    # indicating north, south, east or west
    # @param stop_id [String] stop id for a metro route
    # @return [array] of Metrobus::Departure objects
    def self.get(route_id, direction_id, stop_id, connection = Metrobus.connection)
      directions = connection.request("#{route_id}/#{direction_id}/#{stop_id}")
      directions.map { |hash| new(hash) }
    end
  end
end
