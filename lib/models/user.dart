import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String bookName;
  final int bookPrice;
  final String bookAuthor;
  final String bookCategory;

  const User(
      {this.id,
      this.bookName,
      this.bookPrice,
      this.bookAuthor,
      this.bookCategory});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'bookName': bookName,
      'bookPrice': bookPrice,
      'bookAuthor': bookAuthor,
      'bookCategory': bookAuthor,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : bookName = map['bookName'],
        id = map['_id'],
        bookPrice = map['bookPrice'],
        bookAuthor = map['bookAuthor'],
        bookCategory = map['bookCategory'];
}
