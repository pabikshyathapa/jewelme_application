String getBackendImageUrl(String? filepath) {
  if (filepath == null || filepath.isEmpty) {
    return 'https://via.placeholder.com/150';
  }

  final sanitizedPath = filepath.replaceAll('\\', '/');

  const baseUrl = "http://192.168.16.102:5050";

  if (!sanitizedPath.startsWith('/')) {
    return '$baseUrl/$sanitizedPath';
  } else {
    return '$baseUrl$sanitizedPath';
  }
}
