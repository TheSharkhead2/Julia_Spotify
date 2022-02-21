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


