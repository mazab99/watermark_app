import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watermark_app/features/image_canvas/image_cubit.dart';
import 'package:watermark_app/features/image_canvas/image_viewer.dart';
import 'package:watermark_app/features/image_canvas/image_viewer_interacting_cubit.dart';

class ImageCanvas extends StatefulWidget {
  final Uint8List? image;

  const ImageCanvas({
    super.key,
    this.image,
  });

  @override
  State<ImageCanvas> createState() => _ImageCanvasState();
}

class _ImageCanvasState extends State<ImageCanvas> {
  Uint8List? image;

  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, Uint8List?>(
      builder: (context, imageBytes) {
        if (imageBytes == null) {
          return emptyState(context);
        } else {
          return BlocProvider(
            create: (context) => ImageViewerInteractingCubit(),
            child: ImageViewer(image: imageBytes),
          );
        }
      },
    );

    // RepaintBoundary(
    //               key: globalKey,
    //               child: const Card(
    //                 elevation: 3,
    //                 color: Colors.red,
    //                 child: Padding(
    //                   padding: EdgeInsets.all(8.0),
    //                   child: Text('Hello world'),
    //                 ),
    //               ),
    //             ),
    //             if (imageData != null)
    //               FutureBuilder<Uint8List?>(
    //                 future: imageData,
    //                 builder: (context, snapshot) {
    //                   if (snapshot.connectionState == ConnectionState.done) {
    //                     final data = snapshot.data;
    //                     if (data == null) {
    //                       return const Text('Could not generate image');
    //                     } else {
    //                       return RotationTransition(
    //                         turns: AlwaysStoppedAnimation(imageSettings.rotation),
    //                         child: Image.memory(data),
    //                       );
    //                       // return Container();
    //                     }
    //                   }
    //                   return const CircularProgressIndicator();
    //                 },
    //               ),
  }

  Widget emptyState(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.upload),
        label: const Text('Upload image'),
        onPressed: () {
          BlocProvider.of<ImageCubit>(context).uploadImage();
        },
      ),
    );
  }
}
