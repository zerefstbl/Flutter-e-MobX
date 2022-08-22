import 'package:flutterlegacy/models/item_mobx.dart';
import 'package:mobx/mobx.dart';

enum TokenKey { xis, oh }

class MobxController {
  MobxController() {
    reveal = Action(_reveal);
    restart = Action(_restart);
    showAlert = Action(_showAlert);
  }

  final ObservableList<ItemMobx> itens = ObservableList<ItemMobx>();

  final Observable<String> alert = Observable('');

  Action? reveal;

  _reveal(int index, TokenKey tokenKey) {
    if (getItemById(index) == null) {
      itens.add(ItemMobx(
        id: index,
        val: _charByToken(tokenKey),
      ));

      if (tokenKey == TokenKey.xis) {
        var avaliable = Iterable<int>.generate(9).toList();
        itens.forEach((element) {
          avaliable.remove(element.id);
        });

        var nextRnd = (avaliable..shuffle()).first;

        Future.delayed(Duration(seconds: 1), () {
          reveal!.call([nextRnd, TokenKey.oh]);
        });
      }

      showAlert!.call(['']);
    } else {
      showAlert!.call(['Escolha outro item...']);
    }
  }

  String _charByToken(TokenKey tokenKey) {
    return tokenKey == TokenKey.xis ? 'X' : 'O';
  }

  Action? restart;

  _restart() {
    itens.clear();
  }

  Action? showAlert;

  _showAlert(String content) {
    alert.value = content;
  }

  ItemMobx? getItemById(int id) {
    try {
      return itens.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
