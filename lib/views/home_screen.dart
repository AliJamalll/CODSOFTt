import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_app/consts/colors.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:music_app/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: KPPRIM,
      appBar: AppBar(
        backgroundColor: KPPRIM,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: KPwhite,))
        ],
        leading: Icon(Icons.sort_rounded,color: KPwhite,),
        title: Text(
          'Musica ',
          style:myStyle(
            size: 18,
            weight: FontWeight.bold
          )
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.DESC_OR_GREATER,
          sortType: null,
          uriType: UriType.EXTERNAL
        ),
        builder: (BuildContext context, snapshot) {
          if(snapshot.data == null){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.data!.isEmpty){
            return Center(
              child: Text(
              'No songs found',
              style: myStyle(),
              ),
            );
          }else{
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 33,
                itemBuilder: (BuildContext context,int index){
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Obx(() =>
                     ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: KPList,
                      title: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        '${snapshot.data![index].displayName}',
                        style: myStyle(
                          weight: FontWeight.bold,
                          size: 15
                      ),
                      ),
                      subtitle: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        '${snapshot.data![index].artist}',
                        style: myStyle(
                            weight: FontWeight.bold,
                            size: 15
                        ),
                      ),
                      leading: QueryArtworkWidget(
                        id: snapshot.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Icon(Icons.music_note,color: KPwhite,size: 32,),
                      ),
                      trailing: controller.playIndex == index && controller.isPlaying.value ?  Icon(Icons.play_arrow,color: KPwhite,size: 26,) : null,
                      onTap: (){
                        Get.to(() => Player(data: snapshot.data!,));
                        controller.playSong(snapshot.data![index].uri,index);
                      },
                    ),
                  ),
                );
                   }
                           ),
             );
          }
        }
      )
    );
  }
}
