import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:video_compress/video_compress.dart';
import 'package:intl/intl.dart';

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
    print('上传信息：' + uploadToken.toString());
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
      // 阿里上传
      //case 'minio':
      //  return await _minio(multipartFile, uploadToken);
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
    } on DioException catch (e) {
      String errorMsg = '上传失败，请稍后重试';
      if (e.response != null) {
        errorMsg += '\n状态码：${e.response?.statusCode}';
        errorMsg += '\n响应：${e.response?.data}'; // 打印原始响应，便于排查服务端具体错误
      } else {
        errorMsg += '\n原因：${e.message}';
      }
      print(errorMsg);

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

  static Future<String> _minio(
    MultipartFile multipartFile,
    Map<String, dynamic> uploadToken,
  ) async {
    print('使用 MINIO 上传');

    // 1. 从服务端返回的 uploadToken 中提取所有必要参数（关键：直接使用服务端生成的参数，不手动计算）
    final String signature = uploadToken['signature'] ?? '';
    final String policy = uploadToken['policy'] ?? '';
    final String accessKey = uploadToken['accessKey'] ?? '';
    // 1. 从服务端返回的 uploadToken 中提取所有必要参数

// 新增：打印获取到的 Access Key，验证是否正确
    print('从 uploadToken 中获取的 Access Key：$accessKey');
    final String fileKey = uploadToken['fileKey'] ?? '';
    final String filePath = uploadToken['filePath'] ?? '';
    final String serverUrl = uploadToken['serverUrl'] ?? '';
    // 服务端返回的核心签名参数（必须原封不动传递）
    final String xAmzAlgorithm = uploadToken['x-amz-algorithm'] ?? '';
    final String xAmzDate = uploadToken['x-amz-date'] ?? '';
    final String xAmzCredential = uploadToken['x-amz-credential'] ?? '';

    // 2. 校验必要参数（补充服务端返回的核心签名参数校验）
    if ([
      signature,
      policy,
      accessKey,
      fileKey,
      serverUrl,
      xAmzAlgorithm,
      xAmzDate,
      xAmzCredential
    ].any((e) => e.isEmpty)) {
      EasyLoading.showToast('上传参数不完整（缺失签名关键参数）');
      return '';
    }

    // 3. 构造表单参数（严格匹配服务端 policy 中定义的条件）
    final FormData formData = FormData.fromMap({
      'key': fileKey,
      'policy': policy,
      'accessKey': accessKey,
      'x-amz-algorithm': xAmzAlgorithm, // 使用服务端返回的算法（AWS4-HMAC-SHA256）
      'x-amz-credential': xAmzCredential, // 使用服务端生成的凭证
      'x-amz-date': xAmzDate, // 使用服务端生成的时间戳
      'signature': signature,
      'success_action_status': '200', // 与服务端 policy 中条件匹配
      'file': multipartFile,
    });

    // 4. 配置 Dio（移除手动 Content-Type，由 FormData 自动处理为 multipart/form-data）
    final Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      // 移除手动设置的 Content-Type，避免覆盖表单正确类型
      headers: {
        'Content-Length': multipartFile.length, // 保留长度信息（可选，FormData 可能自动处理）
      },
    ));

    try {
      final Response response = await dio.post(
        serverUrl,
        data: formData,
        onSendProgress: (int sent, int total) {
          final double progress = sent / total;
          print('上传进度：${(progress * 100).toStringAsFixed(1)}%');
        },
      );

      if (response.statusCode == 200) {
        return filePath;
      } else {
        EasyLoading.showToast('上传失败，状态码：${response.statusCode}');
        return '';
      }
    } on DioException catch (e) {
      String errorMsg = '上传失败，请稍后重试';
      if (e.response != null) {
        errorMsg += '\n状态码：${e.response?.statusCode}';
        errorMsg += '\n响应：${e.response?.data}'; // 打印原始响应，便于排查服务端具体错误
      } else {
        errorMsg += '\n原因：${e.message}';
      }
      print(errorMsg);
      EasyLoading.showToast(errorMsg);
      return '';
    } catch (e) {
      print('上传异常：$e');
      EasyLoading.showToast('上传异常，请稍后重试');
      return '';
    }
  }
}
