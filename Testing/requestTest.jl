include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email"

spotifyDetails = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

println(spotify_request(spotifyDetails, "tracks/2TpxZ7JUBn3uw46aR7qd6V"))