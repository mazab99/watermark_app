import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark_app/features/image_edit_panel/image_settings.dart';
import 'package:watermark_app/utils/file_service.dart';

import '../../utils/file_service.dart';
import 'image_settings.dart';

class ImageSettingsCubit extends Cubit<ImageSettings> {
  ImageSettingsCubit([ImageSettings? initialState])
      : super(initialState ?? ImageSettings());

  void updateSettings(ImageSettings settings) => emit(settings);

  Future<void> uploadWatermark(BuildContext context) async {
    final file = await uploadImage();
    if (file == null) return;
    final bytes = file.path != null ? await getImageBytes(file.path!) : null;
    if (bytes == null) return;
    final img = await decodeImageFromList(bytes);
    final imgHeight = img.height;
    final imgWidth = img.width;
    final newSettings = state.copyWith(
      watermark: file,
      watermarkBytes: bytes,
      height: imgHeight.toDouble(),
      width: imgWidth.toDouble(),
      initialHeight: imgHeight.toDouble(),
      initialWidth: imgWidth.toDouble(),
    );
    emit(newSettings);
  }
}
