include("../src/Spotify.jl")

using .Spotify

using DotEnv

DotEnv.config()

code_verifier_challenge = generate_verifier() # generate code verifier and challenge

response = authorization_code(ENV["CLIENT_ID"], "http://localhost:8888/callback", "user-read-private user-read-email", code_verifier_challenge[2])

println(response)