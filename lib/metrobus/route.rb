module Metrobus
  # Route class - domain object representing routes for the day
  class Route < Base
    # Path for the route endpoint
    ROUTES_PATH = 'Routes'.freeze

    attr_accessor :description, :providerid, :route, :directions

    # Override for the initialization of the Route object that retreives the
    # directions for this route.
    # @param hash [Hash] key value hash constructed for JSON from the rest service
    # @return [Object] of Metrobus::Route
    def initialize(hash)
      super(hash)
      @directions = Metrobus::Direction.get(@route)
    end

    # Finds directions_id containing the passed in direction_name for this route
    # @param direction_name [String] direction_name a user is looking for
    # @return [String] representing the diretion_id for the given route
    def get_direction_id(direction_name)
      matching_directions = @directions.find do |matching_direction|
        matching_direction.direction_name.downcase.include?(direction_name.downcase)
      end

      matching_directions.direction_id if matching_directions
    end

    # Returns all valid routes for the day
    # @return [array] of Metrobus::Route objects
    def self.all(connection = Metrobus.connection)
      routes = connection.request(ROUTES_PATH)
      routes.map { |hash| new(hash) }
    end

    # Finds routes containing the passed in route name
    # @param route_name [String] route_name a user is looking for
    # @return [array] of Metrobus::Route objects
    def self.find(route_name, routes = all)
      if routes
        routes.find_all { |route| route.description.downcase.include?(route_name.downcase) }
      end
    end
  end
end
