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

  static String encrypt(String secret, String data) {
    return _aes(secret).encrypt(data, iv: encrypt_.IV.fromUtf8(secret)).base16;
  }

  static String decrypt(String secret, String data) {
    return _aes(secret).decrypt16(data, iv: encrypt_.IV.fromUtf8(secret));
  }

  // aes
  static encrypt_.Encrypter _aes(String secret) {
    return encrypt_.Encrypter(encrypt_.AES(
      encrypt_.Key.fromUtf8(secret),
      mode: encrypt_.AESMode.cbc,
    ));
  }
}
