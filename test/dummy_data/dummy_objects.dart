import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:ditonton/data/models/tv_series/tv_table.dart';
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/entities/tv_series/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final tQ = "Spider Man";
final tError = 'Server Failure';
final tId = 1;

// tv series data
final testTv = Tv(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Halo",
    overview:
    "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 7348.55,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.7,
    voteCount: 472
);
final testTvList = [testTv];

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name:'name',
);

final testTvMaping = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTvDetail = TvDetail(
  backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
  episodeRunTime: [42],
  genres: [Genre(id: 18, name: 'Drama')],
  homepage: "https://www.telemundo.com/shows/pasion-de-gavilanes",
  id: 1,
  name: "name",
  numberOfEpisodes: 259,
  numberOfSeasons: 2,
  originalName: "Pasión de gavilanes",
  overview: "overview",
  popularity: 1747.047,
  posterPath: "posterPath",
  seasons: [
    Season(
      episodeCount: 188,
      id: 72643,
      name: "Season 1",
      posterPath: "/elrDXqvMIX3EcExwCenQMVVmnvd.jpg",
      seasonNumber: 1,
    )
  ],
  status: "Returning Series",
  type: "Scripted",
  voteAverage: 7.6,
  voteCount: 1803,
);
final tTvList = <Tv>[];