"""
Get information on specified track: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track

"""
function get_track(spotifyDetails::SpotifyDetails, track_id::String; market::String="US")
    urlextension = "tracks/$(track_id)?market=$(market)" # get url extension 
    
    spotify_request(spotifyDetails, urlextension) # make request

end # function get_track

"""
Get information on several tracks:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-several-tracks

"""
function get_multiple_tracks(spotifyDetails::SpotifyDetails, track_ids::Vector{String}; market::String="US")
    track_idsString = join(track_ids, ",") # join vector into string

    track_ids_uri = HTTP.escapeuri(track_idsString) # perform url encoding

    urlextension = "tracks?ids=$(track_ids_uri)&market=$(market)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request 

end # function get_multiple_tracks

""" 
Get tracks saved in user's library: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-saved-tracks
Requires scope: user-library-read

"""
function get_user_tracks(spotifyDetails::SpotifyDetails; limit::Int=50, offset::Int=0, market::String="US")
    urlextension = "me/tracks?limit=$(limit)&offset=$(offset)&market=$(market)" # get url extension 

    spotify_request(spotifyDetails, urlextension) # make request
    
end # function get_user_tracks

"""
Gets audio features for multiple tracks: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-several-audio-features

"""
function audio_features(spotifyDetails::SpotifyDetails, track_ids::Vector{String})
    track_idsString = join(track_ids, ",") # join vector into string

    track_ids_uri = HTTP.escapeuri(track_idsString) # perform url encoding

    urlextension = "audio-features?ids=$(track_ids_uri)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request
    
end # function audio_features

"""
Gets audio features for a single track:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-audio-features

"""
function audio_features(spotifyDetails::SpotifyDetails, track_id::String)
    urlextension = "audio-features/$(track_id)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request
    
end # function audio_features

"""
Gets audio analysis of a single track: 
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-audio-analysis

"""
function audio_analysis(spotifyDetails::SpotifyDetails, track_id::String)
    urlextension = "audio-analysis/$(track_id)" # get url extension

    spotify_request(spotifyDetails, urlextension) # make request
    
end # function audio_analysis

"""
Gets recommendations based on seed tracks, genres, and artists:
https://developer.spotify.com/documentation/web-api/reference/#/operations/get-recommendations

"""
function get_recommendations(spotifyDetails::SpotifyDetails, seed_artists::Vector{String}, seed_genres::Vector{String}, seed_tracks::Vector{String}; kwargs... )
    seed_artistsString = join(seed_artists, ",") # join vector into string

    seed_artists_uri = HTTP.escapeuri(seed_artistsString) # perform url encoding

    seed_genresString = join(seed_genres, ",") # join vector into string

    seed_genres_uri = HTTP.escapeuri(seed_genresString) # perform url encoding

    seed_tracksString = join(seed_tracks, ",") # join vector into string

    seed_tracks_uri = HTTP.escapeuri(seed_tracksString) # perform url encoding

    urlextension = "recommendations?seed_artists=$(seed_artists_uri)&seed_genres=$(seed_genres_uri)&seed_tracks=$(seed_tracks_uri)" # get url extension

    # vector of valid kwargs
    validKwargs = [:limit, :market, :max_acousticness, :max_danceability, :max_duration_ms, :max_energy, :max_instrumentalness, :max_key, :max_liveness, :max_loudness, :max_mode, :max_popularity, :max_speechiness, :max_tempo, :max_time_signature, :max_valence, 
                    :min_acousticness, :min_danceability, :min_duration_ms, :min_energy, :min_instrumentalness, :min_key, :min_liveness, :min_loudness, :min_mode, :min_popularity, :min_speechiness, :min_tempo, :min_time_signature, :min_valence, 
                    :target_acousticness, :target_danceability, :target_duration_ms, :target_energy, :target_instrumentalness, :target_key, :target_liveness, :target_loudness, :target_mode, :target_popularity, :target_speechiness, :target_tempo, :target_time_signature, :target_valence]

    # loop through all kwargs and add to url extension
    for arg in kwargs 
        if arg[1] ∈ validKwargs 
            urlextension *= "&$(String(arg[1]))=$(arg[2])" # add kwarg to url extension
        end # if
    end # for

    spotify_request(spotifyDetails, urlextension) # make request

end # function get_recommendations