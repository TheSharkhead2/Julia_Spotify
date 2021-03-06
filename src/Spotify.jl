
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

include("tracks.jl")

export get_track, get_multiple_tracks, get_user_tracks, audio_features, audio_analysis, get_recommendations

include("users.jl")

export get_current_user_profile, get_user_top_tracks, get_user_top_artists, get_user_profile, follow_playlist, unfollow_playlist, get_followed_artists, follow_artists, follow_users, unfollow_artists, unfollow_users, check_artist_follow, check_user_follow, check_playlist_follow

include("playlist.jl")

export get_playlist, get_playlist_items, add_items_to_playlist, get_current_user_playlists, get_user_playlists, get_featured_playlists, get_category_playlists, get_playlist_cover

end # Spotify