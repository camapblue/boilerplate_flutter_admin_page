import 'dart:convert';

import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:repository/model/entity.dart';
import 'package:repository/model/mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseDao<T extends Entity> {
  final Mapper<T> _mapper;
  final SharedPreferences prefs;
  int lastUpdatedTime = 0;
  int expiredTimeInMinute;

  BaseDao({
    Mapper<T> mapper,
    @required this.prefs,
    this.expiredTimeInMinute = 5,
  }) : _mapper = mapper;

  Future<void> saveList(List<T> list, String key, {DateTime now}) async {
    await prefs.setString(
        key, json.encode(list.map((i) => i.toJson()).toList()));

    final time = now ?? DateTime.now();
    lastUpdatedTime = time.millisecondsSinceEpoch;
    await prefs.setInt(_lastUpdatedKey, lastUpdatedTime);
  }

  List<T> getList(String key) {
    if (_mapper == null || _isExpired()) {
      return null;
    }

    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      try {
        final dic = List<Map<String, dynamic>>.from(json.decode(jsonString));
        final items = dic.map(_mapper.parse).toList();
        return items;
      } catch (e) {
        log.error('Get List $key parse json ${T.toString()} error: $e');
      }
    }

    return null;
  }

  Future<void> saveMap(Map<String, T> map, String key) async {
    final mapped = map.map((key, value) => MapEntry(key, value.toJson()));

    await prefs.setString(key, json.encode(mapped));
  }

  Map<String, T> getMap(String key) {
    if (_mapper == null) {
      return null;
    }

    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      try {
        final dic = Map<String, dynamic>.from(json.decode(jsonString));

        return dic.map((key, value) => MapEntry(key, _mapper.parse(value)));
      } catch (e) {
        log.error('Get Map $key parse json ${T.toString()} error: $e');
      }
    }

    return null;
  }

  bool _isExpired() {
    final lastUpdatedTimeStamp = lastUpdated();
    final passedTime = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastUpdatedTimeStamp))
        .inMinutes;

    if (passedTime > expiredTimeInMinute) {
      return true;
    }

    return false;
  }

  bool _isExpiredWithKey(String key, {int expiredTime}) {
    final lastUpdatedTimeStamp = prefs.getInt(key) ?? 0;

    final passedTime = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastUpdatedTimeStamp))
        .inMinutes;

    if (passedTime > expiredTime) {
      return true;
    }

    return false;
  }

  Future<void> clearList(String key) async {
    await prefs.remove(key);
    await prefs.remove(_lastUpdatedKey);
  }

  Future<void> clearAllKeysMatchPrefix(String prefix) async {
    final allKeys = prefs.getKeys();

    final removingKeys = <String>[];
    for (final key in allKeys) {
      if (key.startsWith(prefix)) {
        removingKeys.add(key);
      }
    }
    if (removingKeys.isEmpty) {
      return;
    }
    await Future.wait(removingKeys.map(prefs.remove));
  }

  Future<void> saveItem(T item, String key) async {
    await prefs.setString(key, json.encode(item.toJson()));
  }

  T getItem(String key) {
    if (_mapper == null) {
      return null;
    }

    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final dic = Map<String, dynamic>.from(json.decode(jsonString));
      if (dic.isEmpty) {
        return null;
      }
      return _mapper.parse(dic);
    }

    return null;
  }

  Future<void> clearObjectOrEntity(String key) async {
    await prefs.remove(key);
  }

  Future<void> saveEntity<S extends Entity>(S entity, String key) async {
    await prefs.setString(key, json.encode(entity.toJson()));
  }

  S getEntity<S extends Entity>(String key, {@required Mapper<S> mapper}) {
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final dic = Map<String, dynamic>.from(json.decode(jsonString));
      if (dic.isEmpty) {
        return null;
      }
      return mapper.parse(dic);
    }

    return null;
  }

  Future<void> saveString(String value, String key) async {
    await prefs.setString(key, value);
  }

  String getString(String key) {
    return prefs.getString(key);
  }

  Future<void> saveInteger(int value, String key, {int expiredTime}) async {
    if (expiredTime != null) {
      lastUpdatedTime = DateTime.now().millisecondsSinceEpoch;
      await prefs.setInt('${key}_last_updated', lastUpdatedTime);
    }

    await prefs.setInt(key, value);
  }

  Future<void> saveBoolean(bool value, String key) async {
    await prefs.setBool(key, value);
  }

  int getInteger(String key, {int expiredTime}) {
    if (expiredTime != null) {
      if (_isExpiredWithKey('${key}_last_updated', expiredTime: expiredTime)) {
        // ignore: avoid_returning_null
        return null;
      }
    }
    
    return prefs.getInt(key);
  }

  bool getBoolean(String key) {
    return prefs.getBool(key);
  }

  @override
  String toString() {
    return 'BaseDao';
  }

  String get _lastUpdatedKey => 'key_${toString()}_last_update';

  int lastUpdated() {
    if (lastUpdatedTime != null && lastUpdatedTime > 0) {
      return lastUpdatedTime;
    }

    lastUpdatedTime = prefs.getInt(_lastUpdatedKey);

    return lastUpdatedTime ?? 0;
  }
}
