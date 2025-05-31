import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    _init();
  }

  // MyAudioHandler() {
  //     // Listen to player state and update the playback state
  //     _player.playerStateStream.listen((playerState) {
  //       playbackState.add(
  //         PlaybackState(
  //           controls: [MediaControl.play, MediaControl.pause, MediaControl.stop],
  //           playing: playerState.playing,
  //           processingState: AudioProcessingState.ready,
  //           updatePosition: _player.position,
  //         ),
  //       );
  //     });
  //   }
  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
  }

  Future<void> playFromUrl(String url) async {
    await _player.setUrl(url); // 🔗 set URL
    await _player.play(); // ▶️ start playback
  }

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> pause() => _player.pause();
}
