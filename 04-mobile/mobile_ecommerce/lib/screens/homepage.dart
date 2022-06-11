import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: const MenuButton(),
        actions: <Widget>[
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.notifications_none),color: Colors.black,),
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.send),color: Colors.black,),

        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        Scaffold.of(context).openDrawer();
      }, 
      icon: const Icon(Icons.menu, color: Colors.black,));
  }
}