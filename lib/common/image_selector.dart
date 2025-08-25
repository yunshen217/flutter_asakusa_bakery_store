import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';


class SelectImageWidget extends StatelessWidget {
  final RxList<AssetEntity> localAssets;
  final RxList<String> netUrls;
  final RxList<String> fileIds;
  final int maxLength;

  const SelectImageWidget({
    Key? key,
    required this.localAssets,
    required this.netUrls,
    required this.fileIds,
    required this.maxLength,
  }) : super(key: key);

  /* -------------------------------- upload -------------------------------- */

  /// Compress and upload, returning the server fileId
  Future<String?> _uploadSingle(AssetEntity asset) async {
  final file = await compressAndSave(asset);
  if (file == null) return null;

  final completer = Completer<String?>();
  backEndRepository.upFile(
    '${Constant.base_url}common/upload/img',
    [file.path],
    (res) {
      final id = res["data"]??"";
      if (id is String) {
        fileIds.add(id);
        completer.complete(id);
      } else {
        completer.complete(null);
      }
    },
  );
  return completer.future;
}

  /// Select and upload in bulk
  Future<void> _pickAndUpload(BuildContext context) async {
    final left = maxLength - localAssets.length - netUrls.length;
    if (left <= 0) return;

    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: left,
        requestType: RequestType.image,
      ),
    );

    if (result == null || result.isEmpty) return;

    // Occupy a place first, and then add the fileId after uploading
    for (final asset in result) {
      localAssets.add(asset);
    }

    // upload
    for (final asset in result) {
      final id = await _uploadSingle(asset);
      if (id != null) fileIds.add(id);
    }
  }

  /* -------------------------------- UI -------------------------------- */

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final total = localAssets.length + netUrls.length;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            /* Network diagram */
            ...List.generate(netUrls.length, (i) {
              return _imageItem(
                url: netUrls[i],
                onDelete: () {
                  netUrls.removeAt(i);
                  fileIds.removeAt(i);
                },
              );
            }),

            /* This map */
            ...List.generate(localAssets.length, (i) {
              return _imageItem(
                asset: localAssets[i],
                onDelete: () => localAssets.removeAt(i),
              );
            }),

            /* Add button */
            if (total < maxLength)
              _addBtn(context),
          ],
        ),
      );
    });
  }

  Widget _imageItem({
    String? url,
    AssetEntity? asset,
    required VoidCallback onDelete,
  }) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: url != null
                ? Image.network(url, fit: BoxFit.cover,loadingBuilder: (_, child, progress) =>
      progress == null ? child : const CircularProgressIndicator(),
  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),)
                : AssetEntityImage(asset!, fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onDelete,
              child: const Icon(Icons.close, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickAndUpload(context),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: CustomColor.blackD),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.add, size: 32, color: Colors.grey),
      ),
    );
  }
}

/* ----------------------------- Compression tool -------------------------------- */

/// Compress to ≤ 3MB, returning a temporary file
Future<File?> compressAndSave(AssetEntity asset) async {
  final originFile = await asset.originFile;
  if (originFile == null) return null;

  const maxSize = 3 * 1024 * 1024; // 3MB
  final originLen = originFile.lengthSync();
  if (originLen <= maxSize) return originFile;

  int quality = 90;
  Uint8List? bytes;
  do {
    bytes = await FlutterImageCompress.compressWithFile(
      originFile.path,
      quality: quality,
    );
    quality -= 10;
  } while ((bytes?.length ?? 0) > maxSize && quality > 20);

  if (bytes == null) return null;

  final temp = File(
      '${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
  await temp.writeAsBytes(bytes);
  return temp;
}
