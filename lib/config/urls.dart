class UrlList {
  UrlList._();
  static String baseurl =
      "http://demo1.greenmainfotech.com/nammafreshbasket/api/";

  ///[EndPoints List]
  static Map? endpoints = {
    'banners': baseurl + 'banners.php',
    'search': baseurl + 'search.php',
    'brands': baseurl + 'brands.php',
    'category': baseurl + 'categories.php',
    'products': baseurl + 'products.php',
    'user': baseurl + 'users.php',
    'branches': baseurl + 'branches.php',
    'pincode': baseurl + 'checkpincode.php',
    'createnewuser': baseurl + 'otp.php',
    'updatenewuser': baseurl + 'users.php',
    'address': baseurl + 'address.php',
    'orders': baseurl + 'orders.php',
    'generalsettings': baseurl + 'generalsettings.php'
  };

  String productsEndPoint = "products.php";

  static String _apikey = "randomkeyforsecretaccess";
  static get apikey => _apikey;

  static Map<String, String> requestType = {
    'getbanners': 'nambannersrequest',
    'getbrands': 'nambrandrequest',
    'getbranches': 'nambranchrequest',
    'getcategories': 'namcategoryrequest',
    'getproducts': 'namgetproducts',
    'putproducts': 'namputproducts',
    'getpincodes': 'nampincoderequest',
    'createnewuser': 'namotprequest',
    'updatenewuser': 'namuserrequest',
    'searchaddress': 'nameuseraddressrequest',
    'placeorder': 'namorderrequest',
    'forgetpass': 'namotprequest',
  };
}
