import 'dart:async';

import 'dart:math';

import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:async_client_app/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Client Async App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebSocketChannel channel =
      HtmlWebSocketChannel.connect("ws://localhost:8045/Echo");

  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialog(
              title: "And the lucky number is:",
              content: data,
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> getData() async {
      Random random = Random();
      int randomNumber = random.nextInt(100);
      channel.sink.add(randomNumber);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              child: const Text("Click me!"),
              onPressed: getData,
            ),
          ),
        ],
      ),
    );
  }
}
