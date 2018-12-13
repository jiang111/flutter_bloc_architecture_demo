import 'package:bloc_arch/model/SearchModel.dart';
import 'package:bloc_arch/model/item_model.dart';
import 'package:flutter/material.dart';
import 'bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  BlocProvider _blocProvider = BlocProvider.newInstance();

  @override
  void initState() {
    super.initState();
    _blocProvider.fetchQueryList();
  }

  @override
  void dispose() {
    _blocProvider.dispose();
    super.dispose();
  }

  void finished() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Sample"),
      ),
      body: buildBody(),
    );
  }

  Widget buildData() {
    return _blocProvider.streamBuilder<SearchModel>(
        success: (data) {
          return buildList(data);
        },
        error: (msg) {
          return Container(
            child: Center(
              child: Text(msg),
            ),
          );
        },
        empty: () {
          return Container(
            child: Center(
              child: Text("暂无数据"),
            ),
          );
        },
        loading: () {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        finished: finished);
  }

  Widget buildList(SearchModel data) {
    return ListView.builder(
      itemCount: data.items.length,
      itemBuilder: (context, index) {
        ItemModel itemModel = data.items[index];
        return InkWell(
          onTap: () {},
          child: Card(
            margin: EdgeInsets.only(
              left: 15.0,
              top: 15.0,
              right: 15.0,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 10.0,
                  ),
                  child: Text(itemModel.name,
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 18.0,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Text(
                    itemModel.description,
                    style: TextStyle(
                      color: Color(0xff9b9b9b),
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                        ),
                        child: Text("size:${itemModel.size}",
                            style: TextStyle(
                              color: Color(0xff9b9b9b),
                              fontSize: 14.0,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                        ),
                        child: Text("forks:${itemModel.forks}",
                            style: TextStyle(
                              color: Color(0xff9b9b9b),
                              fontSize: 14.0,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBody() {
    return buildData();
  }
}
