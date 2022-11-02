import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the3/fullScreen.dart';

// ignore: camel_case_types
class wallpaper extends StatefulWidget {
  const wallpaper({super.key});

  @override
  State<wallpaper> createState() => _wallpaperState();
}

// ignore: camel_case_types
class _wallpaperState extends State<wallpaper> {
  int pageNbr = 1;
  var imageList = [];
  //there you will put you pexeell token api
  static const kenken =
      '563492ad6f91700001000001f16c3be39a204a74acf38f50c809a9b5';
  @override
  void initState() {
    super.initState();
    getImage();
  }

  void  getImage() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=2'),
        headers: {'Authorization': kenken}).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        imageList = result['photos'];
        print(imageList[1]);
      });
    });
  }

  void loadMore() async {
    setState(() {
      pageNbr = pageNbr + 1;
    });
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=2&page=$pageNbr"),
        headers: {'Autorization': kenken}).then((value) {
      setState(() {
        Map result = jsonDecode(value.body);
        imageList.addAll( result['photos']) ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
                  child: GridView.builder(
                      itemCount: imageList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        childAspectRatio: 2 / 4,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imgUrl: imageList[index]['src']
                                              ['large2x'])));
                            },
                            child: Container(
                              color: const Color.fromARGB(228, 226, 143, 19),
                              child: Image.network(
                                imageList[index]['src']['tiny'],
                                fit: BoxFit.cover,
                              ),
                            ));
                      }))),
          InkWell(
            onTap: () {
               loadMore();
              print("more image loaded");
            },
            child: Container(
              height: 75,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              // ignore: prefer_const_constructors
              margin: EdgeInsets.all(15),
              child: const Center(
                child: Text(
                  "load More wallpaper",
                  style: TextStyle(
                    inherit: true,
                    color: Color.fromARGB(239, 168, 33, 15),
                    backgroundColor: Color.fromARGB(109, 7, 7, 7),
                    height: 40,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
