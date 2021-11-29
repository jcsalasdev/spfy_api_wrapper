require 'faraday'
module Spotify
    class Client
      
        Base_URL = 	"https://api.spotify.com"
        Client_Id = Rails.application.credentials.spotify[:client_id]
        Client_Secret = Rails.application.credentials.spotify[:client_secret]
        
        include Exceptions

        def featured_playlists
           request(http_method: :get, endpoint: "/v1/browse/featured-playlists")
        end

        def categories
            request(http_method: :get, endpoint: "/v1/browse/categories")
        end

        def new_release
            request(http_method: :get, endpoint: "/v1/browse/new-releases")
        end

        def playlist_tracks(id)
            request(http_method: :get, endpoint: "/v1/playlists/#{id}")
        end

        private

        def request(http_method:, endpoint:)
            @response = connection.public_send(http_method, endpoint)
            parsed_response = JSON.parse(@response.body)
            return parsed_response if @response.status == 200
            raise error_class
        end

        def connection
            @connection ||= Faraday.new(
                url: Base_URL,
                headers: {
                    "Authorization" => "Bearer BQCAejNGkGnxp0nwCKjBCLHCxOuc7PLl4tQs-V6P--Vqy-N79Tvrbf6kD98tLNqMlyEmaeC2hKPOOusucD7Qqv6JyXJNS2QoqkhjgzM1y4cBTfWSrw4l44opRhjQknAZz0OKdOr79Wqc5XqLY3EiQ6HujkLKM7wLVgxSqLSjcUtNjXN0obmHGDKbxqBDBXkkMhj5NxF62VBVLItVe6m1u_8u"
                },
            )
        end

        def error_class
            case @response.status
            when 404
              NotFoundError
            when 401
              UnauthorizedError
            else
              ApiError
            end
          end
    end
end