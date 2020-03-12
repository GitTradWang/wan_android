import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/cache.dart';

class CacheManager {
  static CacheManager _instance;

  static CacheManager get instance {
    if (_instance == null) {
      _instance = CacheManager._();
    }
    return _instance;
  }

  _DiskCacheStore _diskCache;
  _MemoryCacheStore _memoryCache;

  CacheManager._() {
    _diskCache = _DiskCacheStore();
    _memoryCache = _MemoryCacheStore();
  }

  ///获取缓存 [key] 缓存的Key [duration] 缓存的时间 [subKey] 区分缓存的额外参数
  Future<String> getCache(String key, {Duration duration, String subKey}) async {
    String _key = _convertMd5('${key}_$subKey');
    String memoryData = await _memoryCache.getCache(_key);
    if (memoryData == null) {
      String data = await _diskCache.getCache(_key, duration);
      _memoryCache.setCache(data, key);
      return data;
    } else {
      return memoryData;
    }
  }

  ///设置缓存 [key] 缓存名称 [subKey] 区分缓存的额外参数
  ///[forever] 默认存储在可移除缓存路径中，用户可以通过设置来清除这部分缓存 若不能被移除请设置为true
  Future<void> setCache(String key, String value, {String subKey, bool forever = false}) async {
    String _key = _convertMd5('${key}_$subKey');
    _memoryCache.setCache(_key, value);
    _diskCache.setCache(_key, value, forever);
  }

  ///删除缓存 [key] 缓存名称 [subKey] 区分缓存的额外参数
  Future<void> delete(String key, {String subKey}) async {
    String md5 = _convertMd5('${key}_$subKey');
    _diskCache.delete(md5);
    _memoryCache.delete(md5);
  }

  ///清除所有缓存
  Future<void> clearAll() async {
    _diskCache.clearAll();
    _memoryCache.clearAll();
  }

  ///缓存名转换MD5
  String _convertMd5(String str) {
    return md5.convert(Utf8Encoder().convert(str)).toString();
  }
}

class _DiskCacheStore {
  static const String FLUTTER = "flutter";

  _DiskCacheStore();

  Future<void> clearAll() async {
    var cacheDirectory = await _getCacheDirectory();
    var cache = Directory('${cacheDirectory.path}/$FLUTTER');
    if (cache.existsSync()) {
      cache.deleteSync(recursive: true);
    }
    var dataDirectory = await _getDataDirectory();
    var data = Directory('${dataDirectory.path}/$FLUTTER');
    if (data.existsSync()) {
      data.deleteSync(recursive: true);
    }
  }

  Future<void> delete(String key) async {
    var file = await _getExistsCacheFile(key);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  ///获取用户可以手动清除的缓存路径
  Future<Directory> _getCacheDirectory() async {
    Directory cacheDirectory = await getTemporaryDirectory();
    var directory = Directory('${cacheDirectory.path}/$FLUTTER');
    if (!directory.existsSync()) {
      directory.createSync();
    }
    return cacheDirectory;
  }

  ///获取用户不能手动清除的缓存路径
  Future<Directory> _getDataDirectory() async {
    Directory cacheDirectory = await getApplicationDocumentsDirectory();
    var directory = Directory('${cacheDirectory.path}/$FLUTTER');
    if (!directory.existsSync()) {
      directory.createSync();
    }
    return cacheDirectory;
  }

  Future<String> getCache(String key, Duration duration) async {
    File file = await _getExistsCacheFile(key);

    if (!file.existsSync()) return null;

    if (duration == null) return file.readAsStringSync();

    int modifiedTime = file.lastModifiedSync().millisecondsSinceEpoch;

    var nowTime = DateTime.now().millisecondsSinceEpoch;

    var durationTime = duration.inMilliseconds;

    if (nowTime - modifiedTime > durationTime) {
      return null;
    }
    return file.readAsStringSync();
  }

  void setCache(String key, String value, bool forever) async {
    var file = await _createCacheFile(key, forever);
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsStringSync(value, flush: true);
  }

  Future<File> _getFileByKey(String key, Directory directory) async {
    return File('${directory.path}/$FLUTTER/$key');
  }

  Future<File> _createCacheFile(String key, bool forever) async {
    File file;
    if (forever) {
      file = await _getFileByKey(key, (await _getDataDirectory()));
    } else {
      file = await _getFileByKey(key, (await _getCacheDirectory()));
    }
    return file;
  }

  Future<File> _getExistsCacheFile(String key) async {
    File file;
    file = await _getFileByKey(key, (await _getCacheDirectory()));
    if (!file.existsSync()) {
      file = await _getFileByKey(key, (await _getDataDirectory()));
    }
    return file;
  }
}

class _MemoryCacheStore {
  MapCache<String, String> _mapCache;

  _MemoryCacheStore() {
    _initMap();
  }

  _initMap() => _mapCache = MapCache.lru(maximumSize: 100);

  Future<String> getCache(String key) async {
    String data = await _mapCache.get('$key');
    return data;
  }

  void setCache(String key, String value) {
    _mapCache.set(key, value);
  }

  void delete(String key) => _mapCache.invalidate('$key');

  void clearAll() {
    _mapCache = null;
    _initMap();
  }
}
