include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email "

spotifyDetails = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

# println(get_playlist(spotifyDetails, "76KdKOh23Ofs73GtWZRlNQ"))

# println(get_playlist_items(spotifyDetails, "76KdKOh23Ofs73GtWZRlNQ", limit=3))