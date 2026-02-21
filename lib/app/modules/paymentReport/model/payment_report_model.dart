
import 'dart:convert';

PaymentReportModel paymentReportModelFromJson(String str) => PaymentReportModel.fromJson(json.decode(str));

String paymentReportModelToJson(PaymentReportModel data) => json.encode(data.toJson());

class PaymentReportModel {
  final String? msg;
  final bool? status;
  final List<SinglePayment>? data;
  final Pagination? pagination;

  PaymentReportModel({
    this.msg,
    this.status,
    this.data,
    this.pagination,
  });

  factory PaymentReportModel.fromJson(Map<String, dynamic> json) => PaymentReportModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SinglePayment>.from(json["data"]!.map((x) => SinglePayment.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class SinglePayment {
  final int? id;
  final String? paymentType;
  final String? invoiceNo;
  final String? bkashPaymentId;
  final String? paymentDate;
  final String? paidAmount;

  SinglePayment({
    this.id,
    this.paymentType,
    this.invoiceNo,
    this.bkashPaymentId,
    this.paymentDate,
    this.paidAmount,
  });

  factory SinglePayment.fromJson(Map<String, dynamic> json) => SinglePayment(
    id: json["id"],
    paymentType: json["payment_type"],
    invoiceNo: json["invoice_no"],
    bkashPaymentId: json["bkash_payment_id"],
    paymentDate: json["payment_date"],
    paidAmount: json["paid_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_type": paymentType,
    "invoice_no": invoiceNo,
    "bkash_payment_id": bkashPaymentId,
    "payment_date": paymentDate,
    "paid_amount": paidAmount,
  };
}

class Pagination {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;
  final dynamic nextPageUrl;
  final dynamic prevPageUrl;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}
