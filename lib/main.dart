import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

var new_list = {
  "D": [
    'Duku is shmuda!',
    'Duku was alert, that he is shmuda!',
    'Pushonok2010',
    'https://i.pinimg.com/originals/63/98/2d/63982d3b4bde8799a227dd5fea9149e2.jpg',
  ],
  "П": [
    'Поздравление Патины Игоревны.',
    'Поздравление Патины Игоревны с Новым Годом!',
    'PATINGARD OFFICIAL PRESS-SYSTEM',
    'https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663111546_8-mykaleidoscope-ru-p-moskva-siti-rossiya-dostoprimechatelnosti-8.jpg',
  ],
  "Д": [
    'ДД Новости',
    'Дом Дракона объявляет о временном прекращение работ и полной изоляции Ванинграда.',
    'The House Of The Dragon',
    'https://cdn-icons-png.flaticon.com/512/2548/2548296.png',
  ]
};

var askings = {
  "Duku": ["How I am?", false],
};

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color.fromARGB(255, 67, 91, 103)),
      home: Bar(),
    ),
  );
}

class Bar_X extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color.fromARGB(255, 67, 91, 103)),
      home: Scaffold(appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 128, 46, 40),
            title: const Text('INFO.NOW'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Alert checking',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checking the news..')));
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Bar();
                  }));
                },
              ),
              IconButton(
                  icon: const Icon(Icons.navigate_next),
                  tooltip: 'Enter',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor:
                              const Color.fromARGB(255, 128, 46, 40),
                          title: const Text('INFO.NOW'),
                        ),
                        body: Column(
                          children: [
                            Container(
                              height: 30,
                            ),
                            const Text(
                              'Сейчас вы попали на страницу выбора действий в INFO.NOW. Выберите действие, которое вы хотите выполнить.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                            Container(
                                height: 100,
                                width: 600,
                                margin: const EdgeInsets.only(top: 100.0),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 202, 52, 14),
                                      Color.fromARGB(255, 159, 13, 13),
                                      Color.fromARGB(255, 194, 20, 20),
                                    ],
                                  ),
                                ),
                                child: TextButton(
                                    child: const Text(
                                      "I'd like to ask some question!",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    onPressed: () => {
                                          Navigator.push(context,
                                              MaterialPageRoute<void>(builder:
                                                  (BuildContext context) {
                                            return const Asking();
                                          }))
                                        })),
                            Container(
                                height: 100,
                                width: 600,
                                margin: const EdgeInsets.only(top: 20.0),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 202, 52, 14),
                                      Color.fromARGB(255, 159, 13, 13),
                                      Color.fromARGB(255, 194, 20, 20),
                                    ],
                                  ),
                                ),
                                child: TextButton(
                                    child: const Text(
                                      "I'd like to answer some question!",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    onPressed: () => {
                                          Navigator.push(context,
                                              MaterialPageRoute<void>(builder:
                                                  (BuildContext context) {
                                            return QuestionsBox();
                                          }))
                                        })),
                            Container(
                                height: 100,
                                width: 600,
                                margin: const EdgeInsets.only(top: 20.0),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 202, 52, 14),
                                      Color.fromARGB(255, 159, 13, 13),
                                      Color.fromARGB(255, 194, 20, 20),
                                    ],
                                  ),
                                ),
                                child: TextButton(
                                    child: const Text(
                                      "I'd like to write some info!",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    onPressed: () => {
                                          Navigator.push(context,
                                              MaterialPageRoute<void>(builder:
                                                  (BuildContext context) {
                                            return Writing();
                                          }))
                                        })),
                          ],
                        ),
                      );
                    }));
                  })
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(5.0),
                child: const Text('NEWS LIST',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              )),
              for (final element in new_list.entries)
                MaterialBox(
                  title: element.value[0],
                  text: element.value[1],
                  num: element.key,
                  by: element.value[2],
                  url: element.value[3],
                )
            ],
          ),
        ))
    );
  }
}

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 128, 46, 40),
            title: const Text('INFO.NOW'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Alert checking',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checking the news..')));
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return Bar_X();
                  }));
                },
              ),
              IconButton(
                  icon: const Icon(Icons.navigate_next),
                  tooltip: 'Enter',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor:
                              const Color.fromARGB(255, 128, 46, 40),
                          title: const Text('INFO.NOW'),
                        ),
                        body: Column(
                          children: [
                            Container(
                              height: 30,
                            ),
                            const Text(
                              'Сейчас вы попали на страницу выбора действий в INFO.NOW. Выберите действие, которое вы хотите выполнить.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                            Container(
                                height: 100,
                                width: 600,
                                margin: const EdgeInsets.only(top: 100.0),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 202, 52, 14),
                                      Color.fromARGB(255, 159, 13, 13),
                                      Color.fromARGB(255, 194, 20, 20),
                                    ],
                                  ),
                                ),
                                child: TextButton(
                                    child: const Text(
                                      "I'd like to ask some question!",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    onPressed: () => {
                                          Navigator.push(context,
                                              MaterialPageRoute<void>(builder:
                                                  (BuildContext context) {
                                            return const Asking();
                                          }))
                                        })),
                            Container(
                                height: 100,
                                width: 600,
                                margin: const EdgeInsets.only(top: 20.0),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 202, 52, 14),
                                      Color.fromARGB(255, 159, 13, 13),
                                      Color.fromARGB(255, 194, 20, 20),
                                    ],
                                  ),
                                ),
                                child: TextButton(
                                    child: const Text(
                                      "I'd like to answer some question!",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    onPressed: () => {
                                          Navigator.push(context,
                                              MaterialPageRoute<void>(builder:
                                                  (BuildContext context) {
                                            return QuestionsBox();
                                          }))
                                        })),
                            Container(
                                height: 100,
                                width: 600,
                                margin: const EdgeInsets.only(top: 20.0),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 202, 52, 14),
                                      Color.fromARGB(255, 159, 13, 13),
                                      Color.fromARGB(255, 194, 20, 20),
                                    ],
                                  ),
                                ),
                                child: TextButton(
                                    child: const Text(
                                      "I'd like to write some info!",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    onPressed: () => {
                                          Navigator.push(context,
                                              MaterialPageRoute<void>(builder:
                                                  (BuildContext context) {
                                            return Writing();
                                          }))
                                        })),
                          ],
                        ),
                      );
                    }));
                  })
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(5.0),
                child: const Text('NEWS LIST',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              )),
              for (final element in new_list.entries)
                MaterialBox(
                  title: element.value[0],
                  text: element.value[1],
                  num: element.key,
                  by: element.value[2],
                  url: element.value[3],
                )
            ],
          ),
        ));
  }
}

class Writing extends StatefulWidget {
  const Writing({Key? key}) : super(key: key);

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          title: const Text(
            'Writing ~ INFO.NOW',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 128, 46, 40),
        ),
        body: Container(
          color: Color.fromARGB(255, 12, 19, 23),
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: h,
                    style: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
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
                              new_list[h.text[0]] = [
                                h.text,
                                info.text,
                                name.text,
                                url.text
                              ];
                              print(new_list);
                            },
                            child: const Text('Submit'))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                }))
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
        appBar: AppBar(
          title: Text('New #$num by $by'),
          backgroundColor: const Color.fromARGB(255, 128, 46, 40),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                height: 300,
                color: const Color.fromARGB(255, 128, 46, 40),
                child: Image.network(url),
              ),
              Container(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ));
  }
}

class Asking extends StatefulWidget {
  const Asking({Key? key}) : super(key: key);

  @override
  State<Asking> createState() => _AskingState();
}

class _AskingState extends State<Asking> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final question = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
    question.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          title: const Text(
            'Asking ~ INFO.NOW',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 128, 46, 40),
        ),
        body: Container(
          color: Color.fromARGB(255, 12, 19, 23),
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: name,
                    style: TextStyle(color: Colors.white),
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
                    controller: question,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: 'Question',
                        helperText: 'Enter your question',
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
                              askings[name.text] = [question.text, false];
                            },
                            child: const Text('Submit'))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionsBox extends StatelessWidget {
  const QuestionsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () => Navigator.pop(context),
              ),
            ],
            title: const Text(
              'Questions ~ INFO.NOW',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 128, 46, 40),
          ),
          body: Container(
              child: Column(
            children: [
              for (final element in askings.entries)
                Question(
                    answer: element.value[1] as bool,
                    question: element.value[0] as String,
                    name: element.key)
            ],
          ))),
    );
  }
}

class Question extends StatelessWidget {
  final String name;
  final String question;
  final bool answer;

  Question({
    required this.name,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Written by $name;'),
          Text('Question is answered: $answer'),
          Text('Question: $question'),
          TextButton(
            child: Text('Answer!'),
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}
