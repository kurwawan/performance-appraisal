import 'package:flutter/material.dart';
import 'package:penilaian/research/post_provider.dart';
import 'package:provider/provider.dart';

class ProviderDemoScreen extends StatefulWidget {
  // const ProviderDemoScreen({ Key? key }) : super(key: key);

  @override
  _ProviderDemoScreenState createState() => _ProviderDemoScreenState();
}

class _ProviderDemoScreenState extends State<ProviderDemoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postMdl = Provider.of<PostDataProvider>(context, listen: false);
    postMdl.getPostData(context);
  }

  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<PostDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: postMdl.loading
            ? Container(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      postMdl.post.title ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Text(postMdl.post.body ?? ""),
                  )
                ],
              ),
      ),
    );
  }
}
