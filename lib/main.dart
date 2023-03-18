import 'package:chat_services/resources/styles.dart';
import 'package:chat_services/view/auth/login_screen/login_screen.dart';
import 'package:chat_services/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    const ProviderScope(child: ChatApp()),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: AppStyles.appTheme,
      home: const SplashView(),
    );
  }
}

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   List<ChatMessage> _messages = <ChatMessage>[];
//   TextEditingController _textController = TextEditingController();
//   bool _isWriting = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat App'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Flexible(
//             child: ListView.builder(
//               padding: EdgeInsets.all(8.0),
//               reverse: true,
//               itemBuilder: (_, int index) => _messages[index],
//               itemCount: _messages.length,
//             ),
//           ),
//           Divider(height: 1.0),
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//             ),
//             child: _buildTextComposer(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(color: Theme.of(context).accentColor),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           children: <Widget>[
//             Flexible(
//               child: TextField(
//                 controller: _textController,
//                 onChanged: (String text) {
//                   setState(() {
//                     _isWriting = text.length > 0;
//                   });
//                 },
//                 onSubmitted: _handleSubmit,
//                 decoration: const InputDecoration.collapsed(
//                   hintText: 'Send a message',
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 4.0),
//               child: IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: _isWriting
//                     ? () => _handleSubmit(_textController.text)
//                     : null,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleSubmit(String text) {
//     _textController.clear();
//     setState(() {
//       _isWriting = false;
//     });
//     ChatMessage message = ChatMessage(
//       text: text,
//       sender: 'Me',
//       time: DateTime.now(),
//       imageUrl: '',
//       voiceUrl: '',
//       pdfUrl: '',
//       isGroup: false,
//     );
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }
// }

// class ChatMessage extends StatelessWidget {
//   final String? text;
//   final String? sender;
//   final DateTime? time;
//   final String? imageUrl;
//   final String? voiceUrl;
//   final String? pdfUrl;
//   final bool? isGroup;

//   const ChatMessage({super.key, 
//     this.text,
//     this.sender,
//     this.time,
//     this.imageUrl,
//     this.voiceUrl,
//     this.pdfUrl,
//     this.isGroup,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.only(right: 16.0),
//             child: CircleAvatar(
//               child: Text(sender!),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   sender!,
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 5.0),
//                   child: Container(
//                     child: Text(text!),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 5.0),
//                   child: Text(
//                     time.toString(),
//                     style: Theme.of(context).textTheme.caption,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 16.0),
//             child: const Icon(Icons.check_circle_outline),
//           ),
//         ],
//       ),
//     );
//   }
// }
