import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_event_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_series/populer_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series/watchlist_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<WatchlistEventBloc>(
          create: (_) => di.locator<WatchlistEventBloc>(),
        ),
        BlocProvider<WatchlistStatusBloc>(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),
        BlocProvider<MoviesDetailBloc>(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider<MovieNowPlayingBloc>(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider<MovieRecomendationBloc>(
          create: (_) => di.locator<MovieRecomendationBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider<WatchlistEventBloc>(
          create: (_) => di.locator<WatchlistEventBloc>(),
        ),
        BlocProvider<WatchlistStatusBloc>(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),

        BlocProvider(
          create: (_) => di.locator<NowPlayingTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvsPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
