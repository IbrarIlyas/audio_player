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
    if (controller.playIndex.value == audioindex) {
      controller.resumeSong();
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
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.all(15),
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: color2, width: 10, style: BorderStyle.solid),
                    shape: BoxShape.circle,
                    color: color1,
                  ),
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
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
                      child: Obx(
                        () => Text(
                          data[controller.playIndex.value].displayNameWOExt,
                          style: mystyle(
                            color_: whitecolor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(
                        () => Text(
                          data[controller.playIndex.value].artist ??
                              'No Artist',
                          style: mystyle(
                              color_: whitecolor,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
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
                              max: controller.max.value + 1,
                              value: controller.value.value,
                              min: 0.0,
                              inactiveColor: whitecolor,
                              activeColor: color1,
                              thumbColor: shadowcolor,
                              onChanged: (value) {
                                controller.changeDurationToSeconds(value);
                                controller.isPlaying.value = true;
                                value = value;
                                controller.resumeSong;
                              },
                            ),
                          ),
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
                        IconButton(
                          onPressed: () {
                            if (controller.playIndex.value > 0) {
                              controller.playSong(
                                  data[controller.playIndex.value - 1].uri!,
                                  controller.playIndex.value - 1);
                            }
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            color: whitecolor,
                            size: 40,
                          ),
                        ),
                        GestureDetector(
                          onTap: onClick,
                          child: CircleAvatar(
                            backgroundColor: color1,
                            radius: 30,
                            child: Obx(
                              () => Transform.scale(
                                scale: 1.25,
                                child: controller.isPlaying.value
                                    ? Icon(
                                        color: whitecolor,
                                        Icons.pause,
                                        size: 50,
                                      )
                                    : Icon(
                                        color: whitecolor,
                                        Icons.play_arrow,
                                        size: 50,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (controller.playIndex.value < data.length - 1) {
                              controller.playSong(
                                  data[controller.playIndex.value + 1].uri!,
                                  controller.playIndex.value + 1);
                            }
                          },
                          icon: Icon(
                            color: whitecolor,
                            Icons.skip_next_rounded,
                            size: 40,
                          ),
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
      controller.pauseSong();
    } else {
      controller.resumeSong();
    }
  }
}
