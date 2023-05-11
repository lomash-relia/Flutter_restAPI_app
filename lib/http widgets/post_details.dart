import 'package:flutter/material.dart';
import 'package:http_example/HttpHelper.dart';
import 'package:http_example/http%20widgets/edit_post.dart';

class PostDetails extends StatelessWidget {
  final String itemId;
  late final Future<Map> _postDetails;

  PostDetails({Key? key, required this.itemId}) : super(key: key) {
    _postDetails = HttpHelper().getItem(itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditPost(
                            itemId: itemId,
                          )));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              var status = await HttpHelper().deleteItem(itemId);
              if (status) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post deleted')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Deletion failed')));
              }
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _postDetails,
        builder: (context, snapshot) {
          //check error
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error generated due to ${snapshot.error}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ));
          }
          //check data
          if (snapshot.hasData) {
            var post = snapshot.data!;
            return ListTile(
              title: Text('${post['title']}'),
              subtitle: Text('${post['body']}'),
              trailing: Text('${post['id']}'),
            );
          }
          //show loader
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
