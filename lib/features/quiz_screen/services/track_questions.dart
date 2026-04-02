import 'package:smart_learning/features/quiz_screen/services/question_model.dart';

class TrackQuestions{
  static final List<QuestionModel> mobile = [
    QuestionModel(
      question: "What is Flutter mainly used for?",
      options: ["Backend", "Mobile UI", "Database", "AI"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Which language is used in Flutter?",
      options: ["Java", "Dart", "Python", "C#"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "What is a Widget in Flutter?",
      options: ["Database", "UI component", "Server", "API"],
      correctIndex: 1,
    ),
    // QuestionModel(
    //   question: "Which widget is used for layout?",
    //   options: ["Column", "Text", "Icon", "Image"],
    //   correctIndex: 0,
    // ),
    // QuestionModel(
    //   question: "What is setState used for?",
    //   options: ["Navigation", "Update UI", "Store data", "API"],
    //   correctIndex: 1,
    // ),
    // QuestionModel(
    //   question: "Which widget is scrollable?",
    //   options: ["Column", "Row", "ListView", "Container"],
    //   correctIndex: 2,
    // ),
    // QuestionModel(
    //   question: "What is Navigator used for?",
    //   options: ["Database", "Routing", "UI design", "State"],
    //   correctIndex: 1,
    // ),
    // QuestionModel(
    //   question: "Which package is used for HTTP requests?",
    //   options: ["http", "flutter_ui", "dart_core", "material"],
    //   correctIndex: 0,
    // ),
    // QuestionModel(
    //   question: "What is Future in Dart?",
    //   options: ["Loop", "Async result", "Widget", "Variable"],
    //   correctIndex: 1,
    // ),
    // QuestionModel(
    //   question: "What is State Management?",
    //   options: ["UI design", "Handling data changes", "Database", "API"],
    //   correctIndex: 1,
    // ),
  ];

  static final List<QuestionModel> web =[
    QuestionModel(
      question: "HTML stands for?",
      options: [
        "Hyper Text Markup Language",
        "High Tool Machine Language",
        "Hyperlinks Text Mark",
        "None"
      ],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "CSS is used for?",
      options: ["Structure", "Styling", "Logic", "Database"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "JavaScript is used for?",
      options: ["Design", "Interactivity", "Database", "Hosting"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Which is a JS framework?",
      options: ["Flutter", "React", "Laravel", "Django"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Which tag is for links?",
      options: ["<a>", "<p>", "<div>", "<img>"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Which property changes text color?",
      options: ["font-size", "color", "margin", "padding"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "DOM stands for?",
      options: [
        "Document Object Model",
        "Data Object Model",
        "Design Object Model",
        "None"
      ],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Which is backend?",
      options: ["HTML", "CSS", "Node.js", "Figma"],
      correctIndex: 2,
    ),
    QuestionModel(
      question: "Which is responsive unit?",
      options: ["px", "%", "cm", "mm"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "API stands for?",
      options: [
        "Application Programming Interface",
        "App Process Integration",
        "Advanced Programming Input",
        "None"
      ],
      correctIndex: 0,
    ),
  ];

  static final List<QuestionModel> uiux = [
    QuestionModel(
      question: "UI stands for?",
      options: ["User Interface", "User Input", "Unique Interface", "None"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "UX focuses on?",
      options: ["Code", "User experience", "Server", "Database"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Which tool is used for design?",
      options: ["Figma", "VS Code", "Postman", "Git"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Wireframe is?",
      options: ["Final design", "Sketch layout", "Code", "API"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Color theory relates to?",
      options: ["Design", "Code", "Backend", "Database"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Typography means?",
      options: ["Fonts", "Colors", "Images", "Code"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "User flow means?",
      options: ["Navigation path", "Code flow", "API", "Database"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Prototype is?",
      options: ["Test design", "Database", "Code", "Server"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Consistency improves?",
      options: ["UX", "Errors", "Code", "API"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Accessibility means?",
      options: ["Easy for all users", "Hard UI", "Backend", "Database"],
      correctIndex: 0,
    ),
  ];

  static final List<QuestionModel> ds = [
    QuestionModel(
      question: "What is an array?",
      options: ["Single value", "Collection of items", "Function", "Loop"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Stack works on?",
      options: ["FIFO", "LIFO", "Random", "None"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Queue works on?",
      options: ["LIFO", "FIFO", "Stack", "None"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Linked list stores?",
      options: ["Nodes", "Arrays", "Strings", "Loops"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Binary tree max children?",
      options: ["1", "2", "3", "4"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Searching faster structure?",
      options: ["Array", "Tree", "Stack", "Queue"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Time complexity of binary search?",
      options: ["O(n)", "O(log n)", "O(1)", "O(n^2)"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Graph consists of?",
      options: ["Nodes & edges", "Arrays", "Loops", "Functions"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Hashing used for?",
      options: ["Sorting", "Searching fast", "Loops", "UI"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Big O represents?",
      options: ["Memory", "Time complexity", "Code", "API"],
      correctIndex: 1,
    ),
  ];
}