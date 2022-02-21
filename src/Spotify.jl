
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

export get_album, get_multiple_albums, get_album_tracks, get_saved_albums, save_albums, delete_albums, check_saved_albums, get_new_releases

include("artists.jl")

export get_artist, get_multiple_artists, get_artist_albums, get_artist_top_tracks, get_artist_related_artists

end # Spotify