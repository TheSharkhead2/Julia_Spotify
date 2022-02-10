include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email"

const code_verifier_challenge = generate_verifier() # generate code verifier and challenge

spDetails = SpotifyDetails(ENV["CLIENT_ID"], redirect_uri, scope, nothing, nothing, nothing, code_verifier_challenge)

response = authorization_code(spDetails; show_dialog=true)

if haskey(response, "code") # check to see if got code not error 
    println(get_access_token(response["code"], spDetails))

else
    println("error")
end # if
