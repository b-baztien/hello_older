import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class PreferenceSettings {
  static StreamingSharedPreferences _steamPreferences;
  static SharedPreferences _preferences;

  static String _nameKey = 'name';
  static String _firstTimeKey = 'first_time';
  static String _preTestScoreKey = 'pre-test_score';
  static String _postTestedKey = 'post-tested';
  static String _readContentIdKey = 'read_content_id';

  PreferenceSettings() {
    initPreference();
  }

  static Future initPreference() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    if (_steamPreferences == null) {
      _steamPreferences = await StreamingSharedPreferences.instance;
    }
  }

  static Preference<String> getUserNameStream() {
    return _steamPreferences.getString(_nameKey, defaultValue: '');
  }

  static void setUserNameStream(String _name) {
    _steamPreferences.setString(_nameKey, _name);
  }

  static bool getFirstTime() {
    bool isFirstTimeExam = _preferences.getBool(_firstTimeKey);
    return isFirstTimeExam != null ? isFirstTimeExam : true;
  }

  static void setFirstTime(bool _firstTime) {
    _preferences.setBool(_firstTimeKey, _firstTime);
  }

  static int getPretestScore() {
    return _preferences.getInt(_preTestScoreKey);
  }

  static void setPretestScore(int _score) {
    _preferences.setInt(_preTestScoreKey, _score);
  }

  static bool getPostTested() {
    bool isPostTest = _preferences.getBool(_postTestedKey);
    return isPostTest;
  }

  static void setPostTested(bool _postTested) {
    _preferences.setBool(_postTestedKey, _postTested);
  }

  static Preference<List<String>> getReadContentSteam() {
    return _steamPreferences.getStringList(_readContentIdKey, defaultValue: []);
  }

  static setReadContent(List<String> _listReadIdContent) {
    _steamPreferences.setStringList(_readContentIdKey, _listReadIdContent);
  }
}
