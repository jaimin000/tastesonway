import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjI2OjI0L2FwaS91c2Vycy9raXRjaGVuLW93bmVyLWxvZ2luLXJlZ2lzdHJhdGlvbiIsImlhdCI6MTY3ODM1MTc1MSwiZXhwIjoxNjc4NTY3NzUxLCJuYmYiOjE2NzgzNTE3NTEsImp0aSI6IlNka0VESElQc0lXamF6c2wiLCJzdWIiOiIzIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.OlWI0SSbXUFhflMtr-leznZLzDe38wcz0gEKXju4zZs";
  Future<void> _pickImage(ImageSource source) async {

    final XFile? pickedFile = await ImagePicker().pickImage(source: source);
    // final File? imagefile = File(_image!.path);
    if (pickedFile != null) {
      final String filePath = pickedFile.path;
      setState(() {
        _image = File(filePath);
      });
    }
  }
  void CreateStory() async {
    try {
      await _pickImage(ImageSource.gallery);
      const url = "http://192.168.1.26:24/api/owners/create-story";
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.headers[HttpHeaders.authorizationHeader] =
      'Bearer $token';
      request.fields['type'] = '1';
      // request.fields['name'] = 'my_story_name';

      request.files.add(
        await http.MultipartFile.fromPath(
          'name',
          _image.path.toString(),
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
  fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.26:24/api/owners/my-stories'),headers: {'Authorization': 'Bearer $token'},);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      data = jsonData['data'];
      print(data.length);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
            itemCount: data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context,int index) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewStories(data[index]['name'])),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: orangeColor(),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(data[index]['name'],scale: 0.5),
                          radius: 35,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(data[index]['id'].toString(), style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              );
          }
      ),
    );

        // Column(
        //   children: const [
        //     CircleAvatar(
        //       radius: 38,
        //       backgroundColor: Colors.orange,
        //       child: CircleAvatar(
        //         backgroundImage: NetworkImage(
        //             'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
        //         radius: 35,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 2,
        //     ),
        //     Text("Chef 1", style: TextStyle(color: Colors.white)),
        //   ],
        // ),
        // const SizedBox(
        //   width: 20,
        // ),
        // Column(
        //   children: const [
        //     CircleAvatar(
        //       radius: 38,
        //       backgroundColor: Colors.orange,
        //       child: CircleAvatar(
        //         backgroundImage: NetworkImage(
        //             'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
        //         radius: 35,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 2,
        //     ),
        //     Text("Chef 1", style: TextStyle(color: Colors.white)),
        //   ],
        // ),
        // const SizedBox(
        //   width: 20,
        // ),
        // Column(
        //   children: const [
        //     CircleAvatar(
        //       radius: 38,
        //       backgroundColor: Colors.orange,
        //       child: CircleAvatar(
        //         backgroundImage: NetworkImage(
        //             'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
        //         radius: 35,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 2,
        //     ),
        //     Text("Chef 1", style: TextStyle(color: Colors.white)),
        //   ],
        // ),
        // const SizedBox(
        //   width: 20,
        // ),
  }
}
