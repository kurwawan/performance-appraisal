import 'package:flutter/material.dart';
import 'package:penilaian/research/post_model.dart';
import 'package:provider/provider.dart';

class PostDataProvider with ChangeNotifier {
  PostModel post = PostModel();
  bool loading = false;

  getPostData(context) async {
    loading = true;
    post = await getSinglePostData(context);
    loading = false;

    notifyListeners();
  }
}
