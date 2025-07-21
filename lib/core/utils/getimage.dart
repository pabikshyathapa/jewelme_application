String getBackendImageUrl(String? filepath) {
  if (filepath == null || filepath.isEmpty) {
    return 'https://via.placeholder.com/150';
  }

  final sanitizedPath = filepath.replaceAll('\\', '/');

  const baseUrl = 'http://10.0.2.2:5050/'; // ← use local IP if needed
  return '$baseUrl$sanitizedPath';
}
