import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb_flutter/models/user.dart';

import '../utils/constants.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(
        "mongodb+srv://andrewmanteza21:1UDejNyGIB0jWafB@cluster0.jre2j.mongodb.net/forhero?retryWrites=true&w=majority");
    await db.open();
    userCollection = db.collection("books");
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final users = await userCollection.find().toList();
      return users;
    } catch (e) {
      print(e);
      return Future.value(e);
    }
  }

  static insert(User user) async {
    await userCollection.insertAll([user.toMap()]);
  }

  static update(User user) async {
    var u = await userCollection.findOne({"_id": user.id});
    u["bookName"] = user.bookName;
    u["bookPrice"] = user.bookPrice;
    u["bookAuthor"] = user.bookAuthor;
    u["bookCategory"] = user.bookCategory;
    await userCollection.save(u);
  }

  static delete(User user) async {
    await userCollection.remove(where.id(user.id));
  }
}
