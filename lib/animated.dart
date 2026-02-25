import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_background/animated_background.dart';
import 'package:scrren_cart/home.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        vsync:this ,
       behaviour: RandomParticleBehaviour(
        options: const ParticleOptions(
          spawnMaxRadius: 40,
          spawnMinSpeed: 15,
          particleCount: 80,
          spawnMaxSpeed: 40,
          baseColor: Colors.blue,
          //image: Image.asset("assets/backkk.jpeg")
        ),
        
       ),
       child: Padding(
         padding: const EdgeInsets.only(
          top: 140,
          left: 140,
         ),
         child: GestureDetector(
          onTap: (){
             Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return  home();
                  }));
          },
           child: Container(
            height: 54,
            width: 54,
           decoration: BoxDecoration(
             color: Colors.white,
             shape: BoxShape.circle,
             border: Border.all(color: Colors.black)
           ),
            child: const Icon(Icons.edit)),
         ),
       ),
      ),
      
    );
    
  }
}
