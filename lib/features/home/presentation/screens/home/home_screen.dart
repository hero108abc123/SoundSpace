// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/user_artist.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/screens/home/seemore_artist_screen.dart';
import 'package:soundspace/features/home/presentation/screens/home/seemore_playlist_screen.dart';
import 'package:soundspace/features/home/presentation/screens/home/seemore_song_screen.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/favorite_artist.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/featured_album_widget.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/navbar.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/playlist.dart';
import 'package:soundspace/features/home/presentation/widget/home_widget/song_list.dart';

class HomeScreen extends StatefulWidget {
  final Profile user;
  // final Track track;
  // final AudioPlayerManager audioPlayerManager;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navbar(
        user: widget.user,
        // track: widget.track,
        // audioPlayerManager: widget.audioPlayerManager,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final List<Track> tracks = [];
  final List<Playlist> playlists = [];
  final List<Artist> artists = [];
  StreamController<List<Track>> trackStream = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeTrackLoadData());
    context.read<HomeBloc>().add(HomePlaylistsLoadData());
    context.read<HomeBloc>().add(HomeArtistsLoadData());
    observeData();
    Future.delayed(Duration.zero, () {
      trackStream.add(tracks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
            AppPallete.gradient4,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is TrackFailure) {
            showSnackBar(context, state.error);
          } else if (state is PlaylistsFailure) {
            showSnackBar(context, state.error);
          } else if (state is ArtistsFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Loader();
          }
          if (state is TrackSuccess) {
            tracks.clear();
            tracks.addAll(state.tracks!.where(
                (track) => !tracks.any((t) => t.trackId == track.trackId)));
            trackStream.add(tracks);
          }
          if (state is PlaylistsSuccess) {
            playlists.clear();
            playlists.addAll(state.playlists as Iterable<Playlist>);
          }
          if (state is ArtistsSuccess) {
            artists.clear();
            artists.addAll(state.artists as Iterable<Artist>);
          }

          return HomeContent(
            tracks: tracks,
            playlists: playlists,
            artists: artists,
            parent: this,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    trackStream.close();
    super.dispose();
  }

  void observeData() {
    trackStream.stream.listen((trackList) {
      setState(() {
        for (var track in trackList) {
          if (!tracks.any((t) => t.trackId == track.trackId)) {
            tracks.add(track);
          }
        }
      });
    });
  }

  void navigate(Track track) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return NowPlaying(
        tracks: tracks,
        playingTrack: track,
      );
    }));
  }
}

class HomeContent extends StatelessWidget {
  final List<Track> tracks;
  final List<Playlist> playlists;
  final List<Artist> artists;
  final _HomeTabPageState parent;

  const HomeContent(
      {super.key,
      required this.parent,
      required this.tracks,
      required this.playlists,
      required this.artists});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          FeaturedAlbumWidget(),
          _buildFavoriteArtistCards(context),
          _buildPlaylistSection(parent, context),
          _buildSong(parent, context)
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Text(
          'SoundScape',
          style: TextStyle(
            fontFamily: 'Orbitron',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteArtistCards(context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languageProvider.translate('favorite_artist'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SeemoreArtistScreen()),
                  );
                },
                child: Text(
                  languageProvider.translate('see_more'),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: artists.take(5).map((artist) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FavoriteArtist(
                    artist: artist,
                    onNavigate: (selectedArtist) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserArtist(
                            onNavigate: (artist) {},
                            artist: selectedArtist,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistSection(_HomeTabPageState parent, context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languageProvider.translate('playlists'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SeemorePlaylistScreen(
                              playlist: playlists,
                              onNavigate: (playlist) {},
                              tracks: tracks,
                            )),
                  );
                },
                child: Text(
                  languageProvider.translate('see_more'),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: playlists.map((playlist) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TrackItem(
                    playlist: playlist,
                    onNavigate: (Playlist playlist) {
                      parent.navigate(playlist as Track);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSong(_HomeTabPageState parent, context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languageProvider.translate('song'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeemoreSongScreen(
                        tracks: tracks,
                        onNavigate: (track) {},
                      ),
                    ),
                  );
                },
                child: Text(
                  languageProvider.translate('see_more'),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: tracks.take(5).map((track) {
              return Songlist(
                playlists: playlists,
                track: track,
                onNavigate: (Track selectedTrack) {
                  parent.navigate(track);
                },
                tracks: const [],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
