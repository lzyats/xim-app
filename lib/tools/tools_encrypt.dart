import 'dart:convert' as convert;

import 'package:crypto/crypto.dart' as crypto_;
import 'package:encrypt/encrypt.dart' as encrypt_;

// 加密工具类
class ToolsEncrypt {
  // md5
  static String md5(String pass) {
    var bytes = convert.utf8.encode(pass);
    var digest = crypto_.md5.convert(bytes);
    return digest.toString();
  }

  // sign
  static String sign(
    String appId,
    String secret,
    String timestamp,
    String path,
  ) {
    String param = ToolsEncrypt.md5(appId + path + timestamp);
    return _hmacMd5(secret, param);
  }

  // hmacMd5
  static String _hmacMd5(String secret, String data) {
    List<int> secretBytes = convert.utf8.encode(secret);
    List<int> dataBytes = convert.utf8.encode(data);
    crypto_.Hmac hmac = crypto_.Hmac(crypto_.md5, secretBytes);
    crypto_.Digest hmacDigest = hmac.convert(dataBytes);
    return hmacDigest.toString();
  }

  // 原AES加密（保持不变）
  static String encrypt(String secret, String data) {
    return _aes(secret).encrypt(data, iv: encrypt_.IV.fromUtf8(secret)).base16;
  }

  // 原AES解密（保持不变）
  static String decrypt(String secret, String data) {
    return _aes(secret).decrypt16(data, iv: encrypt_.IV.fromUtf8(secret));
  }

  // 新增AES-256加密
  static String encryptAes256(String secret, String data) {
    // AES-256需要32字节密钥，这里对密钥进行MD5处理确保长度（或根据实际需求处理）
    final key = encrypt_.Key.fromUtf8(_ensure32Bytes(secret));
    final iv = encrypt_.IV.fromLength(16); // CBC模式需要16字节IV
    final encrypter =
        encrypt_.Encrypter(encrypt_.AES(key, mode: encrypt_.AESMode.cbc));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return '${iv.base64}:${encrypted.base64}'; // 拼接IV和密文，解密时需要
  }

  // 新增AES-256解密
  static String decryptAes256(String secret, String data) {
    try {
      final parts = data.split(':');
      if (parts.length != 2) throw Exception('Invalid encrypted data format');

      final key = encrypt_.Key.fromUtf8(_ensure32Bytes(secret));
      final iv = encrypt_.IV.fromBase64(parts[0]);
      final encrypter =
          encrypt_.Encrypter(encrypt_.AES(key, mode: encrypt_.AESMode.cbc));
      return encrypter.decrypt64(parts[1], iv: iv);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  // 确保密钥为32字节（AES-256要求）
  static String _ensure32Bytes(String secret) {
    if (secret.length >= 32) {
      return secret.substring(0, 32);
    } else {
      // 不足32字节则用MD5哈希补足（或根据实际业务需求处理）
      final md5Hash = md5(secret);
      return (secret + md5Hash).substring(0, 32);
    }
  }

  // 原AES配置（保持不变）
  static encrypt_.Encrypter _aes(String secret) {
    return encrypt_.Encrypter(encrypt_.AES(
      encrypt_.Key.fromUtf8(secret),
      mode: encrypt_.AESMode.cbc,
    ));
  }
}
