"""
Get information on a playlist: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-playlist

"""
function get_playlist(spotifyDetails::SpotifyDetails, playlist_id::String)
    urlextension = "playlists/$(playlist_id)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_playlist
