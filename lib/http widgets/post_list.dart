import 'package:flutter/material.dart';
import 'package:http_example/HttpHelper.dart';
import 'package:http_example/http%20widgets/add_post.dart';
import 'package:http_example/http%20widgets/post_details.dart';

class PostsList extends StatelessWidget {
  PostsList({Key? key}) : super(key: key);

  final _futurePosts = HttpHelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('list of posts'),
      ),
      body: FutureBuilder(
        future: _futurePosts,
        builder: (context, snapshot) {
          //check for errors
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error generated due to ${snapshot.error}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ));
          }
          //has data arrived
          if (snapshot.hasData) {
            var posts = snapshot.data;
            return ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                Map thisItem = posts[index];
                return ListTile(
                  title: Text('${thisItem['title']}'),
                  subtitle: Text('${thisItem['body']}'),
                  trailing: Text('${thisItem['id']}'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostDetails(
                                  itemId: '${thisItem['id']}',
                                )));
                  },
                );
              },
            );
          }
          //display a loader
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
