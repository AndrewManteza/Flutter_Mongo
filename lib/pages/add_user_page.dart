import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb_flutter/database/database.dart';
import 'package:mongodb_flutter/models/user.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();
  TextEditingController bookPriceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    bookNameController.dispose();
    bookAuthorController.dispose();
    bookPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    var widgetText = 'Add Book';
    if (user != null) {
      bookNameController.text = user.bookName;
      bookAuthorController.text = user.bookAuthor.toString();
      bookPriceController.text = user.bookPrice.toString();
      widgetText = 'Update Book';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widgetText),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bookNameController,
                    decoration: InputDecoration(labelText: 'bookName'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bookAuthorController,
                    decoration: InputDecoration(labelText: 'bookAuthor'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: bookPriceController,
                    decoration: InputDecoration(labelText: 'bookPrice'),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
              child: ElevatedButton(
                child: Text(widgetText),
                onPressed: () {
                  if (user != null) {
                    updateUser(user);
                  } else {
                    insertUser();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  insertUser() async {
    final user = User(
      id: M.ObjectId(),
      bookName: bookNameController.text,
      bookAuthor: bookAuthorController.text,
      bookPrice: int.parse(bookPriceController.text),
    );
    await MongoDatabase.insert(user);
    Navigator.pop(context);
  }

  updateUser(User user) async {
    print('updating: ${bookNameController.text}');
    final u = User(
      id: user.id,
      bookName: bookNameController.text,
      bookAuthor: bookAuthorController.text,
      bookPrice: int.parse(bookPriceController.text),
    );
    await MongoDatabase.update(u);
    Navigator.pop(context);
  }
}
