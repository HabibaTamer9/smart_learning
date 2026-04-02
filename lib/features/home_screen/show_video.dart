import 'package:flutter/material.dart';
import 'package:smart_learning/core/const/app_size.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideo extends StatefulWidget {
  const ShowVideo({super.key, required this.videos});
  final String videos;


  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  int currentVideoIndex = 0;
  Map<String, bool> progress = {};
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

      _loadVideo(widget.videos);

  }

  void _loadVideo(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid YouTube URL")));
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _markVideoCompleted(String videoUrl) async {
    setState(() {
      progress[videoUrl] = true;
    });

    // try {
    //   // Save progress to Firestore
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc("user1") // غيّري لـ UID الخاص بالمستخدم
    //       .collection('progress')
    //       .doc(widget.courseId)
    //       .set(progress, SetOptions(merge: true));
    // } catch (e) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Error saving progress: $e")));
    // }
  }

  // void _nextVideo() {
  //   if (currentVideoIndex < widget.videos.length - 1) {
  //     setState(() {
  //       currentVideoIndex++;
  //       _loadVideo(widget.videos[currentVideoIndex]);
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("You finished all videos!")));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.videos.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("No Videos")),
        body: const Center(
          child: Text("No videos found for this course"),
        ),
      );
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),

        builder: (context, player) {
          return Scaffold(
            body: Column(
              children: [
                SizedBox(
                    height: AppSize.height * 0.4,
                    width: AppSize.width,
                    child: player),
              ],
            ),
          );
        }

    );
  }
}
