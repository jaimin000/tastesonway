import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:story_view/story_view.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/ApiService.dart';

class ViewStories extends StatefulWidget {
  String image;
  int id;
  String media_type;
  ViewStories(this.image, this.id,this.media_type);

  @override
  State<ViewStories> createState() => _ViewStoriesState();
}

class _ViewStoriesState extends State<ViewStories> {
  //get story
  final StoryController controller = StoryController();

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //delete story
  Future DeleteData() async {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('http://192.168.1.26:24/api/owners/delete-story'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'story_id': widget.id.toString()},
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Story Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
      print("Story Deleted Successfully");
    } else {
      print(widget.id);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Story'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DeleteData();
            },
          ),
        ],
      ),
      body: StoryView(
        storyItems: [
          widget.media_type == "Photos" ?
           StoryItem.pageImage(
                  url: widget.image,
                  controller: controller,
                ) :
          StoryItem.pageVideo(
            widget.image,
            controller: controller,
          ),
        ],
        repeat: false,
        onComplete: () {
          Navigator.pop(context);
        },
        controller: controller,
      ),
    );
  }
}
