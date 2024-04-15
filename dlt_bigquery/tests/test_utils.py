import pytest
import requests
import requests_mock

from ..utils.functions import fetch_data


@pytest.fixture
def api_response():
    return {
        "page": 1,
        "results": [{"id": 1, "name": "Example"}],
        "total_pages": 1,
        "total_results": 1,
    }


def test_fetch_data(api_secret_key="fake_key"):
    url = "https://api.themoviedb.org/3/fake_endpoint"
    params = {"language": "en-US"}

    with requests_mock.Mocker() as m:
        m.get(url, json=api_response())
        results = fetch_data(api_secret_key, url, params)

        assert len(results) == 1, "Should fetch exactly one result"
        assert results[0]["id"] == 1, "The ID should match the mocked response"


def test_fetch_data_with_invalid_key(api_secret_key="invalid_key"):
    url = "https://api.themoviedb.org/3/fake_endpoint"
    params = {"language": "en-US"}

    with requests_mock.Mocker() as m:
        m.get(url, status_code=401)  # Unauthorized
        with pytest.raises(requests.exceptions.HTTPError):
            fetch_data(api_secret_key, url, params)
