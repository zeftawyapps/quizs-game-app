import 'package:audioplayers/audioplayers.dart';

class PlaySound {
  String playcurrect = "audio/currect.mp3";
  String playclick = "audio/click.mp3";
  String playwrang = "audio/wrong.mp3";
  String _win = "audio/wingame.mp3";
  String _winMony = "audio/getmony.mp3";
  String playpay = "audio/casher.mp3";

  String _start = "audio/newGame.mp3";
  String _loss = "audio/gamiover.mp3";
  String _helpAdd = "audio/haddtime.mp3";
  String _helpCurrect = "audio/hcurrect.mp3";

  final clickAudio = AudioPlayer();
  final wrongAudio = AudioPlayer();
  final currectAudio = AudioPlayer();
  final winAudio = AudioPlayer();
  Future play(String playUrl)async{


  await   clickAudio.play(AssetSource(playUrl));


  }
  Future playClick() async {
    await clickAudio.play(AssetSource(playclick));
  }

  Future playWrong() async {
    await clickAudio.play(AssetSource(playwrang));
  }

  Future playCurrect() async {
    await currectAudio.play(AssetSource(playcurrect));
  }

  Future playwin() async {
    await currectAudio.play(AssetSource(_win));
  }

  Future playwinMomy() async {
    await currectAudio.play( AssetSource(_winMony));
  }

  Future playloss() async {
      await currectAudio.play(AssetSource(_loss));
  }

  Future playhelpAdd() async {
    await currectAudio.play(AssetSource(_helpAdd));
  }

  Future playhelpcurrec() async {
    await currectAudio.play(AssetSource(_helpCurrect));
  }

  Future playStart() async {
    await currectAudio.play(AssetSource(_start));
  }

  Future playPayment() async {
    await currectAudio.play(AssetSource(playpay));
  }
}