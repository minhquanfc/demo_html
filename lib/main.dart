import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String url = "https://www.youtube.com/@houselak1592";
  late String _htmlData;
  String content = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchHtmlData(url);
  }
  Future<void> _fetchHtmlData(String url) async {
    final response = await http.get(Uri.parse(url));
    final document = parse(response.body);
    final element = document.querySelector('meta[itemprop="identifier"]');
    content = element?.innerHtml ?? '';
    print(content);

    String requiresSubscription = element?.attributes['content'] ?? '';
    print('requiresSubscription: '+requiresSubscription);

    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Html(data: content,),
      ),
    );
  }
}
