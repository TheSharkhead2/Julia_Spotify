include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email user-top-read playlist-modify-public user-follow-read user-follow-modify"

spotifyDetails = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

# println(get_current_user_profile(spotifyDetails))
# println(get_user_top_artists(spotifyDetails; limit=1))
# println(get_user_top_tracks(spotifyDetails; limit=1))
# println(get_user_profile(spotifyDetails, "kcm4s9xdvua5ft5glrsxii3ki"))
# println(follow_playlist(spotifyDetails, "76KdKOh23Ofs73GtWZRlNQ"))
# unfollow_playlist(spotifyDetails, "76KdKOh23Ofs73GtWZRlNQ")
# println(get_followed_artists(spotifyDetails))

# unfollow_artists(spotifyDetails, ["19c38YwdAreCJKVmQMPaWH"])
# println(get_followed_artists(spotifyDetails))
# follow_artists(spotifyDetails, ["19c38YwdAreCJKVmQMPaWH"])
# println(get_followed_artists(spotifyDetails))

# follow_users(spotifyDetails, ["kcm4s9xdvua5ft5glrsxii3ki"])

println(check_artist_follow(spotifyDetails, ["19c38YwdAreCJKVmQMPaWH", "6eUKZXaKkcviH0Ku9w2n3V"]))
println(check_user_follow(spotifyDetails, ["kcm4s9xdvua5ft5glrsxii3ki", "v1nr5wbcx7kct1md9i5vkipv2"]))