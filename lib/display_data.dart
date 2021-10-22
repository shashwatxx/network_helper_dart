import 'package:flutter/material.dart';
import 'package:network_trial/model/posts.dart';
import 'package:network_trial/network_helper.dart';

class ShowDataPage extends StatefulWidget {
  const ShowDataPage({Key? key}) : super(key: key);

  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  
  getData() async {
    final data =
        await NetworkUtil.getData("https://jsonplaceholder.typicode.com/posts");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data from json Placeholder"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, index) {
              final post = PostsModel.fromMap(snapshot.data[index]);
              return Column(
                children: [
                  ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    leading: Text(
                      post.id.toString(),
                    ),
                    trailing: Text(
                      "User${post.userId}",
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
