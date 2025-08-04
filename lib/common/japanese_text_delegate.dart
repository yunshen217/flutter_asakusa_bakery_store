import 'package:wechat_assets_picker/wechat_assets_picker.dart';
/// Image selection in Japanese
class JapaneseTextDelegate extends AssetPickerTextDelegate {
  @override
  String get languageCode => 'ja';

  @override
  String get confirm => '完了';

  @override
  String get cancel => 'キャンセル';

  @override
  String get select => '選択';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get unSelectAll => 'すべて解除';

  @override
  String get loadingFailed => '読み込みに失敗しました';

  @override
  String get preview => 'プレビュー';

  @override
  String get notSelectAny => '画像が選択されていません';

  @override
  String get unableToAccessAll => 'すべての画像にアクセスできません';

  @override
  String get accessAllTip =>
      'すべての画像にアクセスするには「すべての画像を許可」を選択してください';

  @override
  String get goToSystemSettings => '設定へ移動';

  @override
  String get accessLimitedAssets => '一部の画像にのみアクセス中';

  @override
  String get accessiblePathName => 'アルバム';

  @override
  String get sUnitAssetCountLabel => '件';
}