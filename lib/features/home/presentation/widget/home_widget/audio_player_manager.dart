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
    // Lắng nghe trạng thái player
    player.playerStateStream.listen((state) {
      _playerStateSubject.add(state);
    });

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

    await player.setUrl(trackUrl);
  }

  void updateTrackUrl(String url) async {
    trackUrl = url;
    await player.setUrl(trackUrl);
    await player.play();
  }

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
