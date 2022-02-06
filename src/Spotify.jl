
module Spotify

import DefaultApplication
using HTTP, Random, Base64, SHA, URIs, Sockets

include("authorization.jl") 

export authorization_code, generate_verifier

end # Spotify