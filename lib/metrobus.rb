
require 'json'
require 'rest-client'
require 'date'

# Metrobus module used to interact with the rest api at
# http://svc.metrotransit.org/NexTrip providing providing
# realtime departure data
module Metrobus
  require 'metrobus/version'
  require 'metrobus/base'
  require 'metrobus/connection'
  require 'metrobus/route'
  require 'metrobus/direction'
  require 'metrobus/stop'
  require 'metrobus/departure'

  # The REST endpoint for the metro transit realtime departure service
  NEXT_TRIP = 'http://svc.metrotransit.org/NexTrip'.freeze

  # get REST connection object to use, if non create a new object
  # @return [Object] of type Metrobus::Conenction
  def connection
    @connection ||= Connection.new
  end

  module_function :connection
end
