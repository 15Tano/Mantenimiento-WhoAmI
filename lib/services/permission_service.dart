// lib/services/permission_service.dart
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Pide permiso para cámara
  static Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Pide permiso para galería / fotos
  static Future<bool> requestGallery() async {
    // iOS: Permission.photos
    // Android: el plugin mapea a READ_MEDIA_IMAGES / READ_EXTERNAL_STORAGE según versión
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// Pide ambos permisos
  static Future<bool> requestCameraAndGallery() async {
    final statuses = await [
      Permission.camera,
      Permission.photos,
    ].request();

    return statuses.values.every((s) => s.isGranted);
  }
}

