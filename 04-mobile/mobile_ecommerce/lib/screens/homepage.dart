import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> productList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: const MenuButton(),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send),
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 120,
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Featured",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text("See All",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ProductCard(
                    product: productList[0],
                  ),
                  ProductCard(
                    product: productList[1],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ProductCard(
                    product: productList[2],
                  ),
                  ProductCard(
                    product: productList[3],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ProductCard(
                    product: productList[4],
                  ),
                  ProductCard(
                    product: productList[5],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadProducts() {
    Uri uri = Uri.http("192.168.1.104:8080", "/api/products");
    print(uri);
    http.get(uri).then((response) => {
          setState(() {
            productList = json.decode(response.body)['_embedded']['products'];
            print(this.productList);
          })
        });
  }
}

class ProductCard extends StatelessWidget {
  final dynamic product;
  const ProductCard({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(product['imageUrl']);
    final double price = product['unitPrice'];

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 210,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(product['imageUrl'])),
                  ),
                ),
                Text("\$ " + "$price"),
                Text(
                  product['name'],
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  getColorForCategory() {
    Random rnd;
    int min = 0;
    int max = 5;
    rnd = new Random();
    var categoryNamber = min + rnd.nextInt(max - min);
    if (categoryNamber == 1) {
      return Colors.red;
    }
    if (categoryNamber == 2) {
      return Colors.blue;
    }
    if (categoryNamber == 3) {
      return Colors.grey;
    }
    if (categoryNamber == 4) {
      return Colors.tealAccent;
    }
    return Colors.white;
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ));
  }
}
