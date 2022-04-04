"""
Get information on a playlist: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-playlist

"""
function get_playlist(spotifyDetails::SpotifyDetails, playlist_id::String)
    urlextension = "playlists/$(playlist_id)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_playlist

"""
Gets items from playlists:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-playlists-tracks

"""
function get_playlist_items(spotifyDetails::SpotifyDetails, playlist_id::String; kwargs...)
    validKwargs = [:limit, :market, :offset] # valid keyword arguments

    url_extension = "playlists/$(playlist_id)/tracks?" # get url extension

    for arg in kwargs
        if arg[1] ∈ validKwargs 
            url_extension *= "$(arg[1])=$(arg[2])"
        end # if 
    end # for

    spotify_request(spotifyDetails, url_extension) # make request

end # function get_playlist_items
