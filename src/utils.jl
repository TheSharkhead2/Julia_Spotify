"""
Function to check to see if access token is expired. Calls refresh function 
if expired. 

# Parameters

* spotifyDetails::SpotifyDetails
    * SpotifyDetails object with access token and refresh token

"""
function valid_access_token!(spotifyDetails::SpotifyDetails)
    if spotifyDetails.expires_at <= time() # check to see if expiry time has passed
        refresh_access_token!(spotifyDetails) # if it has, refresh the access token
    end # if 
end # function valid_access_token

"""
Function to generate headers for a request. TODO: add check for valid scope

# Parameters

* spotifyDetails::SpotifyDetails
    * SpotifyDetails object which has been authenticated

"""
function generate_headers(spotifyDetails::SpotifyDetails)
    headers = Dict(
        "Authorization" => "Bearer $(spotifyDetails.access_token)",
    )

    return headers
end # function generate_headers