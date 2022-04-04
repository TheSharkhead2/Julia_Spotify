include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

const redirect_uri = "http://localhost:8888/callback"
const scope = "user-read-private user-read-email"

spotifyDetails = pkce_authorization(ENV["CLIENT_ID"], redirect_uri, scope)

# println(get_track(spotifyDetails, "0v8iaQnFPT8qkicB880pAr"))
# println(get_multiple_tracks(spotifyDetails, ["0v8iaQnFPT8qkicB880pAr", "5gzS0JyrF7IHZzMH4rNpoK"]))
# println(get_user_tracks(spotifyDetails))
# println(audio_features(spotifyDetails, ["0v8iaQnFPT8qkicB880pAr"])) # multiple tracks 
# println(audio_features(spotifyDetails, "0v8iaQnFPT8qkicB880pAr")) # single track
# println(audio_analysis(spotifyDetails, "0v8iaQnFPT8qkicB880pAr")) 

println(get_recommendations(spotifyDetails, ["6eUKZXaKkcviH0Ku9w2n3V"], ["pop"], ["0v8iaQnFPT8qkicB880pAr"]))