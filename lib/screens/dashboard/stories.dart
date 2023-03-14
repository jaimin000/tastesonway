import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tastesonway/apiServices/ApiService.dart';
import 'package:tastesonway/screens/dashboard/view%20stories.dart';
import 'package:tastesonway/theme_data.dart';


class Stories extends StatefulWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {

  //create story
  late File _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 800,
    );
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void createStory() async {
    String token = await getToken();
    try {
      await _pickImage(ImageSource.camera);

      const url = "http://192.168.1.26:24/api/owners/create-story";
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
    } catch (e) {
      print(e);
    }
  }

  //get story
  List<dynamic> data = [];
  Future fetchData() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('http://192.168.1.26:24/api/owners/my-stories'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        data = jsonData['data'];
      });
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
    return  FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: data.length+1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                //create story
                if (index == 0){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: createStory,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor: orangeColor(),
                                  child: CircleAvatar(
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
                                    child: Center(
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
                          SizedBox(
                            height: 2,
                          ),
                          Text('Create Story', style: TextStyle(color: Colors.white)),
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
                                builder: (context) =>
                                    ViewStories(data[reversedIndex -1]['name'],data[reversedIndex -1]['id'])),
                          );
                        },
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor: orangeColor(),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(data[reversedIndex-1]['name'], scale: 0.5),
                            radius: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(data[reversedIndex-1]['id'].toString(),
                          style: TextStyle(color: Colors.white)),
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
