
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/consts/colors.dart';
import 'package:music_app/consts/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/player_controller.dart';

class Player extends StatelessWidget {
   Player({super.key, required this.data});

  final List<SongModel> data;
   final PlayerController controller = Get.find<PlayerController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPPRIM,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new,color: KPwhite,),
        ),
        centerTitle: true,
        title: Text(
          'Now Playing',
          style: myStyle(
            color: KPwhite,
            size: 20,
            weight: FontWeight.bold
          ),
        ),
        actions:[ IconButton(
          onPressed: (){},
          icon: Icon(Icons.share,color: KPwhite,),
        ),
        ]

      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,8,8,0),
        child: Column(
          children: [
            Obx( () =>
               Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child:QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: Icon(Icons.music_note,size: 48,color: KPwhite,),
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16)
                    )
                  ),
                  child: Obx(()=> Column(
                      children: [
                        Text(
                         data[controller.playIndex.value].displayNameWOExt,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: myStyle(
                            color: KPblack,
                            weight: FontWeight.bold,
                            size: 24
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          data[controller.playIndex.value].artist!.toString(),
                          style: myStyle(
                              color: KPgrey,
                              weight: FontWeight.normal,
                              size: 20
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Obx(() =>
                           Row(
                            children: [
                              Text(
                                  controller.position.value,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: myStyle(color: KPblack)
                                ),
                              Expanded(
                                  child: Slider(
                                    thumbColor: KPslidercolor,
                                      activeColor: KPslidercolor,
                                      inactiveColor: KPgrey,
                                      value: controller.value.value,
                                      min: Duration(seconds: 0).inSeconds.toDouble(),
                                      max: controller.max.value,
                                      onChanged: (newValue){
                                      controller.changeDurationTOSeconds(newValue.toInt());
                                      newValue = newValue;
                                      }
                                  )
                              ),
                              Text(
                                controller.duration.value,
                                style: myStyle(color: KPblack),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: (){
                                  controller.playSong(data[controller.playIndex.value-1].uri, controller.playIndex.value-1);
                                },
                                icon: Icon(Icons.skip_previous_rounded,size: 40,)
                            ),
                            Obx(() => CircleAvatar(
                                backgroundColor: KPblack,
                                radius: 35,
                                child: Transform.scale(
                                  scale:2.5,
                                  child: IconButton(
                                      onPressed: (){
                                        if(controller.isPlaying.value){
                                          controller.audioPlayer.pause();
                                          controller.isPlaying(false);
                                        }else{
                                          controller.audioPlayer.play();
                                          controller.isPlaying(true);
                                        }
                                      },
                                      icon: controller.isPlaying.value ?
                                      Icon(Icons.pause,color: KPwhite) :
                                      Icon(Icons.play_arrow_rounded,color: KPwhite,)
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  controller.playSong(data[controller.playIndex.value+1].uri, controller.playIndex.value+1);
                                },
                                icon: Icon(Icons.skip_next_rounded,size: 40,)
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
