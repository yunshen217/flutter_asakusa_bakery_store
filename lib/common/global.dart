import 'package:flutter/material.dart';

import '../model/UserModel.dart';
import 'constant.dart';
import 'package:sp_util/sp_util.dart';

///グローバル変数
class Global {
  Global._();

  //全局TOKEN
  static String get token => SpUtil.getString(Constant.TOKEN, defValue: "")!;

  static putToken(token) => SpUtil.putString(Constant.TOKEN, token)!;

  //全体エンティティ   start
  static UserModel? get userInfo => SpUtil.getObj(Constant.USER_MODEL, (v) => UserModel.fromJson(v),
      defValue: UserModel(userName: "ログイン", userId: ""));

  static Future<void> putUserInfo(dynamic user) async {
  try {
    print("ユーザー情報の保存を開始しています...");
    bool success = await SpUtil.putObject(Constant.USER_MODEL, user) ?? false;
    if (success) {
      print("ユーザー情報が保存されました： ${user}");
    } else {
      print("ユーザー情報の保存に失敗しました");
    }
  } catch (e) {
    print("ユーザー情報の保存に失敗しました: $e");
  }
}

  //语言 END
  //全局context
  static BuildContext? context;

  //全局初期化 キャッシュ
  static Future init() async {
    await SpUtil.getInstance();
  }

  //保存された記録を削除する
  static Future clear() async {
    await SpUtil.remove(Constant.TOKEN);
    await SpUtil.remove(Constant.USER_MODEL);
    if (SpUtil.haveKey(Constant.TOKEN)!) await SpUtil.remove(Constant.TOKEN);
  }
}
