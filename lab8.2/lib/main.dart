import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Модель для новости
class News {
  final int id;
  final String title;
  final String body;
  final String date;
  final String imageUrl;

  const News({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      date: json['date'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}

// Получение списка новостей с сервера КубГАУ
Future<List<News>> fetchNews(http.Client client) async {
  final response = await client.get(Uri.parse('https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));

  if (response.statusCode == 200) {
    return parseNews(response.body);
  } else {
    throw Exception('Ошибка загрузки новостей');
  }
}

// Парсинг JSON в объекты News
List<News> parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<News>((json) => News.fromJson(json)).toList();
}

// Главный экран приложения
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новостная лента КубГАУ'),
      ),
      body: FutureBuilder<List<News>>(
        future: fetchNews(http.Client()), // Загружаем новости с API КубГАУ
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки данных!'));
          } else if (snapshot.hasData) {
            return NewsList(newsList: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// Виджет для отображения списка новостей
class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.newsList}) : super(key: key);
  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Image.network(news.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
            title: Text(news.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(news.body),
            trailing: Text(news.date),
            onTap: () {
              // Навигация к детальной странице новости (если нужно)
            },
          ),
        );
      },
    );
  }
}

// Основная функция запуска приложения
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Новостная лента КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
