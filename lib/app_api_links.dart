class AppApiLinks {
  static const String delevaryServer =
      "https://washing-line.goicsoftware.com/delivery/v1";
  static const String adminServer =
      "https://washing-line.goicsoftware.com/admin/v1";
  static const String login = "$delevaryServer/auth/login";
  static const String logout = "$delevaryServer/auth/logout";
  static const String getCategories = "$delevaryServer/category/index?";
  static const String getSupCategories = "$delevaryServer/sub-category/index";
  static const String getProducts = "$delevaryServer/sub-category/show";
  static const String addToBill = "$delevaryServer/bill/checkout";
  static const String getBill= "$delevaryServer/bill/show";
  static const String searchBill= "$delevaryServer/bill/search";
  static const String getMainBills= "$delevaryServer/bill/get-bills?status=";
  static const String getMonthlyReports= "$delevaryServer/bill/monthly-reports";
  static const String getDailyReports= "$delevaryServer/bill/daily-reports";
  static const String changeBillStatus= "$delevaryServer/bill/change-bill-status";
  static const String changeBillPaymentStatus= "$delevaryServer/bill/change-bill-payment-status";
  static const String changeBillPayment= "$delevaryServer/bill/change-bill-payment";
  static const String getReports = "$delevaryServer/auth/login.php";
  static const String searchCustomerByPhone = "$delevaryServer/customer/search";
  static const String searchCustomerBillsByCode = "$delevaryServer/customer/search-bills?";
  static const String addNewCustomer = "$delevaryServer/customer/store";
}
