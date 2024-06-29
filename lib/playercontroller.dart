import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Playercontroller extends GetxController {
  final onQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  late final RxInt playIndex = 0.obs;
  late final RxBool isPlaying = false.obs;

  var position = ''.obs;
  var duration = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    updatePosition();

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        isPlaying.value =
            false; // Update the isPlaying state when song completes
      }
    });
  }

  playSong(String uri, int index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri),
        ),
      );
      audioPlayer.play();
      isPlaying.value = true;
      updatePosition();
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  changeDurationToSeconds(double second) {
    var dur = Duration(seconds: second.toInt());
    audioPlayer.seek(dur);
  }

  void updatePosition() {
    audioPlayer.durationStream.listen((dur) {
      duration.value = dur.toString().split('.')[0];
      max.value = dur!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((dur) {
      position.value = dur.toString().split('.')[0];
      value.value = dur.inSeconds.toDouble();
    });
  }

  pauseSong() {
    try {
      audioPlayer.pause();
      isPlaying(false);
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  stopSong() {
    try {
      audioPlayer.stop();
      isPlaying(false);
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  resumeSong() {
    try {
      audioPlayer.play();
      isPlaying(true);
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  checkPermission() async {
    PermissionStatus perm = await Permission.storage.request();

    if (!perm.isGranted) {
      checkPermission();
    }
  }
}
