/*
import 'package:flutter/material.dart';
import '../model/payment_report_model.dart';

class PaymentCard extends StatelessWidget {
  final SinglePayment payment;

  const PaymentCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow("Invoice No:", payment.invoiceNo ?? "N/A"),
            _buildRow("Payment Type:", payment.paymentType ?? "N/A"),
            _buildRow("Payment ID:", payment.bkashPaymentId ?? "N/A"),
            _buildRow("Payment Date:", payment.paymentDate ?? "N/A"),
            _buildHighlightedAmountRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildHighlightedAmountRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Paid Amount:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            "৳${payment.paidAmount ?? "0.00"}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green, // You can adjust the color to any color you like
            ),
          ),
        ],
      ),
    );
  }
}
*/


import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:advdiary/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/payment_report_model.dart';

class PaymentCard extends StatelessWidget {
  final SinglePayment payment;

  const PaymentCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
     // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius.r),
        ),
        child: Padding(
          padding:  EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow("Invoice No", payment.invoiceNo ?? "N/A"),
              _buildRow("Payment Type", payment.paymentType ?? "N/A"),
              _buildRow("Payment ID", payment.bkashPaymentId ?? "N/A"),
              _buildRow("Payment Date", payment.paymentDate ?? "N/A"),
              const Divider(),
              _buildHighlightedAmountRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
             label,
            style: AppTextStyles.header(),

          ),
        ),
        SizedBox(width: AppDimensions.contentPadding.w,),
       Text( ": ", style: AppTextStyles.header(),),
        Expanded(
          flex: 3,
          child: Text(
             value,
             style: AppTextStyles.body(fontSize: 14),

          ),
        ),
      ],
    );
  }

  Widget _buildHighlightedAmountRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade300, Colors.green.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall.r),
            ),
            padding: const EdgeInsets.all(12),
            child:  Icon(
              Icons.money,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
                 "Paid Amount",
               style: AppTextStyles.header(),
              ),
              //SizedBox(height: AppDimensions.contentPadding.h),
              Text(
                "💰৳${payment.paidAmount ?? "0.00"}",
                style: AppTextStyles.title(color: AppColors.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

