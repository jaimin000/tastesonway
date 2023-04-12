import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tastesonway/apiServices/api_service.dart';
import 'package:tastesonway/screens/dashboard/view%20stories.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:video_compress/video_compress.dart';

class Stories extends StatefulWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  //create story
  late File _image;
  late File _video;


  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 70,
      maxWidth: 800,
      maxHeight: 800,
    );
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(seconds: 15),
      );
      if (pickedFile != null) {
        final video = File(pickedFile.path);
        final videoSize = await video.length();
        // Check if the video size is less than or equal to 3MB (3 * 1024 * 1024 bytes)
        if (videoSize <= 3 * 1024 * 1024) {
          setState(() {
            _video = video;
          });
          Future.delayed(const Duration(seconds: 3), () {
            Fluttertoast.showToast(
              msg: "Story Added Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.orange,
              fontSize: 16.0,
            );
          });
        } else {
          // Compress the video before storing it in _video
          final compressedVideo = await VideoCompress.compressVideo(
            video.path,
            quality: VideoQuality.LowQuality,
          );
          final processedVideo = File(compressedVideo!.path.toString());
          setState(() {
            _video = processedVideo;
          });
        }
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
  }

  void createImgStory() async {
    String token = await getToken();
    try {
      await _pickImage(ImageSource.camera);
      const url = "$storyUrl/owners/create-story";
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      request.fields['type'] = '1';
      request.files.add(
        await http.MultipartFile.fromPath(
          'name',
          _image.path,
        ),
      );
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);
      print(json);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: cardColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Story Uploaded Successfully',
                    style: mTextStyle14(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: cardColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Error uploading image',
                    style: mTextStyle14(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void createVideoStory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 100,
            child: FutureBuilder(
              future: uploadVideo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pop(context);
                    });
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Error uploading video',
                            style: mTextStyle14(),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Please upload video up to 15 sec',
                            style: mTextStyle14(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pop(context);
                    });
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 50.0,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Video uploaded successfully',
                            style: mTextStyle14(),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          color: orangeColor(),
                          strokeWidth: 3.0,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Uploading video...',
                          style: mTextStyle14(),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<String> uploadVideo() async {
        String token = await getToken();
    try {
      await _pickVideo(ImageSource.camera);

      const url = "$storyUrl/owners/create-story";
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      request.fields['type'] = '2';
      request.files.add(
        await http.MultipartFile.fromPath(
          'name',
          _video.path,
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);
      print(json);
      return "Video uploaded successfully";
    } catch (e) {
      print(e);
      throw "Error uploading video";
    }
  }

  // get story_view
  List<dynamic> data = [];

  Future fetchData() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$storyUrl/owners/my-stories'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
        data = jsonData['data'];
      });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: data.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            //create story
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  color: cardColor(),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 5,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ListTile(
                                      leading: Icon(
                                        Icons.photo_library,
                                        color: orangeColor(),
                                      ),
                                      title: Text(
                                        'key_upload_images'.tr,
                                        style: cTextStyle16(),
                                      ),
                                      onTap: () {
                                        createImgStory();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.videocam,
                                        color: orangeColor(),
                                      ),
                                      title: Text(
                                        'key_upload_videos'.tr,
                                        style: cTextStyle16(),
                                      ),
                                      onTap: () {
                                        createVideoStory();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 38,
                              backgroundColor: orangeColor(),
                              child: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
                                radius: 35,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: orangeColor(),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'key_create_story'.tr,
                        style: mTextStyle14(),
                      ),
                    ],
                  ),
                ),
              );
            }
            //get story
            else {
              final reversedIndex = data.length - index + 1;
              //return Text("this is last");
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewStories(
                                data[reversedIndex - 1]['name'],
                                data[reversedIndex - 1]['id'],
                                data[reversedIndex - 1]['media_type']),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: orangeColor(),
                        child: CircleAvatar(
                          backgroundImage: data[reversedIndex - 1]
                                      ['media_type'] ==
                                  "Photos"
                              ? NetworkImage(data[reversedIndex - 1]['name'],
                                  scale: 0.5)
                              : const NetworkImage(
                                  'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bW9kZWxzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
                          radius: 35,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      data[reversedIndex - 1]['id'].toString(),
                      style: mTextStyle14(),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
