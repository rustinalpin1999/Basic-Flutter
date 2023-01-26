import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery Access',
      theme: ThemeData(
          // platform: TargetPlatform.iOS,
          primarySwatch: Colors.deepPurple),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File imageFile;
  late File videoFile;

  _camera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageFile = image as File;
      });
    }

    _picture() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imageFile = image as File;
        });
      }

      _videopick() async {
        XFile? theVid =
            await ImagePicker().pickVideo(source: ImageSource.gallery);
        if (theVid != null) {
          videoFile = theVid as File;
          print("Set");
        }
      }

      _videoRec() async {
        XFile? theVid =
            await ImagePicker().pickVideo(source: ImageSource.camera);
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Working'),
          ),
          body: Center(
              child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.brown,
                    height: MediaQuery.of(context).size.height * (30 / 100),
                    width: MediaQuery.of(context).size.width * (100 / 100),
                    child: videoFile == null
                        ? Center(
                            child: Icon(
                              Icons.videocam,
                              color: Colors.red,
                              size: 50.0,
                            ),
                          )
                        : FittedBox(
                            fit: BoxFit.contain,
                            child: mounted
                                ? Chewie(
                                    controller: ChewieController(
                                      videoPlayerController:
                                          VideoPlayerController.file(videoFile),
                                      aspectRatio: 3 / 2,
                                      autoPlay: true,
                                      looping: true,
                                    ),
                                  )
                                : Container(),
                          ),
                  ),
                  Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height * (30 / 100),
                    width: MediaQuery.of(context).size.width * (100 / 100),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: imageFile == null
                          ? Center(
                              child: Icon(Icons.photo, color: Colors.amber),
                            )
                          : Image.file(imageFile),
                    ),
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Camera'),
                        Icon(Icons.camera),
                      ],
                    ),
                    onPressed: (() {
                      _camera();
                    }),
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Picture'),
                        Icon(Icons.add_a_photo),
                      ],
                    ),
                    onPressed: () {
                      _picture();
                    },
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(' Fetch Video'),
                        Icon(Icons.video_library),
                      ],
                    ),
                    onPressed: () {
                      _videopick();
                    },
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Record'),
                        Icon(Icons.videocam),
                      ],
                    ),
                    onPressed: () {
                      _videoRec();
                    },
                  )
                ],
              )
            ],
          )),
        );
      }
    }
  }
}
