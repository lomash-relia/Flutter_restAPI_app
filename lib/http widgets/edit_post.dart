import 'package:flutter/material.dart';
import 'package:http_example/HttpHelper.dart';

class EditPost extends StatefulWidget {
  final String itemId;

  const EditPost({Key? key, required this.itemId}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
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
                    Map dataToUpdate = {
                      "title": titleController.text,
                      "body": bodyController.text,
                    };
                    // print(widget.itemId);
                    // print(titleController.text);
                    // print(bodyController.text);

                    var status = await HttpHelper()
                        .updateItem(dataToUpdate, widget.itemId.toString());

                    //print(status);
                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Post updates')));
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
