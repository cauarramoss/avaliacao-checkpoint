import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/widgets/hero_section_widget.dart';



class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon( Icons.menu, size: 40),
        title: Image.asset( 'assets/logo_usedev.png', height: 40),
        centerTitle: true,
        actions: [
          Icon(Icons.person_outline, size:40),
          SizedBox(width: 10),
          Icon(Icons.shopping_cart_outlined, size:40),
          SizedBox(width: 25),
        ],
      ),
      body: Column(
        spacing: 28,
        crossAxisAlignment: .stretch,
        children: [HeroSectionWidget()],
      ),
    );
  }
}



