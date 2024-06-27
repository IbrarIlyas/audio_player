import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Playercontroller extends GetxController {
  final onQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  late final RxInt playIndex = 0.obs;
  late final RxBool isPlaying = false.obs;
  @override
  void onInit() {
    super.onInit();
    check_Permission();
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
      isPlaying(true);
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  check_Permission() async {
    PermissionStatus perm = await Permission.storage.request();

    if (perm.isGranted) {
    } else {
      check_Permission();
    }
  }
}
