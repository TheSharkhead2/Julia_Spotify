"""
Get an album: https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-album

# Arguments 

* spotifyDetails::SpotifyDetails
    * Authenticated SpotifyDetails struct 

* album_id::String
    * The Spotify ID for the album.

* market::String, optional 
    * The market for the album. Default = "US"

# Returns

* response::Dict(String, Any)
    * The response from the Spotify API.

"""
function get_album(spotifyDetails::SpotifyDetails, album_id::String; market::String="US")
    urlextention = "albums/$(album_id)?market=$(market)" # get album extension 

    spotify_request(spotifyDetails, urlextention) # make request

end # function get_album


"""
Get several albums: https://developer.spotify.com/documentation/web-api/reference/#/operations/get-multiple-albums
Effectively the same as above, just for multiple albums as a time. 

"""
function get_multiple_albums(spotifyDetails::SpotifyDetails, album_ids::Vector{String}; market::String="US")
    album_idsString = join(album_ids, ",") # join the album ids with a comma

    album_ids_uri = HTTP.escapeuri(album_idsString) # perform url encoding

    urlextention = "albums?ids=$(album_ids_uri)&market=$(market)" # get albums extension 

    spotify_request(spotifyDetails, urlextention) # make request

end # function get_multiple_albums