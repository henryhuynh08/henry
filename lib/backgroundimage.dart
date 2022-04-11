import 'dart:math';

class BackgroundImages {
  final _imgList = ['images/wallpaper1.jpg','images/wallpaper2.jpg','images/wallpaper3.jpg','images/wallpaper4.jpg','images/wallpaper5.jpg','images/wallpaper6.jpg','images/wallpaper7.jpg'];
  int _indexNum = 0;
  late String _choseImg;

  int randomIndex() {
    return _indexNum = Random().nextInt(_imgList.length);
  }
  String getImage() => _choseImg = _imgList[_indexNum];
}