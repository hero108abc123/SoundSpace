import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/home/presentation/screens/home/lyric_screen.dart';
import '../../../domain/entitites/track.dart';
import '../../widget/home_widget/audio_player_manager.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({
    super.key,
    required this.playingTrack,
    required this.tracks,
  });

  final Track playingTrack;
  final List<Track> tracks;

  @override
  Widget build(BuildContext context) {
    return NowPlayingPage(
      playingTrack: playingTrack,
      tracks: tracks,
    );
  }
}

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({
    super.key,
    required this.playingTrack,
    required this.tracks,
  });

  final Track playingTrack;
  final List<Track> tracks;

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimationController;
  late AudioPlayerManager _audioPlayerManager;
  late int _selectedItemIndex;
  late Track _track;
  late double _currentAnimationPosition;
  late Set<int>
      _favoriteTrackIds; // t víeeets cái favoriteTrackId đây nhé, sai thì sửa
  bool _isRepeating = false;
  bool _isShuffling = false;

  @override
  void initState() {
    super.initState();
    _currentAnimationPosition = 0.0;
    _track = widget.playingTrack;
    _imageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12000),
    );
    _audioPlayerManager = AudioPlayerManager(trackUrl: _track.source);
    _audioPlayerManager.init();
    _selectedItemIndex = widget.tracks.indexOf(widget.playingTrack);
    _favoriteTrackIds = {}; //đây nhé
    _isRepeating = _audioPlayerManager.player.loopMode == LoopMode.one;
    _isShuffling = _audioPlayerManager.player.shuffleModeEnabled;
    _audioPlayerManager.player.positionStream.listen((position) async {
      final duration = _audioPlayerManager.player.duration;

      if (duration != null && position >= duration) {
        if (_isRepeating) {
          _audioPlayerManager.player.seek(Duration.zero);
          _audioPlayerManager.player.play();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon/playlist/icon Back.png',
                      height: 26,
                      width: 26,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(_imageAnimationController),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/Goat.jpg',
                            image: _track.image,
                            width: 260,
                            height: 260,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/Goat.jpg',
                                width: 260,
                                height: 260,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      _buildTrackInfo(),
                      const SizedBox(height: 30),
                      _progressBar(),
                      const SizedBox(height: 30),
                      _mediaButton(),
                      const SizedBox(height: 30),
                      _lyricButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayerManager.dispose();
    _imageAnimationController.dispose();
    super.dispose();
  }

  Widget _buildTrackInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 64, bottom: 16),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/icon/home/icon_share.png',
                height: 26,
                width: 24,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Column(
              children: [
                Text(
                  _track.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _track.artist,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_favoriteTrackIds.contains(_track.trackId)) {
                    _favoriteTrackIds.remove(_track.trackId);
                  } else {
                    _favoriteTrackIds.add(_track.trackId);
                  }
                });
              },
              icon: Image.asset(
                _favoriteTrackIds.contains(_track.trackId)
                    ? 'assets/images/icon/home/red_heart.png'
                    : 'assets/images/icon/home/white_heart.png',
                height: 26,
                width: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mediaButton() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaButtonControl(
            function: _setRepeatTrack,
            imagePath: 'assets/images/icon/playlist/icon Repeat.png',
            color: _isRepeating ? AppPallete.gradient2 : Colors.white,
            size: 24,
          ),
          MediaButtonControl(
            function: _setPrevTrack,
            imagePath: 'assets/images/icon/playlist/icon Previous.png',
            color: const Color.fromARGB(255, 255, 255, 255),
            size: 36,
          ),
          _playButton(),
          MediaButtonControl(
            function: _setNextTrack,
            imagePath: 'assets/images/icon/playlist/icon Next.png',
            color: const Color.fromARGB(255, 255, 255, 255),
            size: 36,
          ),
          MediaButtonControl(
            function: _setShuffleTrack,
            imagePath: 'assets/images/icon/playlist/icon Shuffle.png',
            color: _isShuffling ? AppPallete.gradient2 : Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _audioPlayerManager.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;

        return ProgressBar(
          progress: progress,
          total: total,
          buffered: buffered,
          onSeek: _audioPlayerManager.player.seek,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return const CircularProgressIndicator();
        } else if (playing == true) {
          return MediaButtonControl(
            function: _pause,
            icon: Icons.pause,
            size: 48,
            color: null,
          );
        } else if (processingState == ProcessingState.completed) {
          return MediaButtonControl(
            function: _replay,
            icon: Icons.replay,
            size: 48,
            color: null,
          );
        } else {
          return MediaButtonControl(
            function: _play,
            icon: Icons.play_arrow,
            size: 48,
            color: null,
          );
        }
      },
    );
  }

  Widget _lyricButton() {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LyricScreen(
                  track: _track,
                  audioPlayerManager: _audioPlayerManager,
                ),
              ),
            );
          },
          icon: Image.asset(
            'assets/images/icon/playlist/icon_push.png',
            width: 39,
            height: 39,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        Text(
          'Lyrics',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  void _play() {
    _audioPlayerManager.player.play();
    _imageAnimationController.forward(from: _currentAnimationPosition);
    _imageAnimationController.repeat();
  }

  void _pause() {
    _audioPlayerManager.player.pause();
    _imageAnimationController.stop();
    _currentAnimationPosition = _imageAnimationController.value;
  }

  void _replay() {
    _audioPlayerManager.player.seek(Duration.zero);
    _imageAnimationController.forward(from: 0.0);
    _imageAnimationController.repeat();
  }

  void _setNextTrack() {
    setState(() {
      if (_isShuffling) {
        _selectedItemIndex = widget.tracks.length *
            (DateTime.now().millisecondsSinceEpoch % 100) ~/
            100;
      } else if (_selectedItemIndex < widget.tracks.length - 1) {
        _selectedItemIndex++;
      } else if (_isRepeating) {
        _selectedItemIndex =
            0; // Quay lại bài đầu tiên nếu đang lặp lại danh sách
      }

      _track = widget.tracks[_selectedItemIndex];
      _audioPlayerManager.updateTrackUrl(_track.source);
    });
  }

  void _setPrevTrack() {
    setState(() {
      if (_selectedItemIndex > 0) {
        _selectedItemIndex--;
      } else if (_isRepeating) {
        _selectedItemIndex = widget.tracks.length -
            1; // Quay lại bài cuối nếu đang lặp lại danh sách
      }

      _track = widget.tracks[_selectedItemIndex];
      _audioPlayerManager.updateTrackUrl(_track.source);
    });
  }

  void _setRepeatTrack() {
    if (_isShuffling) return; 

    setState(() {
      _isRepeating = !_isRepeating;
      _audioPlayerManager.player
          .setLoopMode(_isRepeating ? LoopMode.one : LoopMode.off);

      if (_isRepeating) {
        _isShuffling = false;
        _audioPlayerManager.player.setShuffleModeEnabled(false);
      }
    });
  }

void _setShuffleTrack() {
  if (_isRepeating) return;

  setState(() {
    _isShuffling = !_isShuffling;
    _audioPlayerManager.player.setShuffleModeEnabled(_isShuffling);

    if (_isShuffling) {
      _isRepeating = false;
      _audioPlayerManager.player.setLoopMode(LoopMode.off);
      List<Track> shuffledTracks = List.from(widget.tracks)..shuffle();

      Future.microtask(() {
        _audioPlayerManager.player.setAudioSource(
          ConcatenatingAudioSource(
            children: shuffledTracks.map((track) => AudioSource.uri(Uri.parse(track.source))).toList(),
          ),
        ).then((_) {
          _selectedItemIndex = 0;
          _track = shuffledTracks[_selectedItemIndex];
          _audioPlayerManager.updateTrackUrl(_track.source);
          _audioPlayerManager.player.play();
        }).catchError((error) {
          debugPrint("Lỗi khi setAudioSource: $error");
        });
      });
    }
  });
}


//đay nhé
  // void _toggleFavorite() {
  //   setState(() {
  //     if (_favoriteTrackIds.contains(_track.trackId)) {
  //       _favoriteTrackIds.remove(_track.trackId);
  //     } else {
  //       _favoriteTrackIds.add(_track.trackId);
  //     }
  //   });
  // }
}

class MediaButtonControl extends StatelessWidget {
  const MediaButtonControl({
    super.key,
    required this.function,
    this.icon,
    this.imagePath,
    this.color,
    this.size,
  });

  final void Function()? function;
  final IconData? icon;
  final String? imagePath;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: function,
      icon: imagePath != null
          ? Image.asset(
              imagePath!,
              width: size,
              height: size,
              color: color,
            )
          : Icon(
              icon,
              size: size,
              color: color ?? const Color.fromARGB(255, 255, 255, 255),
            ),
    );
  }
}
