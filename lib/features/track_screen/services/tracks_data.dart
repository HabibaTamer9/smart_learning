import 'package:smart_learning/features/quiz_screen/services/track_questions.dart';
import 'package:smart_learning/features/track_screen/services/track_model.dart';

class TracksData{
  static final List<TrackModel> tracks = [
    TrackModel(id: "ds", title: "Data Structure", image: "assets/tracks/security.jpg", question: TrackQuestions.ds),
    TrackModel(id: "mobile", title: "Mobile Development", image: "assets/tracks/mobile.jpg", question: TrackQuestions.mobile),
    TrackModel(id: "web", title: "Web Development", image: "assets/tracks/web.jpg", question: TrackQuestions.web),
    TrackModel(id: "uiux", title: "UI & UX", image: "assets/tracks/ui.jpg" , question: TrackQuestions.uiux),
  ];
}