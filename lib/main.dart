import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  WebSocketChannel channel = IOWebSocketChannel.connect(
      "wss://f9d08db3-f825-4acf-97ea-827e83649559-00-1wy0a08zb2086.kirk.replit.dev");

  MyHomePage({super.key});

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("INFO.<NOW!>",
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 169, 13, 2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.replay_10_outlined, color: Colors.white),
            onPressed: sendData,
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("INFO.<NOW!>",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    backgroundColor: const Color.fromARGB(255, 169, 13, 2),
                    centerTitle: true,
                  ),
                  body: Writing(),
                );
              })),
            },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                    child: Text('NEWS LIST',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))),
                StreamBuilder(
                  stream: widget.channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      final list = snapshot.data
                          .split('|')
                          .map((res) => res.split('&'))
                          .toList();
                      list.removeAt(list.length - 1);
                      print(list);

                      return Column(children: [
                        for (final element in list)
                          MaterialBox(
                              title: element[1],
                              by: element[3],
                              num: element[0],
                              text: element[2],
                              url: element[4])
                      ]);
                    }

                    return const Column(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text('LOADING...',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                        Text(
                            'If the download becomes endless, click on REPLAY.',
                            style: TextStyle(color: Colors.white, fontSize: 25))
                      ],
                    );
                  },
                )
              ],
            ),
          )),
    );
  }

  void sendData() {
    widget.channel.sink.add("GET_INFO");
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}

class MaterialBox extends StatelessWidget {
  final String title;
  final String text;
  final String num;
  final String by;
  final String url;

  const MaterialBox({
    super.key,
    required this.title,
    required this.text,
    required this.num,
    required this.by,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 169, 13, 2),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 128, 46, 40),
            ),
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child: Text(' $num ',
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  )),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return NewsPage(
                      text: text, title: title, num: num, by: by, url: url);
                })),
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(title,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    )),
                Container(margin: const EdgeInsets.all(5.0)),
                Text(text,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  final String title;
  final String text;
  final String num;
  final String by;
  final String url;

  const NewsPage({
    super.key,
    required this.title,
    required this.text,
    required this.num,
    required this.by,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('By $by'),
          backgroundColor: const Color.fromARGB(255, 169, 13, 2),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 300,
                  color: const Color.fromARGB(255, 169, 13, 2),
                  child: Image.network(url, loadingBuilder:
                      (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  })),
              Container(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}

class Writing extends StatefulWidget {
  WebSocketChannel channel = IOWebSocketChannel.connect(
      "wss://f9d08db3-f825-4acf-97ea-827e83649559-00-1wy0a08zb2086.kirk.replit.dev");

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final info = TextEditingController();
  final url = TextEditingController();
  final h = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
    info.dispose();
    url.dispose();
    h.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: h,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: const InputDecoration(
                    hintText: 'Header',
                    helperText: 'Enter your header',
                    border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: const InputDecoration(
                    hintText: 'Nickname',
                    helperText: 'Enter your nickname',
                    border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(height: 10),
              TextFormField(
                controller: info,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: const InputDecoration(
                    hintText: 'Info',
                    helperText: 'Enter your info ',
                    border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: url,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: const InputDecoration(
                    hintText: 'URL',
                    helperText: 'Enter your url',
                    border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                      child: ElevatedButton(
                    onPressed: () {
                      var head = h.text;
                      var inf = info.text;
                      var n = name.text;
                      var uri = url.text;

                      String req = '$head&$inf&$n&$uri';
                      print(req);

                      if (req != " ") {
                        sendMessage(req);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Your info appended free!')));
                      }
                    },
                    child: Text("Append!"),
                  ))),
            ],
          ),
        ),
      ),
    ));
  }
}

void sendMessage(msg) {
  IOWebSocketChannel? channel;
  try {
    channel = IOWebSocketChannel.connect(
        'wss://f9d08db3-f825-4acf-97ea-827e83649559-00-1wy0a08zb2086.kirk.replit.dev');
  } catch (e) {
    print("Error on connecting to websocket: " + e.toString());
  }
  channel?.sink.add(msg);

  channel?.stream.listen((event) {
    if (event!.isNotEmpty) {
      print(event);
      channel!.sink.close();
    }
  });
}
