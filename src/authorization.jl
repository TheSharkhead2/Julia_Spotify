""" 
Authorization code flow with PKCE for Spotify API. Process outlined here: 
https://developer.spotify.com/documentation/general/guides/authorization/code-flow/

# Parameters 

    client_id::String
        Client ID for the Spotify API application 

    redirect_uri::String
        Redirect URI for application 

    scope::String
        API scope for the application

    code_challenge::String
        Code challenge for PKCE. Generate using generate_verifier()

    show_dialog::Bool, optional
        Whether or not to show the authorization dialog even if already 
        authorized. Default is False.

# Returns 

    response::Dict
        Response from the Spotify API

"""
function authorization_code(client_id::String, redirect_uri::String, scope::String, code_challenge::String; show_dialog::Bool=false) 

    # convert bool for show_dialog to string
    if show_dialog
        show_dialog_string = "true"
    else 
        show_dialog_string = "false"
    end

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

    uri = URI(URI("https://accounts.spotify.com/authorize?"); query=parameters) # define request URI

    # HTTP.get(string(uri); redirect=true, status_exception=false) # send request

    # Try opening a browser window based on OS type
    if Sys.isapple()
        run(`open $uri`)
    end
    if Sys.iswindows()
        run(`explorer $uri`)
    end
    if Sys.islinux()
        run(`xdg-open $uri`)
    end

end # function authorize

"""
Generate code verifier and code challenge for PKCE authorization. Process 
follows code found here: https://docs.cotter.app/sdk-reference/api-for-other-mobile-apps/api-for-mobile-apps#step-1-create-a-code-verifier

# Returns

    code_verifier::String 
        url-safe base64 encoded code verifier 

    code_challenge::String 
        sha256 hash of code verifier

"""
function generate_verifier()
    randomKey = rand(RandomDevice(), UInt8, 32) # generate cryptographically-random key 

    randomKeyB64 = base64encode(randomKey) # base64 encode random key, uses OS-randomness: https://www.reddit.com/r/Julia/comments/cdij9t/is_there_a_julia_equivalent_for_pythons_osurandom/

    code_verifier = replace(replace(randomKeyB64, "+"=>"-"), "/"=>"_") # replace non-url-safe characters (+ and /) with url-safe equivalents (- and _), there seems to be no other solution in Julia currently: # generate cryptographically-random key 

    code_challenge = bytes2hex(sha256(code_verifier)) # sha256 hash of code verifier

    (code_verifier, code_challenge)

end # function generate_verifier