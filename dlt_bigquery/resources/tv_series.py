import time

import dlt
from dlt.sources.helpers import requests
from utils.functions import _create_auth_headers, fetch_data

REQUESTS_PER_SECOND = 40


# From 'discover tv series' endpoint
@dlt.resource(name="tv_series", write_disposition="replace")
def themoviedb_tv_series_resource(api_secret_key: str = dlt.secrets.value):
    url = "https://api.themoviedb.org/3/discover/tv"
    params = {
        "include_adult": "false",
        "include_null_first_air_dates": "false",
        "language": "en-US",
        "sort_by": "popularity.desc",
    }
    yield from fetch_data(api_secret_key, url, params)


# From 'tv series details' endpoint
@dlt.resource(name="tv_series_details", write_disposition="replace")
def themoviedb_tv_series_details_resource(api_secret_key: str = dlt.secrets.value):
    headers = _create_auth_headers(api_secret_key)
    tv_series_shows = list(themoviedb_tv_series_resource(api_secret_key))
    for tv in tv_series_shows:
        series_id = tv["id"]
        url = f"https://api.themoviedb.org/3/tv/{series_id}"
        params = {
            "append_to_response": "recommendations,reviews,similar,videos,images",
            "language": "en-US",
        }
        response = requests.get(url, headers=headers, params=params)
        response.raise_for_status()
        data = response.json()
        yield data
        time.sleep(1 / REQUESTS_PER_SECOND)
