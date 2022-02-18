"""
Function for making general Spotify request.

"""
function spotify_request(spotifyDetails::SpotifyDetails, urlextension::String; method::String="GET", scope::String="client-credentials")
    valid_access_token!(spotifyDetails) # make sure access token is valid 

    url = "https://api.spotify.com/v1/$urlextension" # create url for request

    headers = generate_headers(spotifyDetails) # generate headers for request

    response = HTTP.request(method, url, headers) # make request to API

    if length(response.body) > 0 # if response not empty
        responseParsed = JSON.parse(String(response.body)) # parse response
    else 
        return nothing
    end # if

end # function spotify_request