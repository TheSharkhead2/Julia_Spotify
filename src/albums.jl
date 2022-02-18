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

"""
Get tracks for a specific album: https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-albums-tracks

"""
function get_album_tracks(spotifyDetails::SpotifyDetails, album_id::String; limit::Int=50, market::String="US", offset::Int=0)
    urlextention = "albums/$(album_id)/tracks?limit=$(limit)&offset=$(offset)&market=$(market)" # get album tracks extension 

    spotify_request(spotifyDetails, urlextention) # make request

end # function get_album_tracks

"""
Get list of albums saved in user library: https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-saved-albums
Required scope: user-library-read

"""
function get_saved_albums(spotifyDetails::SpotifyDetails; limit::Int=50, market::String="US", offset::Int=0)
    urlextention = "me/albums?limit=$(limit)&offset=$(offset)&market=$(market)" # get saved albums extension 

    spotify_request(spotifyDetails, urlextention) # make request

end # function get_saved_albums

"""
Saves albums to user library: https://developer.spotify.com/documentation/web-api/reference/#/operations/save-albums-user
Required scope: user-library-modify

"""
function save_albums(spotifyDetails::SpotifyDetails, album_ids::Vector{String})
    album_idsString = join(album_ids, ",") # join the album ids with a comma

    album_ids_uri = HTTP.escapeuri(album_idsString) # perform url encoding 

    urlextention = "me/albums?ids=$(album_ids_uri)" # get saved albums extension

    spotify_request(spotifyDetails, urlextention; method="PUT") # make request

end # function save_album