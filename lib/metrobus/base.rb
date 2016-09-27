module Metrobus
  # Base class - containes base functions used by other classes
  # provides a facility for easily initializing classes.
  class Base
    attr_accessor :connection

    # Initialization of metrobus objects from  JSON from the REST service
    # @param hash [Hash] key value hash constructed from JSON from the rest service
    # @return [Object]
    def initialize(hash = {}, connection = Metrobus.connection)
      raise ArgumentError,
            "Expected a Metrobus::Connection, got: #{connection}." unless connection.is_a?(Metrobus::Connection)
      @connection = connection
      hash.each { |name, value| instance_variable_set("@#{name.downcase}", value) }
    end
  end
end
