// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// // late List<CameraDescription> _cameras;

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   _cameras = await availableCameras();
// //   runApp(const CameraApp());
// // }

// /// CameraApp is the Main Application.
// class CameraApp extends StatefulWidget {
//   final cameras;

//   /// Default Constructor
//   const CameraApp({Key? key, this.cameras}) : super(key: key);

//   @override
//   State<CameraApp> createState() => _CameraAppState();
// }

// class _CameraAppState extends State<CameraApp> {
//   late CameraController controller;
//   Future<List<Directory>?>? externalStorageDirectories;
//   XFile? imageFile;
//   Future<Directory?>? _downloadsDirectory;

//   void showInSnackBar(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   void _showCameraException(CameraException e) {
//     _logError(e.code, e.description);
//     showInSnackBar('Error: ${e.code}\n${e.description}');
//   }

//   void _logError(String code, String? message) {
//     if (message != null) {
//       print('Error: $code\nError Message: $message');
//     } else {
//       print('Error: $code');
//     }
//   }

//   Future<XFile?> takePicture() async {
//     final CameraController cameraController = controller;
//     if (!cameraController.value.isInitialized) {
//       showInSnackBar('Error: select a camera first.');
//       return null;
//     }

//     if (cameraController.value.isTakingPicture) {
//       // A capture is already pending, do nothing.
//       return null;
//     }

//     try {
//       final XFile file = await cameraController.takePicture();
//       return file;
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//   }

//   void onTakePictureButtonPressed() async {
//     // final s = Permission.manageExternalStorage;
//     // if (s == PermissionStatus.granted) {
//     //   var dir = await getExternalStorageDirectory();
//     //   final m = Directory("${dir!.path}/myapp").createSync(recursive: true);
//     //   // setState(() {
//     //   //   imageFile = m;
//     //   // });
//     // }

//     takePicture().then((XFile? file) {
//       if (mounted) {
//         // saveFile();

//         // createFolderInAppDocDir('folderName');
//         // setState(() {
//         //   externalStorageDirectories = getExternalStorageDirectories();
//         // });

//         // setState(() {
//         //   externalDocumentsDirectory = getExternalStorageDirectory();
//         // });

//         setState(() {
//           imageFile = file;
//           // videoController?.dispose();
//           // videoController = null;
//         });
//         if (file != null) {
//           showInSnackBar('Picture saved to ${file.path}');
//         }
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(widget.cameras[0], ResolutionPreset.max);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             print('User denied camera access.');
//             break;
//           default:
//             print('Handle other errors.');
//             break;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return Container();
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Camera example'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 border: Border.all(
//                   color: controller.value.isRecordingVideo
//                       ? Colors.redAccent
//                       : Colors.grey,
//                   width: 3.0,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Center(
//                   child: CameraPreview(controller),
//                 ),
//               ),
//             ),
//           ),
//           _captureControlRowWidget(),
//           // _modeControlRowWidget(),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               children: const <Widget>[
//                 // _cameraTogglesRowWidget(),
//                 // _thumbnailWidget(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   } 

//   Widget _captureControlRowWidget() {
//     final CameraController cameraController = controller;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.camera_alt),
//           color: Colors.blue,
//           onPressed: cameraController.value.isInitialized &&
//                   !cameraController.value.isRecordingVideo
//               ? onTakePictureButtonPressed
//               : null,
//         ),
//         // IconButton(
//         //   icon: const Icon(Icons.videocam),
//         //   color: Colors.blue,
//         //   onPressed: cameraController != null &&
//         //           cameraController.value.isInitialized &&
//         //           !cameraController.value.isRecordingVideo
//         //       ? onVideoRecordButtonPressed
//         //       : null,
//         // ),
//         // IconButton(
//         //   icon: cameraController != null &&
//         //           cameraController.value.isRecordingPaused
//         //       ? const Icon(Icons.play_arrow)
//         //       : const Icon(Icons.pause),
//         //   color: Colors.blue,
//         //   onPressed: cameraController != null &&
//         //           cameraController.value.isInitialized &&
//         //           cameraController.value.isRecordingVideo
//         //       ? (cameraController.value.isRecordingPaused)
//         //           ? onResumeButtonPressed
//         //           : onPauseButtonPressed
//         //       : null,
//         // ),
//         // IconButton(
//         //   icon: const Icon(Icons.stop),
//         //   color: Colors.red,
//         //   onPressed: cameraController != null &&
//         //           cameraController.value.isInitialized &&
//         //           cameraController.value.isRecordingVideo
//         //       ? onStopButtonPressed
//         //       : null,
//         // ),
//         // IconButton(
//         //   icon: const Icon(Icons.pause_presentation),
//         //   color:
//         //       cameraController != null && cameraController.value.isPreviewPaused
//         //           ? Colors.red
//         //           : Colors.blue,
//         //   onPressed:
//         //       cameraController == null ? null : onPausePreviewButtonPressed,
//         // ),
//       ],
//     );
//   }

//   Future<String> getFilePath() async {
//     Directory appDocumentsDirectory =
//         await getApplicationDocumentsDirectory(); // 1
//     String appDocumentsPath = appDocumentsDirectory.path; // 2
//     String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

//     return filePath;
//   }

//   void saveFile() async {
//     File file = File(await getFilePath()); // 1
//     file.writeAsString(
//         "This is my demo text that will be saved to : demoTextFile.txt"); // 2
//   }

//   void _requestDownloadsDirectory() {
//     setState(() {
//       _downloadsDirectory = getDownloadsDirectory();
//     });
//   }

//   Future<String> createFolderInAppDocDir(String folderName) async {
//     //Get this App Document Directory

//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     //App Document Directory + folder name
//     final Directory appDocDirFolder =
//         Directory('${appDocDir.path}/$folderName/');

//     if (await appDocDirFolder.exists()) {
//       //if folder already exists return path
//       return appDocDirFolder.path;
//     } else {
//       //if folder not exists create folder and then return its path
//       final Directory appDocDirNewFolder =
//           await appDocDirFolder.create(recursive: true);
//       return appDocDirNewFolder.path;
//     }
//   }
// }

// // Widget _cameraPreviewWidget() {
  
// //     final CameraController? cameraController = controller;

// //     if (cameraController == null || !cameraController.value.isInitialized) {
// //       return const Text(
// //         'Tap a camera',
// //         style: TextStyle(
// //           color: Colors.white,
// //           fontSize: 24.0,
// //           fontWeight: FontWeight.w900,
// //         ),
// //       );
// //     } else {
// //       return Listener(
// //         onPointerDown: (_) => _pointers++,
// //         onPointerUp: (_) => _pointers--,
// //         child: CameraPreview(
// //           controller!,
// //           child: LayoutBuilder(
// //               builder: (BuildContext context, BoxConstraints constraints) {
// //             return GestureDetector(
// //               behavior: HitTestBehavior.opaque,
// //               onScaleStart: _handleScaleStart,
// //               onScaleUpdate: _handleScaleUpdate,
// //               onTapDown: (TapDownDetails details) =>
// //                   onViewFinderTap(details, constraints),
// //             );
// //           }),
// //         ),
// //       );
// //     }
// //   }



  