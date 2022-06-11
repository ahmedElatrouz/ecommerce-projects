import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications),color: Colors.black,),
          IconButton(onPressed: (){}, icon: Icon(Icons.send),color: Colors.black,),

        ],
      ),
    );
  }
}