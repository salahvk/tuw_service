const String endPoint = "http://projects.techoriz.in/serviceapp/public";

// const String endPoint = "https://tuw.om";

const String api = "$endPoint/api";
const String apiGet = "$endPoint/api/getall";
const String apiUser = "$endPoint/api/user";

const String languagesApi = "$apiGet/languages";
const String countriesApi = "$apiGet/countries";

const String imageApi = "$endPoint/assets/uploads/service";
const String updateProfileApi = "$api/update/profileimage";
const String updateCoverPictureApi = "$api/update/coverimage";
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
const String placeOrderApi = '$api/place-order?';
const String payFortpaymentSuccess = '$api/update/payment-status';
const String thawaniPaymentSuccess = '$api/payment-success';
const String thawaniPaymentfailed = '$api/payment-failed';

const String userAddressCreate = '$api/address/create';
const String getUserAddressApi = '$api/address/list';
const String getUserAddressShow = '$api/address/show';
const String updateUserAddressApi = '$api/address/update';
const String deleteUserAddressApi = '$api/address/delete?address_id=';

const String updateLocationApi = '$api/update/location?home_location=';

const String updateServiceManApi = '$api/update/serviceman-profile';

const String serviceManProfileApi = '$api/serviceman-profile';

const String favoritesListApi = '$api/favorite/list';
const String addFavoritesListApi = '$api/favorite/add';
const String removeFavoritesListApi = '$api/favorite/remove';

const String viewChatMessagesApi = '$api/chat-messages?receiver_id=';

const String updateReadStatusApi = "$api/update/read-status";

const String reportCustomerApi = "$api/report-customer";

const String getRegionApi = "$api/getregions?country_id=";
