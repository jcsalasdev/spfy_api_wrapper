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
                    "Authorization" => "Bearer BQAeXH6LfsmOtpwoA0u4rRnRDWufR3zFXPl84EQX9dAheqd62d_0PSQsNXA26n37Z3VD07kVeI_68LL2PrxnX2VYIqFmbWPcyrxR_uRS-Oo5hNLsDf5v28CfBW3Ho0cL8VlSkU7tBNhXvT5eyu6VDGixitlechwKGaFivUTk4QyFSM6u4RFQshee59RQSJzqTmWQdRCTSgGGP_-0F44armAb"
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