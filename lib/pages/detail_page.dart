import 'package:flutter/material.dart';
import 'package:herewego2/model/post_model.dart';
import 'package:herewego2/services/prefs_service.dart';
import 'package:herewego2/services/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = "detail_page";

  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async {
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if (title.isEmpty || content.isEmpty) return;
    _apiAddPost(title, content);
  }

  _apiAddPost(String title, String content) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(Post(id!, title, content)).then((value) => {
          _respAddPost(),
        });
  }

  _respAddPost() {
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: 'Content'),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  onPressed: () {
                    _addPost();
                  },
                  color: Colors.red,
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
