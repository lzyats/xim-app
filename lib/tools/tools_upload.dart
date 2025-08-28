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
    return await _upload(multipartFile, false);
  }

  // 文件上传
  static Future<String> uploadFileu(String path) async {
    // 转换文件
    MultipartFile multipartFile = MultipartFile.fromFileSync(path);
    // 执行上传
    return await _upload(multipartFile, true);
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
    return await _upload(multipartFile, false);
  }

  // 执行上传
  static Future<String> _upload(MultipartFile multipartFile, bool usu) async {
    // 获取token
    Map<String, dynamic> uploadToken =
        await RequestCommon.getUploadToken(multipartFile, usu);
    debugPrint('上传信息：' + uploadToken.toString());
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
      case 'minio':
        return await _minio(multipartFile, uploadToken);
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
      debugPrint(errorMsg);

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
    final String uploadUrl = uploadToken['serverUrl'] ?? '';
    final String filePath = uploadToken['filePath'] ?? '';

    if (uploadUrl.isEmpty) {
      EasyLoading.showToast('上传URL为空');
      return '';
    }

    try {
      // 直接向预签名URL发送PUT请求，文件内容作为请求体
      final Response response = await Dio().put(
        uploadUrl,
        data: multipartFile.finalize(),
        options: Options(
          headers: {
            'Content-Type': multipartFile.contentType?.toString() ??
                'application/octet-stream',
            // 添加Content-Length头，解决411错误
            'Content-Length': multipartFile.length.toString(),
          },
        ),
        onSendProgress: (int sent, int total) {
          final double progress = sent / total;
          debugPrint('上传进度：${(progress * 100).toStringAsFixed(1)}%');
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // MinIO PUT成功可能返回204
        return filePath;
      } else {
        EasyLoading.showToast('上传失败，状态码：${response.statusCode}');
        return '';
      }
    } catch (e) {
      debugPrint('上传异常：$e');
      EasyLoading.showToast('上传异常，请稍后重试');
      return '';
    }
  }
}
