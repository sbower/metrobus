module Metrobus
  # Connection class - provides an abstration to the rest endpoint
  class Connection
    # Sends rest request to the metrobus REST service
    # @param path [String] path string
    # @param verb [String] get, post, head, etc.
    # @param post_data [String] if sending a post, this data will be sent in the body
    # @return [Hash] constructed from the parsed JSON
    def request(path, verb = :get, post_data = {})
      path = URI.escape(Metrobus::NEXT_TRIP + '/' + path)

      JSON.parse(
        RestClient::Request.execute(
          construct_request_hash(path, verb, post_data)
        )
      )
    end

    # Sends rest request to the metrobus REST service
    # @param path [String] path string
    # @param verb [String] get, post, head, etc.
    # @param post_data [String] if sending a post, this data will be sent in the body
    # @return [Hash] constructed to send to rest-client
    def construct_request_hash(path, verb, post_data)
      opts = { payload: post_data.to_json }
      verb = verb.to_sym if verb.is_a? String
      {
        method: verb,
        url: path,
        headers: {
          Accept: 'application/json'
        }
      }.merge(opts).reject { |_, v| v.nil? }
    end
  end
end
