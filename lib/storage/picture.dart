import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/storage/storage_service.dart';

class Picture extends StatefulWidget {
  const Picture({super.key});

  @override
  State<Picture> createState() => _PictureState();
}

class _PictureState extends State<Picture> {
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
          onLongPress: () async => await delete(linkList[index]),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(linkList[index])
              )
            ),
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
      type: FileType.image,
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

      await StorageService.upload(path: "picture", file: file!);

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
    allList =  await StorageService.getData("picture");
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
