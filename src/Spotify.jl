
module Spotify

import DefaultApplication
import JSON
using HTTP, Random, Base64, SHA, URIs, Sockets

include("authorization.jl") 

export SpotifyDetails

export authorization_code, generate_verifier, get_access_token

end # Spotify