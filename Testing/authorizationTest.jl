include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email"

response = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

println(response)

refresh_access_token!(response)

println(response)