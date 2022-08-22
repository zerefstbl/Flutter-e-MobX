import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterlegacy/models/controller.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mobxController = MobxController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da velha'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text('Mobx - Toque para animar'),
          SizedBox(
            height: 4,
          ),
          Observer(builder: (BuildContext context) {
            return Text(mobxController.alert.value);
          }),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                  9,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        mobxController.reveal!.call([index, TokenKey.xis]);
                      },
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(3),
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(child: Observer(
                          builder: (BuildContext context) {
                            var item = mobxController.getItemById(index);

                            var itemColor = Colors.black;
                            if (item != null) {
                              itemColor = (item.val == 'X')
                                  ? Colors.green
                                  : Colors.blue;
                            }
                            return Text(
                              item != null ? item.val.toString() : '?',
                              style: TextStyle(
                                color: itemColor,
                                fontSize: 40,
                              ),
                            );
                          },
                        )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                mobxController.restart!.call();
              },
              child: Text('Restart'),
            ),
          )
        ],
      ),
    );
  }
}
