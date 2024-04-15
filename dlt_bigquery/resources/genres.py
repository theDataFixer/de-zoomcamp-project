import dlt
from utils.functions import fetch_data


# From 'genres movies' endpoint
@dlt.resource(name="genres_movie", write_disposition="replace")
def themoviedb_genres_movie_resource(api_secret_key: str = dlt.secrets.value):
    url = "https://api.themoviedb.org/3/genre/movie/list"
    params = {
        "language": "en-US",
    }
    yield from fetch_data(api_secret_key, url, params, results_key="genres")


# From 'genres tv series' endpoint
@dlt.resource(name="genres_tv_series", write_disposition="replace")
def themoviedb_genres_tv_series_resource(api_secret_key: str = dlt.secrets.value):
    url = "https://api.themoviedb.org/3/genre/tv/list"
    params = {
        "language": "en-US",
    }
    yield from fetch_data(api_secret_key, url, params, results_key="genres")
