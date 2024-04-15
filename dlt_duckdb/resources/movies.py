import time

import dlt
from dlt.sources.helpers import requests
from utils.functions import _create_auth_headers, fetch_data

REQUESTS_PER_SECOND = 40


# From 'discover movies' endpoint
@dlt.resource(name="movies", write_disposition="replace")
def themoviedb_movies_resource(api_secret_key: str = dlt.secrets.value):
    url = "https://api.themoviedb.org/3/discover/movie"
    params = {
        "include_adult": "false",
        "include_video": "false",
        "language": "en-US",
        "sort_by": "popularity.desc",
    }
    yield from fetch_data(api_secret_key, url, params)


# From 'movie details' endpoint
@dlt.resource(name="movie_details", write_disposition="replace")
def themoviedb_movie_details_resource(api_secret_key: str = dlt.secrets.value):
    headers = _create_auth_headers(api_secret_key)
    movies = list(themoviedb_movies_resource(api_secret_key))
    for movie in movies:
        movie_id = movie["id"]
        url = f"https://api.themoviedb.org/3/movie/{movie_id}"
        params = {
            "append_to_response": "recommendations,reviews,similar,videos,images",
            "language": "en-US",
        }
        response = requests.get(url, headers=headers, params=params)
        response.raise_for_status()
        data = response.json()
        yield data
        time.sleep(1 / REQUESTS_PER_SECOND)
