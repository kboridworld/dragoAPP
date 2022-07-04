import 'package:audioplayers/audioplayers.dart';

class AudioUtils {
  static final AudioUtils _instance = AudioUtils._internal();

  AudioUtils._internal() {
    _audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
  }

  factory AudioUtils() => _instance;

  static AudioUtils get instance => _instance;

  late AudioPlayer _audioPlayer;
  late AudioCache _audioCache;

  ///
  /// 签收、装货完成后播放提示音
  Future playSignSounds() async {
    return this.playLocalSounds('audios/sound_complete.mp3');
  }

  ///
  /// 刷新成功时播放提示音
  Future playRefreshSounds() async {
    return this.playLocalSounds('audios/sound_refresh.mp3');
  }

  Future playLocalSounds(String? path) async {
    if (path == null || path.length == 0) {
      return;
    }
    return _audioCache.play(
      path,
      mode: PlayerMode.LOW_LATENCY,
    );
  }
}
