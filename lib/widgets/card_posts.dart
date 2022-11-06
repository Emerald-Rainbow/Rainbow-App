import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rainbow/screens/screen_post.dart';

class CardsPost extends StatefulWidget {
  const CardsPost({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardsPostState createState() => _CardsPostState();
}

class _CardsPostState extends State<CardsPost> {
  bool pressAttention = false;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection("blogs")
      .orderBy("createdAt", descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return SingleChildScrollView(
          child: Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                semanticContainer: true,
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        gotoPostPage(context, data['title'], data['author'],
                            data['content']);
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${data['authorPic']}'),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 7, bottom: 7),
                        child: Text(
                          '${data['title']}',
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Text(
                          '${data['author']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => gotoPostPage(context, data['title'],
                          data['author'], data['content']),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 7),
                        child: InkWell(
                          onTap: () => gotoPostPage(context, data['title'],
                              data['author'], data['content']),
                          child: SizedBox(
                            height: checkheight(data['content']),
                            child: InkWell(
                              onTap: () => gotoPostPage(context, data['title'],
                                  data['author'], data['content']),
                              child: Html(
                                data: '${data['content']}',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => gotoPostPage(context, data['title'],
                          data['author'], data['content']),
                      child: const Padding(
                        padding: EdgeInsets.all(7),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                        ),
                        IconButton(
                            onPressed: () => setState(
                                () => pressAttention = !pressAttention),
                            icon: pressAttention
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border)),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

void gotoPostPage(context, title, author, content) {
  getdata(title, author, content);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ScreenPost()));
}

double? checkheight(String content) {
  if (content.length >= 500) return 180.0;
  return null;
}
