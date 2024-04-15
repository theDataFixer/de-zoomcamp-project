import pytest
import requests
import requests_mock

from ..utils.general import MAX_RESULTS, fetch_data


@pytest.fixture
def api_response_single():
    return {
        "page": 1,
        "results": [{"id": 1, "name": "Example"}],
        "total_pages": 1,
        "total_results": 1,
    }


@pytest.fixture
def api_response_multiple():
    # Simulates responses for two pages
    return [
        {
            "page": 1,
            "results": [{"id": i, "name": f"Example {i}"} for i in range(1, 11)],
            "total_pages": 2,
            "total_results": 20,
        },
        {
            "page": 2,
            "results": [{"id": i, "name": f"Example {i}"} for i in range(11, 21)],
            "total_pages": 2,
            "total_results": 20,
        },
    ]


def test_fetch_data_single_result(api_response_single, api_secret_key="fake_key"):
    url = "https://api.themoviedb.org/3/fake_endpoint"
    params = {"language": "en-US"}

    with requests_mock.Mocker() as m:
        m.get(url, json=api_response_single)
        results = fetch_data(api_secret_key, url, params)

        assert len(results) == 1, "Should fetch exactly one result"
        assert results[0]["id"] == 1, "The ID should match the mocked response"


def test_fetch_data_paginated(api_response_multiple, api_secret_key="fake_key"):
    url = "https://api.themoviedb.org/3/fake_endpoint"
    params = {"language": "en-US"}

    with requests_mock.Mocker() as m:
        for response in api_response_multiple:
            # Complete query string is important here to match URL exactly
            m.get(
                f"{url}?page={response['page']}&language={params['language']}",
                json=response,
            )
        results = fetch_data(api_secret_key, url, params)

        assert (
            len(results) == MAX_RESULTS
        ), f"Should fetch exactly {MAX_RESULTS} results"
        assert results[0]["id"] == 1, "First item's ID should be 1"
        assert (
            results[-1]["id"] == MAX_RESULTS
        ), f"Last item's ID should be {MAX_RESULTS}"


def test_fetch_data_with_invalid_key(api_secret_key="invalid_key"):
    url = "https://api.themoviedb.org/3/fake_endpoint"
    params = {"language": "en-US"}

    with requests_mock.Mocker() as m:
        m.get(url, status_code=401)
        with pytest.raises(requests.exceptions.HTTPError):
            fetch_data(api_secret_key, url, params)
