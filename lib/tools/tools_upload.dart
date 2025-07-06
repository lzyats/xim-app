import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:video_compress/video_compress.dart';

// 文件上传
class ToolsUpload {
  // 压缩上传
  static Future<String> uploadVideo(
    String path,
  ) async {
    // 持续等待
    while (VideoCompress.isCompressing) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    await VideoCompress.setLogLevel(0);
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.HighestQuality, //高清
      deleteOrigin: false,
      includeAudio: true,
      frameRate: 5, //每秒视频帧数，默认是30，影响视屏大小，一般看不出来
    );
    return await uploadFile(mediaInfo!.path!);
  }

  // 文件上传
  static Future<String> uploadFile(String path) async {
    // 转换文件
    MultipartFile multipartFile = MultipartFile.fromFileSync(path);
    // 执行上传
    return await _upload(multipartFile);
  }

  // 文件上传
  static Future<List<String>> uploadFileList(List<String> pathList) async {
    List<String> dataList = [];
    if (pathList.isEmpty) {
      return dataList;
    }
    // 执行上传
    for (var path in pathList) {
      String value = await uploadFile(path);
      dataList.add(value);
    }
    return dataList;
  }

  // 文件上传
  static Future<String> uploadBytesData(Uint8List? bytes) async {
    if (bytes == null) {
      return AppConfig.thumbnail;
    }
    MultipartFile multipartFile = MultipartFile.fromBytes(bytes);
    // 执行上传
    return await _upload(multipartFile);
  }

  // 执行上传
  static Future<String> _upload(MultipartFile multipartFile) async {
    // 获取token
    Map<String, dynamic> uploadToken = await RequestCommon.getUploadToken();
    // 上传方式
    String uploadType = uploadToken['uploadType'];
    // 文件上传
    switch (uploadType) {
      // 七牛上传
      case 'kodo':
        return await _kodo(multipartFile, uploadToken);
      // 腾讯上传
      case 'cos':
        return await _cos(multipartFile, uploadToken);
      // 阿里上传
      case 'oss':
        return await _oss(multipartFile, uploadToken);
      // 本地上传
      default:
        return await _local(multipartFile);
    }
  }

  // 本地上传
  static Future<String> _local(MultipartFile multipartFile) async {
    // 文件上传
    return await RequestCommon.upload(multipartFile);
  }

  // 七牛上传
  static Future<String> _kodo(
    MultipartFile multipartFile,
    Map<String, dynamic> uploadToken,
  ) async {
    String fileKey = uploadToken['fileKey'];
    String filePath = uploadToken['filePath'];
    String fileToken = uploadToken['fileToken'];
    String serverUrl = uploadToken['serverUrl'];
    BaseOptions options = BaseOptions(
      headers: {
        "Content-Length": multipartFile.length,
        'Content-Type': 'application/octet-stream',
      },
      connectTimeout: const Duration(seconds: 30),
    );
    Dio dio = Dio(options);
    FormData data = FormData.fromMap(
      {
        "token": fileToken,
        "key": fileKey,
        "contentType": "multipart/form-data",
        "file": multipartFile,
      },
    );
    try {
      await dio.post(
        serverUrl,
        data: data,
      );
    } catch (error) {
      EasyLoading.showToast('上传失败，请稍后重试');
      return '';
    }
    return filePath;
  }

  // 腾讯上传
  static Future<String> _cos(
    MultipartFile multipartFile,
    Map<String, dynamic> uploadToken,
  ) async {
    String serverUrl = uploadToken['serverUrl'];
    String filePath = uploadToken['filePath'];
    BaseOptions options = BaseOptions(
      headers: {
        'Content-Length': multipartFile.length,
        'Content-Type': 'application/octet-stream',
      },
      connectTimeout: const Duration(seconds: 30),
    );
    Dio dio = Dio(options);
    try {
      await dio.put(
        serverUrl,
        data: multipartFile.finalize(),
      );
    } catch (error) {
      EasyLoading.showToast('上传失败，请稍后重试');
      return '';
    }
    return filePath;
  }

  // 阿里上传
  static Future<String> _oss(
    MultipartFile multipartFile,
    Map<String, dynamic> uploadToken,
  ) async {
    String signature = uploadToken['signature'];
    String policy = uploadToken['policy'];
    String accessKey = uploadToken['accessKey'];
    String fileKey = uploadToken['fileKey'];
    String filePath = uploadToken['filePath'];
    String serverUrl = uploadToken['serverUrl'];
    BaseOptions options = BaseOptions(
      headers: {
        'Content-Length': multipartFile.length,
        'Content-Type': 'application/octet-stream',
      },
      connectTimeout: const Duration(seconds: 30),
    );
    FormData data = FormData.fromMap(
      {
        "key": fileKey,
        "policy": policy,
        "OSSAccessKeyId": accessKey,
        "success_action_status": "200", //让服务端返回200，不然，默认会返回204
        "signature": signature,
        "contentType": "multipart/form-data",
        "file": multipartFile,
      },
    );

    Dio dio = Dio(options);
    try {
      await dio.post(
        serverUrl,
        data: data,
      );
    } catch (error) {
      EasyLoading.showToast('上传失败，请稍后重试');
      return '';
    }
    return filePath;
  }
}
