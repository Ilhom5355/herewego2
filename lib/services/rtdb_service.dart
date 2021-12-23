import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:herewego2/model/post_model.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.reference();

  // Serverga ma`lumotlarni qo`shish database orqali

  static Future<Stream> addPost(Post post) async {
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  // Serverdan ma`lumotlarni olish database orqali
  static Future<List<Post>> getPosts(String id) async {
    List<Post> items = [];

    Query _query =
        _database.ref.child("posts").orderByChild('userId').equalTo(id);
    var snapshot = await _query.once();

    var result = snapshot.previousChildKey as Iterable;

    for (var item in result) {
      items.add(Post.fromJson(Map<String, dynamic>.from(item)));
    }
    return items;
  }
}
