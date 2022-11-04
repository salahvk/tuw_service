const String endPoint = "http://projects.techoriz.in/serviceapp/public";

const String api = "$endPoint/api";
const String apiGet = "$endPoint/api/getall";
const String apiUser = "$endPoint/api/user";
const String languagesApi = "$apiGet/languages";
const String countriesApi = "$apiGet/countries";
const String imageApi = "$endPoint/assets/uploads/service";
const String updateProfileApi = "$api/update/profileimage";
const String profileImageApi = "$endPoint/assets/uploads/profile";
const String viewUserProfileApi = "$api/view/userprofile";
const String logout = "$apiUser/logout";
const String home = "$api/home";

const String customerCoupenList = '$api/couponlist';
const String checkCoupen = '$api/coupon-validity?coupon_code=';

const String customerParentService = '$api/parentservices';
const String customerChildService = '$api/childservices';
const String subServices = '$api/subservices';
const String servicemanList = '$api/servicemanlist';
const String placeOrder = '$api/place-order?';
const String paymentSuccess = '$api/update/payment-status';
