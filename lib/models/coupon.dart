class Coupon {
  final int id;
  final String name;
  final String type;
  final String couponValue;
  final int validPerUser;
  final int totalNoUser;
  final String startDate;
  final String validTillDate;
  final int minimumOrderValue;
  final int couponUptoAmount;
  final int status;
  final String couponActive;

  Coupon({
    required this.id,
    required this.name,
    required this.type,
    required this.couponValue,
    required this.validPerUser,
    required this.totalNoUser,
    required this.startDate,
    required this.validTillDate,
    required this.minimumOrderValue,
    required this.couponUptoAmount,
    required this.status,
    required this.couponActive,
  });
}
