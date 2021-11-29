class PagesController < ApplicationController
    
    def home
        client = Spotify::Client.new
        @featured_playlists = client.featured_playlists["playlists"]["items"]
        @categories = client.categories["categories"]["items"]
        @new_release = client.new_release["albums"]["items"]
        @playlist_tracks = client.playlist_tracks("6rGWNEjHzcnzZimYUOYzD7")["external_urls"]["spotify"]
    end
end