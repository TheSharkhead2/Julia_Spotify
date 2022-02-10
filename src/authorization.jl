"""
Object for holding Spotify application details using in PKCE authentication 
implementation.

"""
mutable struct SpotifyDetails
    client_id::String
    redirect_uri::String
    scope::String
    access_token::Union{String, Nothing}
    refresh_code::Union{String, Nothing}
    expires_at::Union{Int, Nothing}
    code_verifierChallenge::Tuple{String, String}
end # SpotifyDetails

""" 
Authorization code flow with PKCE for Spotify API. Process outlined here: 
https://developer.spotify.com/documentation/general/guides/authorization/code-flow/

WARNING: Due to currently poor implementation of the function server_listen(),
this may hang indefinitely. I would rather not deal with the user just closing
the page right now.

# Parameters 

## spotifyDetails::SpotifyDetails
SpotifyDetails object with client_id, redirect_uri, scope, and code_challenge


# Returns 

## authCode::Union{Dict, Nothing}
Authorization code and state if successful, Nothing if not.

"""
function authorization_code(spotifyDetails::SpotifyDetails; show_dialog::Bool=false) 

    # convert bool for show_dialog to string
    if show_dialog
        show_dialog_string = "true"
    else 
        show_dialog_string = "false"
    end # if

    state = randstring(16) # random string for state

    # define authorization request
    parameters = Dict(
        "response_type" => "code",
        "client_id" => spotifyDetails.client_id,
        "redirect_uri" => spotifyDetails.redirect_uri,
        "scope" => spotifyDetails.scope,
        "show_dialog" => show_dialog_string,
        "state" => state,
        "code_challenge" => spotifyDetails.code_verifierChallenge[2],
        "code_challenge_method" => "S256",
    )

    ### start of bad code, not sure if there is a different way of doing this but this works ###

    uri = URI(URI("https://accounts.spotify.com/authorize?"); query=parameters) # define request URI

    response = HTTP.get(string(uri); redirect=true, status_exception=false) # send request

    if response.headers[3].first == "location" # superficial check for location 
        DefaultApplication.open(response.headers[3].second) # open in default application for user authorization

        authCodeRaw = server_listen() # wait for user to authorize

        return queryparams(URI(authCodeRaw.target)) # return auth code

    else 
        println("Couldn't find url") # error message MAKE BETTER LATER

        return nothing 

    end # if 

    ### end of comparatively bad code ###

end # function authorize

"""
Generate code verifier and code challenge for PKCE authorization. Process 
follows code found here: https://docs.cotter.app/sdk-reference/api-for-other-mobile-apps/api-for-mobile-apps#step-1-create-a-code-verifier

# Returns

## code_verifier::String 
url-safe base64 encoded code verifier 

## code_challenge::String 
sha256 hash of code verifier

"""
function generate_verifier()
    randomKey = rand(RandomDevice(), UInt8, 32) # generate cryptographically-random key 

    randomKeyB64 = base64encode(randomKey) # base64 encode random key, uses OS-randomness: https://www.reddit.com/r/Julia/comments/cdij9t/is_there_a_julia_equivalent_for_pythons_osurandom/

    code_verifier = replace(replace(randomKeyB64, "+"=>"-"), "/"=>"_")[1:43] # replace non-url-safe characters (+ and /) with url-safe equivalents (- and _), there seems to be no other solution in Julia currently: # generate cryptographically-random key 

    code_challengeHash = sha256(code_verifier) # sha256 hash of code verifier

    code_challenge = replace(replace(replace(base64encode(code_challengeHash), "+"=>"-"), "/"=>"_"), "="=> "") # replace non-url-safe characters and last equal sign

    (code_verifier, code_challenge)

end # function generate_verifier

"""
Set up HTTP.listen to grab spotify authorization code. Will listen until 
code is received. Will *probably* just hang if something goes wrong. Be 
careful. 

# Parameters

## port::Int, optional
Default: 8888. Port to listen on.

# Returns

## authorizationCode::HTTP.Messages.Request
Authorization code from Spotify, not fully parsed yet. Full result of
get.

"""
function server_listen(port::Int=8888)
    server = listen(port) # listen on sepcified local port

    authorizationCode = nothing # empty variable for authorization code

    @async HTTP.listen("127.0.0.1", port; server=server) do http
        @show http.message # show result of request
        if authorizationCode === nothing # only save authorization code if it isn't writing over something else
            authorizationCode = http.message # save authorization code
        end # if
        startwrite(http)
        write(http, "You can close this page now") # confirmation to user that they can close the page
        
    end # HTTP.listen

    while authorizationCode === nothing # wait for authorization code to be set
        sleep(0.1) # wait for authorization code to be set
    end # while

    close(server) # close server

    authorizationCode

end # function set_up_server_listen

"""
Function to get API access token from authorization code using the PKCE method

# Parameters

## authorizationCode::String
Authorization code returned from authorization user method (function: 
authorization_code())

## spotifyDetails::SpotifyDetails
SpotifyDetails object. Must have: client_id, redirect_uri, code_verifier

# Returns

## response::Dict{String, Any}
Dict with access_token, refresh_token, expires_at, and other 
unimportant/redundant information

"""
function get_access_token(authorization_code::String, spotifyDetails::SpotifyDetails)
    # define request parameters
    parameters = Dict(
        "grant_type" => "authorization_code",
        "code" => authorization_code,
        "redirect_uri" => spotifyDetails.redirect_uri,
        "client_id" => spotifyDetails.client_id,
        "code_verifier" => spotifyDetails.code_verifierChallenge[1],
    )

    # define request URI
    uri = URI(URI("https://accounts.spotify.com/api/token"); query=parameters)

    # define request headers
    headers = Dict(
        "Content-Type" => "application/x-www-form-urlencoded",
    )

    # send request
    response = HTTP.post(string(uri), headers)

    JSON.parse(String(response.body)) # return parsed response

end # function get_access_token