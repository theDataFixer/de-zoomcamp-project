import dlt
from resources import genres, movies, trending, tv_series


@dlt.source
def themoviedb_source(api_secret_key: str = dlt.secrets.value):
    yield movies.themoviedb_movies_resource(api_secret_key)
    yield tv_series.themoviedb_tv_series_resource(api_secret_key)
    yield genres.themoviedb_genres_movie_resource(api_secret_key)
    yield genres.themoviedb_genres_tv_series_resource(api_secret_key)
    yield trending.themoviedb_trending_movies_resource(api_secret_key)
    yield trending.themoviedb_trending_tv_series_resource(api_secret_key)
    yield dlt.resource(
        movies.themoviedb_movie_details_resource(api_secret_key), name="movie_details"
    )
    yield dlt.resource(
        tv_series.themoviedb_tv_series_details_resource(api_secret_key),
        name="tv_series_details",
    )


if __name__ == "__main__":
    """
    Initializes and runs the data pipeline using the `dlt` library, fetchin and processing data
    from The Movie Database API. The pipeline is configured to load data into a `duckdb` database
    """
    pipeline = dlt.pipeline(
        pipeline_name="themoviedb_pipeline",
        destination="bigquery",  # Change destination accordingly
        dataset_name="movie_data",
        progress="alive_progress",
    )
    load_info = pipeline.run(themoviedb_source())
    print(load_info)
