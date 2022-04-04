"""
Get current user's profile:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-current-users-profile
Requires scope: user-read-private user-read-email

"""
function get_current_user_profile(spotifyDetails::SpotifyDetails)
    urlextension = "me" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_user_profile

"""
Get user's top tracks. From here, but specifying tracks:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-top-artists-and-tracks
Requires scope: user-top-read

"""
function get_user_top_tracks(spotifyDetails::SpotifyDetails; limit::Int=50, offset::Int=0, time_range::String="medium_term")
    urlextension = "me/top/tracks?limit=$(limit)&offset=$(offset)&time_range=$(time_range)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_user_top_tracks

"""
Get user's top artists. From here, but specifying artists: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-top-artists-and-tracks
Requires scope: user-top-read

"""
function get_user_top_artists(spotifyDetails::SpotifyDetails; limit::Int=50, offset::Int=0, time_range::String="medium_term")
    urlextension = "me/top/artists?limit=$(limit)&offset=$(offset)&time_range=$(time_range)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_user_top_artists

"""
Get specific user's profile:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-profile 

"""
function get_user_profile(spotifyDetails::SpotifyDetails, user_id::String)
    urlextension = "users/$(user_id)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_user_profile

"""
Get user to follow a playlist:
https://developer.spotify.com/documentation/web-api/reference/#/operations/follow-playlist
Requires scope: playlist-modify-public

"""
function follow_playlist(spotifyDetails::SpotifyDetails, playlist_id::String)
    urlextension = "playlists/$(playlist_id)/followers" # get url extension

    spotify_request(spotifyDetails, urlextension; method="PUT") # make request

end # function follow_playlist

"""
Has current user unfollow a playlist: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/unfollow-playlist
Requires scope: playlist-modify-public

"""
function unfollow_playlist(spotifyDetails::SpotifyDetails, playlist_id::String)
    urlextension = "playlists/$(playlist_id)/followers" # get url extension

    spotify_request(spotifyDetails, urlextension; method="DELETE") # make request

end # function unfollow_playlist

"""
Get current user's followed artists: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-followed
Requires scope: user-follow-read

"""
function get_followed_artists(spotifyDetails::SpotifyDetails)
    urlextension = "me/following?type=artist" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_follow_artists