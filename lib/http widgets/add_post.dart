import 'package:flutter/material.dart';
import 'package:http_example/HttpHelper.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              // TextFormField(
              //   controller: userIdController,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       label: Text(
              //         'User ID',
              //       )),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextFormField(
              //   controller: idController,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       label: Text(
              //         'ID',
              //       )),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      'Title',
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: bodyController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      'Body',
                    )),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, String> newMap = {
                      "title": titleController.text,
                      "body": bodyController.text,
                    };
                    var status = await HttpHelper().addItem(newMap);
                    // print(status);
                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Post added')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed')));
                    }
                  },
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
