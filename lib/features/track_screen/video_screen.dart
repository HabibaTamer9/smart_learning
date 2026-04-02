import 'package:flutter/material.dart';
class VideoScreen extends StatefulWidget {
  final String videos; // Array of YouTube URLs from Firestore
  // Course document ID

  const VideoScreen({super.key, required this.videos});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  //late YoutubePlayerController _controller;
  int currentVideoIndex = 0;
  Map<String, bool> progress = {}; // Tracks watched videos

  @override
  void initState() {
    super.initState();
    if (widget.videos.isNotEmpty) {
      _loadVideo(widget.videos[currentVideoIndex]);
    }
  }

  void _loadVideo(String url) {
    // final videoId = YoutubePlayer.convertUrlToId(url);
    // if (videoId == null) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Invalid YouTube URL")));
    //   return;
    // }
    //
    // _controller = YoutubePlayerController(
    //   initialVideoId: videoId,
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //   ),
    // );
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

  void _nextVideo() {
    if (currentVideoIndex < widget.videos.length - 1) {
      setState(() {
        currentVideoIndex++;
        _loadVideo(widget.videos[currentVideoIndex]);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You finished all videos!")));
    }
  }

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Video ${currentVideoIndex + 1}/${widget.videos.length}"),
      ),
      body: Column(
        children: [
          // YoutubePlayer(
          //   controller: _controller,
          //   showVideoProgressIndicator: true,
          //   onReady: () {
          //     // optional: start video automatically
          //   },
          // ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _markVideoCompleted(widget.videos[currentVideoIndex]);
              _nextVideo();
            },
            child: const Text("Mark as Completed & Next Video"),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: widget.videos.length,
              itemBuilder: (context, index) {
                final videoUrl = widget.videos[index];
                final watched = progress[videoUrl] ?? false;
                return ListTile(
                  leading: Icon(
                    watched ? Icons.check_circle : Icons.play_circle,
                    color: watched ? Colors.green : null,
                  ),
                  title: Text("Video ${index + 1}"),
                  onTap: () {
                    setState(() {
                      currentVideoIndex = index;
                      _loadVideo(widget.videos[currentVideoIndex]);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
