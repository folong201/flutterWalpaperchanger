import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imgUrl;
  // constr

  const FullScreen({super.key, required this.imgUrl});
  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future <void> changeWallpaper() async {
    int location = WallpaperManager.BOTH_SCREENS;
    var file = await (DefaultCacheManager().getSingleFile(widget.imgUrl));
    var pp = file.toString();
    final String result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // image: Image.asset("assets/font.pg"),

        ),
        child: Column(
          children: [
            Expanded(
              child: Image.network(widget.imgUrl),
            ),
            InkWell(
              onTap: () {
                changeWallpaper();
              },
              child: Container(
                height: 75,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                // ignore: prefer_const_constructors
                margin: EdgeInsets.all(15),
                child: const Center(
                  child: Text(
                    "Set Wallpaper",
                    style: TextStyle(
                      inherit: true,
                      color: Color.fromARGB(236, 238, 238, 189),
                      backgroundColor: Color.fromARGB(109, 20, 20, 20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
