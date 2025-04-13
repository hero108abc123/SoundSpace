// UserArtist.dart
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
import 'package:soundspace/features/home/presentation/bloc/discovery/discovery_bloc.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/screens/home/playing_screen.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/playlist_item.dart';
import 'add_to_playlist.dart';

class UserArtist extends StatefulWidget {
  final Artist artist;
  final Function(Artist) onNavigate;

  const UserArtist({
    super.key,
    required this.artist,
    required this.onNavigate,
  });

  @override
  _UserArtistState createState() => _UserArtistState();
}

class _UserArtistState extends State<UserArtist>
    with SingleTickerProviderStateMixin {
  final List<Track> tracks = [];
  final List<Playlist> playlists = [];
  StreamController<List<Track>> trackStream = StreamController.broadcast();

  bool isFollowing = false;
  late TabController _tabController;

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  void initState() {
    super.initState();
    context
        .read<DiscoveryBloc>()
        .add(GetPlaylistsByUserIdRequested(userId: widget.artist.id));
    context
        .read<DiscoveryBloc>()
        .add(GetTracksByUserIdRequested(userId: widget.artist.id));

    observeData();
    Future.delayed(Duration.zero, () {
      if (!trackStream.isClosed) {
        trackStream.add(tracks);
      }
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
        child: AppBar(
          flexibleSpace: _buildHeader(context),
        ),
      ),
      body: BlocConsumer<DiscoveryBloc, DiscoveryState>(
        listener: (context, state) {
          if (state is DiscoveryPlaylistFailure) {
            showSnackBar(context, state.message);
          } else if (state is DiscoveryTrackFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is DiscoveryLoading) {
            return const Loader();
          }
          if (state is DiscoveryPlaylistSuccess) {
            playlists.clear();
            playlists.addAll(state.playlists ?? []);
          }
          if (state is DiscoveryTrackSuccess) {
            tracks.clear();
            tracks.addAll(state.tracks!.where(
                (track) => !tracks.any((t) => t.trackId == track.trackId)));
            trackStream.add(tracks);
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppPallete.gradient2, AppPallete.gradient4],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: languageProvider.translate('profile')),
                    Tab(text: languageProvider.translate('song')),
                  ],
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  unselectedLabelColor:
                      const Color.fromARGB(255, 138, 138, 138),
                  labelColor: Colors.white,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildProfileArtist(context),
                      _buildSongArtist(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.artist.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            widget.artist.displayName,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: _toggleFollow,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              isFollowing
                  ? '${languageProvider.translate('following')}'
                  : '${languageProvider.translate('follow')}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 44, 44, 44),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfileArtist(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${languageProvider.translate('display_name')}: ${widget.artist.displayName}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${widget.artist.followersCount} ${languageProvider.translate('follower')} • ${widget.artist.followingCount} ${languageProvider.translate('following')}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languageProvider.translate('play_cre'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                languageProvider.translate('see_more'),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: playlists
                .map((playlist) => Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: PlaylistItem(playlist: playlist),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSongArtist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: tracks
            .map((track) => Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: _buildSongItem(track),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSongItem(Track track) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Image.network(
              track.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset('assets/images/icon/home/icon_play.png',
                width: 26, height: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('assets/images/icon/home/icon_add.png',
                width: 26, height: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToPlaylist(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
