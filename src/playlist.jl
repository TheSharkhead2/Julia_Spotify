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

Items must be in uri form.

"""
function add_items_to_playlist(spotifyDetails::SpotifyDetails, playlist_id, uris::Vector{String}; kwargs...)
    uris_string = join(uris, ",") # join vector into string

    uris_uri = HTTP.escapeuri(uris_string) # perform url encoding

    url_extension = "playlists/$(playlist_id)/tracks?uris=$(uris_uri)" # get url extension

    for arg in kwargs 
        if arg[1] == :position # only valid other argument is position 
            url_extension *= "&$(arg[1])=$(arg[2])"
        end # if 
    end # for

    spotify_request(spotifyDetails, url_extension; method="POST") # make request

end # function add_items_to_playlist

function update_playlist_items(spotifyDetails::SpotifyDetails)
    throw("Not Implemented Yet")
end # function update_playlist_items

function delete_playlist_items(spotifyDetails::SpotifyDetails)
    throw("Not Implemented Yet")
end # function delete_playlist_items

"""
Return the current user's playlists:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-a-list-of-current-users-playlists
Requires scope: playlist-read-private

"""
function get_current_user_playlists(spotifyDetails::SpotifyDetails; kwargs...)
    validKwargs = [:limit, :offset] # valid keyword arguments

    url_extension = "me/playlists?" # get url extension

    for arg in kwargs
        if arg[1] ∈ validKwargs 
            url_extension *= "$(arg[1])=$(arg[2])&"
        end # if 
    end # for

    spotify_request(spotifyDetails, url_extension) # make request

end # function get_current_user_playlists

"""
Returns the playlists for a specified user: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-list-users-playlists
Requires scope: playlist-read-private

"""
function get_user_playlists(spotifyDetails::SpotifyDetails, user_id::String; kwargs...)
    validKwargs = [:limit, :offset] # valid keyword arguments

    url_extension = "users/$(user_id)/playlists?" # get url extension

    for arg in kwargs
        if arg[1] ∈ validKwargs 
            url_extension *= "$(arg[1])=$(arg[2])&"
        end # if 
    end # for

    spotify_request(spotifyDetails, url_extension) # make request

end # function get_user_playlists

function create_playlist(spotifyDetails::SpotifyDetails)
    throw("Not Implemented Yet")
end # function create_playlist

"""
Gets a list of featured playlists on Spotify homepage (for example):
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-featured-playlists

"""
function get_featured_playlists(spotifyDetails::SpotifyDetails; kwargs...)
    validKwargs = [:country, :locale, :timestamp, :limit, :offset] # valid keyword arguments

    urlextension = "browse/featured-playlists?" # get url extension

    for arg in kwargs
        if arg[1] ∈ validKwargs 
            urlextension *= "$(arg[1])=$(arg[2])&"
        end # if 
    end # for

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_featured_playlists
