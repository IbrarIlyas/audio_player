import 'package:audio_app/constants.dart';
import 'package:audio_app/playercontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = Get.put(Playercontroller());
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'MY', style: mystyle(fontSize: 25, color_: color1)),
                  TextSpan(
                    text: ' SONGS',
                    style: mystyle(
                        color_: whitecolor, fontSize: 30, letterSpacing: 4),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: FutureBuilder<List<SongModel>>(
              future: controller.onQuery.querySongs(
                ignoreCase: true,
                uriType: UriType.EXTERNAL,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: SongSortType.DISPLAY_NAME,
              ),
              initialData: null,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        clipBehavior: Clip.hardEdge,
                        child: Obx(
                          () => ListTile(
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              style:
                                  mystyle(color_: Colors.white, fontSize: 14),
                            ),
                            subtitle: Text(
                              snapshot.data![index].artist ?? "No Artist",
                              style: mystyle(fontSize: 10),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Icon(
                                Icons.music_note,
                                color: whitecolor,
                              ),
                              artworkWidth: 30,
                              artworkHeight: 30,
                            ),
                            trailing: (controller.playIndex.value == index &&
                                    controller.isPlaying.value == true)
                                ? Icon(
                                    Icons.pause,
                                    color: whitecolor,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    color: whitecolor,
                                  ),
                            onTap: () {
                              controller.playSong(
                                  snapshot.data![index].uri, index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
