class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts
  static const connectionTimeout = Duration(seconds: 1000);
  static const receiveTimeout = Duration(seconds: 1000);

  // For Android Emulator
  static const String serverAddress = "http://10.0.2.2:5050";
  static const String baseUrl="$serverAddress/api/auth";
  // For iOS Simulator
  //static const String serverAddress = "http://localhost:3000";

  // For iPhone (uncomment if needed)
  // static const String baseUrl = "$serverAddress/api/v1/";
  // static const String imageUrl = "$baseUrl/uploads/";
  //Auth
  static const String login = "/login";
  static const String register = "/register";
  static const String getAllUser = "/getAllUsers";
  static const String updateUser = "/updateUser/";
  static const String deleteUser = "/deleteUser/";

   // Product URLs
 static const String productBaseUrl = "$serverAddress/api/admin/product";

static const String createProduct = "$productBaseUrl"; // POST to /api/admin/product
static const String getAllProducts = "$productBaseUrl"; // GET to /api/admin/product
static String getProductById(String id) => "$productBaseUrl/$id"; // GET to /api/admin/product/:id
static String updateProduct(String id) => "$productBaseUrl/$id"; // PUT to /api/admin/product/:id
static String deleteProduct(String id) => "$productBaseUrl/$id"; // DELETE to /api/admin/product/:id
}