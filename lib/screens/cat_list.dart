import 'package:flutter/material.dart';
import 'package:mobile_anwendungen/screens/cat_detail.dart';

int count = 4;

class CatList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CatListState();
  }
}

class CatListState extends State<CatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Cat App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: getCatListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail('Add Cat');
        },
        tooltip: 'Add Cat',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getCatListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.headlineMedium;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.lightGreen,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
            ),
            title: Text(
              'Dummy Title',
              style: titleStyle,
            ),
            subtitle: Text('Dummy Subtitle'),
            trailing: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onTap: () {
              debugPrint('ListTile tapped');
              navigateToDetail('View/Edit Cat Details');
            },
          ),
        );
      },
    );
  }

  void navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CatDetail(title);
    }));
  }
}
