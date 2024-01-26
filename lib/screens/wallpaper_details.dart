import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class WallpaperDetailsPage extends StatelessWidget {
  const WallpaperDetailsPage({super.key,required this.wallUrl});

  final String wallUrl;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(wallUrl,fit: BoxFit.fill,)),
            Positioned(
              bottom: 25,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OptionWidget(icon: Ionicons.information_circle,name: 'Info'),
                    OptionWidget(icon: Ionicons.download,name: 'Save'),
                    OptionWidget(icon: Ionicons.brush,name: 'Apply'),
                  ],
                ),
              ),
            )
          ],
        )),
    );
  }
}

class OptionWidget extends StatelessWidget {
   OptionWidget({
    super.key,
    required this.icon,
    required this.name
  });

  IconData icon;
  String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
          color: Colors.grey.withOpacity(0.7)),
          child: Icon(icon,color: Colors.white,),
        ),
        SizedBox(height: 10,),
        Text(name,style: TextStyle(fontSize: 15,color: Colors.white),),

      ],
    );
  }
}