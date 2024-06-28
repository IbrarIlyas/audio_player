import 'package:audio_app/constants.dart';
import 'package:audio_app/playercontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final controller = Get.find<Playercontroller>();
  final List<SongModel> data;
  final int audioindex;
  PlayerScreen({super.key, required this.data, required this.audioindex}) {
    if (controller.isPlaying.value == audioindex) {
      controller.resumeSong(
        data[audioindex].uri!,
        audioindex,
      );
    } else {
      controller.playSong(data[audioindex].uri!, audioindex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            shadowcolor,
            color1,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: whitecolor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color1,
                ),
                child: QueryArtworkWidget(
                  id: data[audioindex].id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: double.infinity,
                  artworkHeight: double.infinity,
                  nullArtworkWidget: Icon(
                    size: 200,
                    Icons.music_note,
                    color: whitecolor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        data[audioindex].displayNameWOExt,
                        style: mystyle(
                          color_: whitecolor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        data[audioindex].artist.toString(),
                        style: mystyle(
                            color_: whitecolor,
                            fontSize: 10,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            controller.position.value,
                            style: mystyle(fontSize: 10),
                          ),
                          Expanded(
                              child: Slider(
                                  max: controller.max.value,
                                  value: controller.value.value,
                                  min: 0.0,
                                  inactiveColor: whitecolor,
                                  activeColor: color1,
                                  thumbColor: shadowcolor,
                                  onChanged: (value) {
                                    controller.changeDurationToSeconds(value);
                                    value = value;
                                  })),
                          Text(
                            controller.duration.value,
                            style: mystyle(fontSize: 10),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.skip_previous_rounded,
                          color: whitecolor,
                          size: 40,
                        ),
                        GestureDetector(
                          onTap: onClick,
                          child: CircleAvatar(
                            backgroundColor: color1,
                            radius: 30,
                            child: Obx(
                              () => Transform.scale(
                                  scale: 1,
                                  child: controller.isPlaying.value
                                      ? Icon(
                                          color: whitecolor,
                                          Icons.pause,
                                          size: 54,
                                        )
                                      : Icon(
                                          color: whitecolor,
                                          Icons.play_arrow,
                                          size: 54,
                                        )),
                            ),
                          ),
                        ),
                        Icon(
                          color: whitecolor,
                          Icons.skip_next_rounded,
                          size: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClick() {
    if (controller.isPlaying.value) {
      controller.pauseSong(data[audioindex].uri!);
    } else {
      controller.resumeSong(data[audioindex].uri!, audioindex);
    }
  }
}
