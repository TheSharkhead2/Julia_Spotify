"""
Get information on a single artist: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-artist

"""
function get_artist(spotifyDetails::SpotifyDetails, artist_id::String)
    urlextension = "artists/$(artist_id)" # get request extension 

    spotify_request(spotifyDetails, urlextension) # make request 

end # function get_artist

"""
Gets information on several artists: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-multiple-artists

"""
function get_multiple_artists(spotifyDetails::SpotifyDetails, artist_ids::Vector{String})
    artist_idsString = join(artist_ids, ",") # join the artist ids with a comma

    artist_ids_uri = HTTP.escapeuri(artist_idsString) # perform url encoding

    urlextension = "artists?ids=$(artist_ids_uri)" # create url extension 

    spotify_request(spotifyDetails, urlextension) # make request 

end # function get_multiple_artists

"""
Gets albums from the specified artist: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-artists-albums

# Arguments 

* spotifyDetails::SpotifyDetails
    * Authenticated SpotifyDetails object 

* artist_id::String
    * Spotify artist ID

* include_groups::Vector{String}
    * Optional. Default: ["album", "single", "appears_on", "compilation"] (all options). A list of all the *types* of albums that will be used to filter the response. Valid values are: "album", "single", "appears_on", "compilation"

* limit::Int
    * Optional. Default: 20. The maximum number of items to return. 

* offset::Int
    * Optional. Default: 0. The index of the first item to return. IE: if it was going to return: ["album1", "album2", "album3"] an offset of 2 would return: ["album2", "album3"]

* market::String
    * Optional. Default: "US". An ISO 3166-1 alpha-2 country code. 

"""
function get_artist_albums(spotifyDetails::SpotifyDetails, artist_id::String; include_groups::Vector{String}=["album", "single", "appears_on", "compilation"], limit::Int=20, offset::Int=0, market::String="US")
    include_groupsString = join(include_groups, ",") # join into comma seperated string 

    include_groups_uri = HTTP.escapeuri(include_groupsString) # perform url encoding
    
    urlextension = "artists/$(artist_id)/albums?include_groups=$(include_groups_uri)&limit=$(limit)&offset=$(offset)&market=$(market)" # get request extension

    spotify_request(spotifyDetails, urlextension) # make request 

end # function get_artist_albums

"""
Function to get top tracks for a given artist: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-artists-top-tracks

"""
function get_artist_top_tracks(spotifyDetails::SpotifyDetails, artist_id::String; market::String="US")
    urlextension = "artists/$(artist_id)/top-tracks?market=$(market)" # get request extension 

    spotify_request(spotifyDetails, urlextension) # make request 

end # function get_artist_top_tracks

"""
Gets related artists to specified artist:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-artists-related-artists

"""
function get_artist_related_artists(spotifyDetails::SpotifyDetails, artist_id::String)
    urlextension = "artists/$(artist_id)/related-artists" # get request extension 

    spotify_request(spotifyDetails, urlextension) # make request 

end # function get_artist_related_artists
