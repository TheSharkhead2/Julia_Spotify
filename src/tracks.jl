"""
Get information on specified track: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track

"""
function get_track(spotifyDetails::SpotifyDetails, track_id::String; market::String="US")
    urlextension = "tracks/$(track_id)?market=$(market)" # get url extension 
    
    spotify_request(spotifyDetails, urlextension) # make request

end # function get_track

"""
Get information on several tracks:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-several-tracks

"""
function get_multiple_tracks(spotifyDetails::SpotifyDetails, track_ids::Vector{String}; market::String="US")
    track_idsString = join(track_ids, ",") # join vector into string

    track_ids_uri = HTTP.escapeuri(track_idsString) # perform url encoding

    urlextension = "tracks?ids=$(track_ids_uri)&market=$(market)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request 

end # function get_multiple_tracks

""" 
Get tracks saved in user's library: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-saved-tracks
Requires scope: user-library-read

"""
function get_user_tracks(spotifyDetails::SpotifyDetails; limit::Int=50, offset::Int=0, market::String="US")
    urlextension = "me/tracks?limit=$(limit)&offset=$(offset)&market=$(market)" # get url extension 

    spotify_request(spotifyDetails, urlextension) # make request
    
end # function get_user_tracks