include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email user-library-read user-library-modify"

spotifyDetails = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

# println(get_album(spotifyDetails, "4R09OvFyz47HfjecIjoEtP"))

# println(get_multiple_albums(spotifyDetails, ["4R09OvFyz47HfjecIjoEtP", "4SMbqvJenspMXbcPROZsVK"]))

# println(get_album_tracks(spotifyDetails, "4R09OvFyz47HfjecIjoEtP"))

# println(get_saved_albums(spotifyDetails))

returned = save_albums(spotifyDetails, ["5OVxLrOoXXD2HSKkQNqhQW"])

delete_albums(spotifyDetails, ["5OVxLrOoXXD2HSKkQNqhQW"])
