include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email playlist-modify-private"

spotifyDetails = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

# println(get_playlist(spotifyDetails, "76KdKOh23Ofs73GtWZRlNQ"))

# println(get_playlist_items(spotifyDetails, "76KdKOh23Ofs73GtWZRlNQ", limit=3))

# println(add_items_to_playlist(spotifyDetails, "7EWbd3NoGjjvnyS77ghUjl", ["spotify:track:6CX899yO5b5DZh2Gvtw5se"]))

# println(get_current_user_playlists(spotifyDetails))

# println(get_user_playlists(spotifyDetails, "kcm4s9xdvua5ft5glrsxii3ki"))

println(get_featured_playlists(spotifyDetails))