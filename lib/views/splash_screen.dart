import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/consts/colors.dart';
import 'package:music_app/consts/text_style.dart';
import 'package:music_app/views/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPList,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              'Find Your \nFavourite Music',
              style: myStyle(
                size: 30,
                weight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                'Find Your Latest Favourite Music\n          From Our Collection',
              style: myStyle(
                  size: 20,
                  weight: FontWeight.normal
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Lottie.asset('assets/images/Animation - 1721669519655.json'),
            Spacer(),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              },
              child: Container(
                padding: EdgeInsets.only(left: 120),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: KPPRIM,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Text(
                      'Get Strated',
                      style: myStyle(
                        size: 14,
                        weight: FontWeight.bold,
                        color: KPwhite
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
