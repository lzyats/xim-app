import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:get_storage/get_storage.dart';

class ToolsAes {
  // AES加密模式：CBC（需要IV向量）
  static final _mode = AESMode.cbc;
  // 密钥长度：128位（16字节）
  static const int _keyLength = 16;
  // IV向量长度：16字节（固定）
  static const int _ivLength = 16;

  // 使用get_storage存储密钥
  static final _storage = GetStorage();
  static const _keyStorageKey = 'aes_secure_key';

  /// 初始化存储（建议在main函数中调用）
  static Future<void> initStorage() async {
    await GetStorage.init();
  }

  /// 生成随机密钥（首次使用时调用）
  static Future<Key> generateKey() async {
    final key = Key.fromSecureRandom(_keyLength);
    await _storage.write(_keyStorageKey, base64.encode(key.bytes));
    return key;
  }

  /// 获取存储的密钥
  static Future<Key> getKey() async {
    final keyStr = _storage.read<String>(_keyStorageKey);
    if (keyStr == null || keyStr.isEmpty) {
      return generateKey(); // 首次使用时生成并存储密钥
    }
    return Key.fromBase64(keyStr);
  }

  /// 生成随机IV向量（每次加密都需要新的IV）
  static IV generateIV() {
    return IV.fromSecureRandom(_ivLength);
  }

  /// AES加密
  /// [plainText]：待加密的明文
  /// 返回格式：IV向量(base64) + ':' + 加密后的数据(base64)
  static Future<String> encrypt(String plainText) async {
    final key = await getKey();
    final iv = generateIV();
    final encrypter = Encrypter(AES(key, mode: _mode));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // 将IV和加密数据一起返回（解密时需要相同的IV）
    return '${base64.encode(iv.bytes)}:${encrypted.base64}';
  }

  /// AES解密
  /// [encryptedText]：加密后的字符串（格式：IV:加密数据）
  static Future<String> decrypt(String encryptedText) async {
    try {
      // 拆分IV和加密数据
      final parts = encryptedText.split(':');
      if (parts.length != 2) {
        throw FormatException('加密字符串格式错误');
      }

      final key = await getKey();
      final iv = IV.fromBase64(parts[0]);
      final encrypter = Encrypter(AES(key, mode: _mode));

      final encrypted = Encrypted.fromBase64(parts[1]);
      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw Exception('解密失败：$e');
    }
  }

  /// 清除存储的密钥（用于测试或重置）
  static Future<void> clearKey() async {
    await _storage.remove(_keyStorageKey);
  }
}
