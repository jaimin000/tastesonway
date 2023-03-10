import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class ViewStories extends StatefulWidget {

  String image;
  ViewStories(this.image);

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

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        // StoryItem.text(
        //   title: "I guess you'd love to see more of our food. That's great.",
        //   backgroundColor: Colors.blue,
        // ),
        StoryItem.pageImage(
          url: widget.image,
          controller: controller,
        ),
      ],
      repeat: false,
      onComplete: () {
        Navigator.pop(context);
        // setState(() {
        //   _storyItems.clear();
        // });
      },
      controller: controller,

    );
  }
}
