include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email "

spotifyDetails = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

# println(get_artist(spotifyDetails, "59sBwR0jPSTrbMtuTkRPN5"))
println(get_multiple_artists(spotifyDetails, ["59sBwR0jPSTrbMtuTkRPN5", "6eUKZXaKkcviH0Ku9w2n3V"]))