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
            url_extension *= "$(arg[1])=$(arg[2])&"
        end # if 
    end # for

    spotify_request(spotifyDetails, url_extension) # make request

end # function get_playlist_items

"""
Adds items to a playlist:
https://developer.spotify.com/documentation/web-api/reference/#/operations/add-tracks-to-playlist
Requires scope: playlist-modify-private

"""
function add_items_to_playlist(spotifyDetails::SpotifyDetails, playlist_id, ids::Vector{String}; kwargs...)
    ids_string = join(ids, ",") # join vector into string

    ids_uri = HTTP.escapeuri(ids_string) # perform url encoding

    url_extension = "playlists/$(playlist_id)/tracks?uris=$(ids_uri)" # get url extension

    for arg in kwargs 
        if arg[1] == :position # only valid other argument is position 
            url_extension *= "&$(arg[1])=$(arg[2])"
        end # if 
    end # for

    spotify_request(spotifyDetails, url_extension; method="POST") # make request

end # function add_items_to_playlist