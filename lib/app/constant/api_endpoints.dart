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

//cart
 static const String cartBaseUrl = "$serverAddress/api/cart";
  static const String addToCart= "$cartBaseUrl/add";
  static const String getCartByUser = "$cartBaseUrl";
  static const String updateCartItem = "$cartBaseUrl/update";
  static const String removeCartItem = "$cartBaseUrl/remove";
  static const String clearCart = "$cartBaseUrl/clear";
  static const String getAllCartItems = "$cartBaseUrl/all";

//wishlist
  static const String wishlistbaseUrl = "$serverAddress/api/wishlist";
  static const String addToWishlist = "$wishlistbaseUrl/add";
  static const String getWishlistByUser = "$wishlistbaseUrl";  
  static const String removeFromWishlist = "$wishlistbaseUrl/remove";

  //order
  static const String orderbaseUrl = "$serverAddress/api/order" ;
  static const String checkoutCart = "$orderbaseUrl/checkout";
  static const String getOrdersByUser = "$orderbaseUrl";

//users
  static const String baseUser = '$serverAddress/api/admin/users';
  static String getUserById(String userId) => '$baseUser/$userId';
  static String updateUserById(String userId) => '$baseUser/$userId';
}


