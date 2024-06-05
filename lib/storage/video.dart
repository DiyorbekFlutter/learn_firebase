import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/storage/storage_service.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  File? file;
  List<String>linkList = [];
  (List<String>, List<String>)allList = ([], []);
  List<String>nameList = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading ? ListView.separated(
        itemCount: linkList.length,
        padding: const EdgeInsets.symmetric(vertical: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) => InkWell(
          onTap: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => VideoPlayerPage(url: linkList[index])));
          },
          onLongPress: () async => await delete(linkList[index]),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: 60,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(nameList[index], style: const TextStyle(color: Colors.white)),
          ),
        ),
      ) : const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
          strokeCap: StrokeCap.round,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await uploadFile();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<File?>takeFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      file = File(result.files.single.path!);
      return file;
    } else {
      return null;
    }
  }

  Future<void>uploadFile()async{
    file = await takeFile();
    if(file != null){
      isLoading = true;
      setState(() {});

      await StorageService.upload(path: "videos", file: file!);

      isLoading = false;
      setState(() {});
      await getItems();

      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully uploaded"))
      );
    }
  }

  Future<void>getItems()async{
    isLoading = true;
    allList =  await StorageService.getData("videos");
    linkList = allList.$1;
    nameList = allList.$2;
    isLoading = false;
    setState(() {});
  }

  Future<void> delete(String url)async{
    isLoading = true;
    setState(() {});
    await StorageService.delete(url);
    await getItems();
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }
}









class VideoPlayerPage extends StatefulWidget {
  final String url;
  const VideoPlayerPage({required this.url, super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.url)
      )
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlickVideoPlayer(flickManager: flickManager),
      ),
    );
  }
}
