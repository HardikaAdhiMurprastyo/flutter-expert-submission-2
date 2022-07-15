import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/domain/entities/tv_series/tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>()
          .add(TvDetailShow(widget.id));
      context.read<TvWatchlistBloc>()
          .add(TvWatchlist(widget.id));
      context.read<TvRecommendationBloc>()
          .add(RecommendationTvsShow(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusTvWatchlist =
    context.select<TvWatchlistBloc, bool>((value) {
      if (value.state is AddWatchlist) {
        return (value.state as AddWatchlist).status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.result;
            return SafeArea(
              child: DetailContent(tv, statusTvWatchlist),
            );
          } else if (state is TvDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
                child: Text("Empty"));
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvDetail tvs;
  late bool isTvsAddedWatchlist;

  DetailContent(this.tvs, this.isTvsAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${widget.tvs.posterPath}',
          width: screenWidth,
          placeholder: (context, url) =>
              Center(
                child: CircularProgressIndicator(),
              ),
          errorWidget: (context, url, error) =>
              Image.asset('assets/no-foto.jpg'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvs.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isTvsAddedWatchlist) {
                                  context.read<TvWatchlistBloc>().add(
                                      AddTvWatchlist(widget.tvs));
                                } else {
                                  context.read<TvWatchlistBloc>().add(
                                      DeleteTvWatchlist(widget.tvs));
                                }

                                final state =
                                    BlocProvider.of<TvWatchlistBloc>(context).state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String removeMessage = "Removed from Watchlist";

                                if (state is AddWatchlist) {
                                  final isAdded = state.status;
                                  if (isAdded == false) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                } else {
                                  if (!widget.isTvsAddedWatchlist) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                }

                                if (message == insertMessage ||
                                    message == removeMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                      action: SnackBarAction(
                                        label: 'See Watchlist',
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              WatchlistTvsPage.ROUTE_NAME);
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }

                                setState(() {
                                  widget.isTvsAddedWatchlist =
                                  !widget.isTvsAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isTvsAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tvs.genres),
                            ),
                            Text(
                              _showDuration(widget.tvs.numberOfSeasons),
                            ),
                            Text(
                              _formattedDuration(widget.tvs.episodeRunTime),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvs.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvs.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Total Episodes: ' +
                                  widget.tvs.numberOfEpisodes.toString(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Season: ' + widget.tvs.numberOfSeasons.toString(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            if (widget.tvs.seasons.isEmpty)
                              Container(
                                child: Text(
                                  'There is no Season',
                                ),
                              )
                            else
                              Column(
                                children: <Widget>[
                                  widget.tvs.seasons.isNotEmpty
                                      ? Container(
                                    height: 150,
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        final season =
                                        widget.tvs.seasons[index];
                                        return Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: season.posterPath ==
                                                null
                                                ? Container(
                                              width: 96.0,
                                              decoration:
                                              BoxDecoration(
                                                color: kGrey,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.hide_image,
                                                ),
                                              ),
                                            )
                                                : CachedNetworkImage(
                                              imageUrl:
                                              '$BASE_IMAGE_URL${season
                                                  .posterPath}',
                                              placeholder:
                                                  (context, url) =>
                                                  Center(
                                                    child:
                                                    CircularProgressIndicator(),
                                                  ),
                                              errorWidget: (context,
                                                  url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.tvs.seasons.length,
                                    ),
                                  )
                                      : Text('-'),
                                ],
                              ),
                            SizedBox(height: 20),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvs.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationBloc,
                                TvRecommendationState>(
                              builder: (context, state) {
                                if (state is TvRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                is TvRecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                is TvRecommendationHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                '$BASE_IMAGE_URL${tvSeries.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else {
                                  return Text('no recommendations');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _formattedDuration(List<int> runtimes) =>
      runtimes.map((runtime) => _showDuration(runtime)).join(", ");
}
