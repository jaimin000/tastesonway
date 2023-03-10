import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

var token;

void fetchData() async {
  const url =
      "http://192.168.1.26:24/api/users/kitchen-owner-login-registration";

  final tokenResponse = await http.post(Uri.parse(url), body: {
    "language_id": "1",
    "mobile_number": "7069836196",
    "device_token":
        "emov0vGxQzCdZ52WfImQj_:APA91bF80ycUzwgUTnz4RoYpSuG4E1KRvQ8Sif7Gjwhv9CPWGumADxeEaJ0FZyurK3dVG5UYwM7Z5QYYIFLqMR0A1KRbXb_-XwmpeA9Tyg17JD01a52V36jSYmQnQ03lbc3ninBgUZt",
    "device_id": "51689555c4cf988a",
    "platform": "1",
    "gender": "1",
    "referral_code": "a5265bb5",
    "short_code": "IN",
    "country_code": "91"
  });
  final json = jsonDecode(tokenResponse.body);
  print(json['data'][0]['token']);
  token = json['data'][0]['token'];
}

//create story
// late File _image;
//
// Future<void> _pickImage(ImageSource source) async {
//
//   final XFile? pickedFile = await ImagePicker().pickImage(source: source);
//   // final File? imagefile = File(_image!.path);
//   if (pickedFile != null) {
//     final String filePath = pickedFile.path;
//     setState(() {
//       _image = File(filePath);
//     });
//   }
// }
//
// void CreateStory() async {
//   try {
//     await fetchData();
//     await _pickImage(ImageSource.gallery);
//     const url = "http://192.168.1.26:24/api/owners/create-story";
//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse(url),
//     );
//     request.headers[HttpHeaders.authorizationHeader] =
//     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjI2OjI0L2FwaS91c2Vycy9raXRjaGVuLW93bmVyLWxvZ2luLXJlZ2lzdHJhdGlvbiIsImlhdCI6MTY3ODM1MTc1MSwiZXhwIjoxNjc4NTY3NzUxLCJuYmYiOjE2NzgzNTE3NTEsImp0aSI6IlNka0VESElQc0lXamF6c2wiLCJzdWIiOiIzIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.OlWI0SSbXUFhflMtr-leznZLzDe38wcz0gEKXju4zZs';
//     request.fields['type'] = '1';
//     // request.fields['name'] = 'my_story_name';
//
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         'name',
//         _image.path,
//       ),
//     );
//     final response = await request.send();
//     final responseData = await response.stream.bytesToString();
//     final json = jsonDecode(responseData);
//     print(json);
//   } catch (e) {
//     print(e);
//   }
// }