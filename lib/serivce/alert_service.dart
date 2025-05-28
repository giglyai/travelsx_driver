import 'package:audioplayers/audioplayers.dart';

class AlertPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playRideAlert(String url) async {
    try {
      await _player.play(UrlSource(url));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void stop() {
    _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
