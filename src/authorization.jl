""" 
Authorization code flow with PKCE for Spotify API. Process outlined here: 
https://developer.spotify.com/documentation/general/guides/authorization/code-flow/

WARNING: Due to currently poor implementation of the function server_listen(),
this may hang indefinitely. I would rather not deal with the user just closing
the page right now.

# Parameters 

## client_id::String
Client ID for the Spotify API application 


## redirect_uri::String
Redirect URI for application 


## scope::String
API scope for the application


## code_challenge::String
Code challenge for PKCE. Generate using generate_verifier()


## show_dialog::Bool, optional
Whether or not to show the authorization dialog even if already 
authorized. Default is False.


# Returns 

## authCode::Union{Dict, Nothing}
Authorization code and state if successful, Nothing if not.

"""
function authorization_code(client_id::String, redirect_uri::String, scope::String, code_challenge::String; show_dialog::Bool=false) 

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
        "client_id" => client_id,
        "redirect_uri" => redirect_uri,
        "scope" => scope,
        "show_dialog" => show_dialog_string,
        "state" => state,
        "code_challenge" => code_challenge,
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

    code_verifier = replace(replace(randomKeyB64, "+"=>"-"), "/"=>"_") # replace non-url-safe characters (+ and /) with url-safe equivalents (- and _), there seems to be no other solution in Julia currently: # generate cryptographically-random key 

    code_challenge = bytes2hex(sha256(code_verifier)) # sha256 hash of code verifier

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
        authorizationCode = http.message # save authorization code
        startwrite(http)
        write(http, "You can close this page now") # confirmation to user that they can close the page
        
    end # HTTP.listen

    while authorizationCode === nothing # wait for authorization code to be set
        sleep(0.1) # wait for authorization code to be set
    end # while

    close(server) # close server

    authorizationCode

end # function set_up_server_listen