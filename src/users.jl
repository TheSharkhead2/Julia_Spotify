"""
Get current user's profile:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-current-users-profile
Requires scope: user-read-private user-read-email

"""
function get_user_profile(spotifyDetails::SpotifyDetails)
    urlextension = "me" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_user_profile