import 'package:flutter/material.dart';

class CatDetail extends StatefulWidget {
  String appBarTitle;
  CatDetail(this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return CatDetailState(this.appBarTitle);
  }
}

class CatDetailState extends State<CatDetail> {
  String appBarTitle;

  TextEditingController nameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController temperamentController = TextEditingController();
  TextEditingController originController = TextEditingController();
  TextEditingController expectedAgeController = TextEditingController();

  CatDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Image(
              image: NetworkImage(
                  'https://cdn2.thecatapi.com/images/8D--jCd21.jpg'),
              alignment: Alignment.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Name field was edited');
                },
                decoration: InputDecoration(
                    labelText: 'Breed',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: breedController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Text field was edited');
                },
                decoration: InputDecoration(
                    labelText: 'Breed',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: temperamentController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Text field was edited');
                },
                decoration: InputDecoration(
                    labelText: 'Temperament',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: originController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Text field was edited');
                },
                decoration: InputDecoration(
                    labelText: 'Origin',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: expectedAgeController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Text field was edited');
                },
                decoration: InputDecoration(
                    labelText: 'Expected Age',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save'),
                  )),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Delete'),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
