
module Spotify

import DefaultApplication
import JSON
using HTTP, Random, Base64, SHA, URIs, Sockets

include("authorization.jl") 
include("request.jl")
include("utils.jl")

export SpotifyDetails

export pkce_authorization, refresh_access_token!

export spotify_request

include("albums.jl")

export get_album, get_multiple_albums

end # Spotify