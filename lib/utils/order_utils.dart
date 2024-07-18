class OrderUtils {
  static String getStatusLabel(String status) {
    String label = "";

    switch (status) {
      case "Pending":
        label = "Chờ duyệt";
        break;
      case "Confirmed":
        label = "Đã xác nhận";
        break;
      default:
        break;
    }

    return label;
  }
}
