import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerManager {
  final AudioPlayer player = AudioPlayer();
  late BehaviorSubject<PlayerState> _playerStateSubject;
  late BehaviorSubject<DurationState> _durationStateSubject;
  String trackUrl;

  AudioPlayerManager({required this.trackUrl}) {
    _playerStateSubject = BehaviorSubject<PlayerState>();
    _durationStateSubject = BehaviorSubject<DurationState>();
    init();
  }

  Stream<PlayerState> get playerStateStream => _playerStateSubject.stream;
  Stream<DurationState> get durationState => _durationStateSubject.stream;

  void init() async {
    // Listen to player state
    player.playerStateStream.listen((state) {
      _playerStateSubject.add(state);
    });

    // Combine position and playback event to create DurationState
    Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
      player.positionStream,
      player.playbackEventStream,
      (position, playbackEvent) => DurationState(
        progress: position,
        buffered: playbackEvent.bufferedPosition,
        total: playbackEvent.duration ?? Duration.zero,
      ),
    ).listen((state) {
      _durationStateSubject.add(state);
    });

    try {
      await player.setUrl(trackUrl);
    } catch (e) {
      print("Error initializing player: $e");
      // You could throw an error or propagate this to the UI
    }
  }

  // Update track URL if different from the current one
  void updateTrackUrl(String url) async {
    if (trackUrl != url) {
      trackUrl = url;
      try {
        if (player.playerState.processingState != ProcessingState.idle) {
          await player.stop();
        }
        await player.setUrl(trackUrl);
        await player.play();
      } catch (e) {
        print("Error updating track URL: $e");
        // You could throw an error or propagate this to the UI
      }
    }
  }

  // Dispose of resources
  void dispose() {
    player.dispose();
    _playerStateSubject.close();
    _durationStateSubject.close();
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    required this.total,
  });

  final Duration progress;
  final Duration buffered;
  final Duration total;
}
