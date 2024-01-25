data <- read_csv("../data/spotify_songs.csv", show_col_types = FALSE)

data <- data[c("track_id", "track_name", "track_artist", "track_popularity", "track_album_release_date", "playlist_genre", "duration_ms")]

data <- data %>%
  rename(
    TrackID = track_id,
    TrackName = track_name,
    Artist = track_artist,
    Popularity = track_popularity,
    ReleaseYear = track_album_release_date,
    Genre = playlist_genre,
    DurationMin = duration_ms
  )

data$DurationMin <- data$DurationMin / 60000
data$DurationMin <- round(data$DurationMin, 2)

data$Artist <- as.factor(data$Artist)
data$Genre <- as.factor(data$Genre)

extractYear <- function(date) {
  parsed_date <- ymd(date, quiet = TRUE)
  if (any(!is.na(parsed_date))) {
    return(year(parsed_date))
  } else {
    # Ako je datum u formatu samo godine (npr. "1999")
    if (str_detect(date, "^\\d{4}$")) {
      return(as.numeric(date))
    } else {
      return(NA) # Ako format nije prepoznat
    }
  }
}

data$ReleaseYear <- sapply(data$ReleaseYear, extractYear)
data <- data %>% filter(!is.na(ReleaseYear))

extractYear <- function(date) {
  parsed_date <- ymd(date, quiet = TRUE)
  if (any(!is.na(parsed_date))) {
    return(year(parsed_date))
  } else {
    # Ako je datum u formatu samo godine (npr. "1999")
    if (str_detect(date, "^\\d{4}$")) {
      return(as.numeric(date))
    } else {
      return(NA) # Ako format nije prepoznat
    }
  }
}

data$ReleaseYear <- sapply(data$ReleaseYear, extractYear)
data <- data %>% filter(!is.na(ReleaseYear))