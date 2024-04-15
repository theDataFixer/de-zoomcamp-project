import time

from dlt.sources.helpers import requests

MAX_RESULTS = 20
REQUESTS_PER_SECOND = 40


def _create_auth_headers(api_secret_key):
    """
    Creates the authorization headers required for making API requests to TMDB.

    Parameters:
    - api_secret_key (str): The API secret key used for authentication.

    Returns:
    - dict: A dictionary containing the 'accept' and 'Authorization' headers.
    """
    headers = {
        "accept": "application/json",
        "Authorization": f"Bearer {api_secret_key}",
    }
    return headers


def fetch_data(api_secret_key, url, params, results_key="results"):
    """
    Fetches data from the given TMDB API URL with pagination support.

    This function makes API requests to a specified URL, handling pagination to accumulate
    results up to a predefined maximum. It incorporates delay between requests to comply with
    the API's rate limit policy.

    Parameters:
    - api_secret_key (str): The API secret key for authentication.
    - url (str): The TMDB API endpoint URL to fetch data from.
    - params (dict): Parameters to include in the API request.

    Returns:
    - list: A list of results from the API, up to the specified MAX_RESULTS.
    """
    headers = _create_auth_headers(api_secret_key)
    results = []
    page = 1
    while len(results) < MAX_RESULTS:
        params["page"] = page
        response = requests.get(url, headers=headers, params=params)
        response.raise_for_status()
        data = response.json()
        results.extend(data[results_key])
        page += 1
        time.sleep(1 / REQUESTS_PER_SECOND)
    return results[:MAX_RESULTS]
