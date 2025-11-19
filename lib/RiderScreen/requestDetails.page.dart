/*



import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:delivery_rider_app/RiderScreen/mapRequestDetails.page.dart';
import 'package:delivery_rider_app/data/model/DeliveryResponseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestDetailsPage extends StatefulWidget {
  final IO.Socket? socket;
  final Data deliveryData;
  final String txtID;

  const RequestDetailsPage({
    super.key,
    required this.deliveryData,
    required this.txtID,
    this.socket,
  });

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final String recipientName = '${widget.deliveryData.customer?.firstName ?? ''} ${widget.deliveryData.customer?.lastName ?? ''}'.trim();
    final int completedOrders = widget.deliveryData.customer?.completedOrderCount ?? 0;
    final double averageRating = widget.deliveryData.customer?.averageRating?.toDouble() ?? 4.1;
    final String phone = widget.deliveryData.customer?.phone ?? 'Unknown';
    final String packageType = widget.deliveryData.packageDetails?.fragile == true ? 'Fragile Package' : 'Standard Package';
    final String txtId = widget.txtID;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(left: 15.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111111)),
          ),
        ),
        title: Text(
          "Delivery details",
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF111111),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFA8DADC),
                  ),
                  child: Center(
                    child: Text(
                      recipientName.isNotEmpty
                          ? recipientName[0].toUpperCase()
                          : "D",
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipientName.isEmpty ? 'Unknown Recipient' : recipientName,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    Text(
                      '$completedOrders Deliveries',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          const Icon(Icons.star, color: Colors.yellow, size: 16),
                        SizedBox(width: 5.w),
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF4F4F4F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 35.w,
                  height: 35.h,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF7F7F7),
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/SvgImage/bikess.svg"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFFDE4B65),
                      size: 22,
                    ),
                    SizedBox(height: 6.h),
                    const CircleAvatar(
                      backgroundColor: Color(0xFF28B877),
                      radius: 2,
                    ),
                    SizedBox(height: 5.h),
                    const CircleAvatar(
                      backgroundColor: Color(0xFF28B877),
                      radius: 2,
                    ),
                    SizedBox(height: 5.h),
                    const CircleAvatar(
                      backgroundColor: Color(0xFF28B877),
                      radius: 2,
                    ),
                    SizedBox(height: 6.h),
                    const Icon(
                      Icons.circle_outlined,
                      color: Color(0xFF28B877),
                      size: 17,
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup Location",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF77869E),
                        ),
                      ),
                      Text(
                        widget.deliveryData.pickup?.name ?? "Unknown Pickup Location",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF111111),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        "Delivery Location",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF77869E),
                        ),
                      ),
                      Text(
                        widget.deliveryData.dropoff?.name ?? "Unknown Dropoff Location",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF111111),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: buildAddress("What you are sending", packageType),
                ),
                SizedBox(width: 40.w),
                Expanded(
                  child: buildAddress("Recipient", recipientName.isEmpty ? 'Unknown' : recipientName),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            buildAddress("Recipient contact number", phone),
            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: buildAddress("Payment", widget.deliveryData.paymentMethod ?? "Unknown"),
                ),
                SizedBox(width: 130.w),
                buildAddress("Fee:", "\$${widget.deliveryData.userPayAmount}"), // Fee not available in model, set to 0 or fetch if needed
              ],
            ),

            SizedBox(height: 16.h),

            SizedBox(height: 30.h),
            // Center(
            //   child: TextButton(
            //     onPressed: () {
            //
            //       Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) => MapRequestDetailsPage(
            //             deliveryData: widget.deliveryData,
            //             pickupLat: widget.deliveryData.pickup?.lat,
            //             pickupLong: widget.deliveryData.pickup?.long,
            //             dropLat:  widget.deliveryData.dropoff?.lat,
            //             droplong:  widget.deliveryData.dropoff?.long,
            //           ),
            //         ),
            //       );
            //
            //     },
            //     child: Text(
            //       "View Map Route",
            //       style: GoogleFonts.inter(
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w500,
            //         color: const Color(0xFF006970),
            //         decoration: TextDecoration.underline,
            //         decorationColor: const Color(0xFF006970),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(420.w, 48.h),
                backgroundColor: const Color(0xff006970),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MapRequestDetailsPage(
     socket: widget.socket,
                      deliveryData: widget.deliveryData,
                      pickupLat: widget.deliveryData.pickup?.lat,
                      pickupLong: widget.deliveryData.pickup?.long,
                      dropLat:  widget.deliveryData.dropoff?.lat,
                      droplong:  widget.deliveryData.dropoff?.long,
                      txtid: txtId,
                    ),
                  ),
                );
              },
              child: Text(
                "Accept",
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget buildAddress(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF77869E),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF111111),
          ),
        ),
      ],
    );
  }
}*/


// RequestDetailsPage.dart (FULLY UPDATED - Multiple Drop Support)

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:delivery_rider_app/RiderScreen/mapRequestDetails.page.dart';
import 'package:delivery_rider_app/data/model/DeliveryResponseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestDetailsPage extends StatefulWidget {
  final IO.Socket? socket;
  final Data deliveryData;
  final String txtID;

  const RequestDetailsPage({
    super.key,
    required this.deliveryData,
    required this.txtID,
    this.socket,
  });

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final String recipientName =
    '${widget.deliveryData.customer?.firstName ?? ''} ${widget.deliveryData.customer?.lastName ?? ''}'
        .trim();
    final int completedOrders = widget.deliveryData.customer?.completedOrderCount ?? 0;
    final double averageRating = (widget.deliveryData.customer?.averageRating ?? 0).toDouble();
    final String phone = widget.deliveryData.customer?.phone ?? 'Unknown';
    final String packageType =
    widget.deliveryData.packageDetails?.fragile == true ? 'Fragile Package' : 'Standard Package';

    // Multiple Drop Locations (1 to 3)
    final List<Dropoff> dropLocations = widget.deliveryData.dropoff ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111111)),
          ),
        ),
        title: Text(
          "Delivery Details",
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF111111),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Customer Info Row
              Row(
                children: [
                  Container(
                    width: 56.w,
                    height: 56.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFA8DADC),
                    ),
                    child: Center(
                      child: Text(
                        recipientName.isNotEmpty ? recipientName[0].toUpperCase() : "D",
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipientName.isEmpty ? 'Unknown Recipient' : recipientName,
                          style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$completedOrders Deliveries',
                          style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF4F4F4F)),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                    (i) => Icon(Icons.star, size: 16, color: i < 4 ? Colors.amber : Colors.grey[300]),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              averageRating.toStringAsFixed(1),
                              style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF4F4F4F)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: SvgPicture.asset("assets/SvgImage/bikess.svg", width: 28.w),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Pickup + Multiple Drop Locations
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vertical Line + Icons
                  Column(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Color(0xFFDE4B65), size: 26),
                      SizedBox(height: 8.h),
                      ...List.generate(dropLocations.length, (_) {
                        return Column(
                          children: [
                            Container(width: 2, height: 40.h, color: const Color(0xFF28B877)),
                            const CircleAvatar(radius: 3, backgroundColor: Color(0xFF28B877)),
                            SizedBox(height: 8.h),
                          ],
                        );
                      }),
                      if (dropLocations.isNotEmpty)
                        const Icon(Icons.circle_outlined, color: Color(0xFF28B877), size: 20),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pickup
                        _buildLocationTile("Pickup Location", widget.deliveryData.pickup?.name ?? "Unknown"),
                        SizedBox(height: 20.h),

                        // All Drop Locations
                        ...dropLocations.asMap().entries.map((entry) {
                          int index = entry.key + 1;
                          Dropoff drop = entry.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLocationTile("Drop Location $index", drop.name ?? "Unknown Address"),
                              if (index < dropLocations.length) SizedBox(height: 20.h),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Details Grid
              Row(
                children: [
                  Expanded(child: _buildInfoCard("What you are sending", packageType)),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildInfoCard("Recipient", recipientName.isEmpty ? "Unknown" : recipientName)),
                ],
              ),
              SizedBox(height: 16.h),
              _buildInfoCard("Recipient contact number", phone),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(child: _buildInfoCard("Payment Method", widget.deliveryData.paymentMethod ?? "Cash")),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildInfoCard(
                      "Delivery Fee",
                      "₹${widget.deliveryData.userPayAmount ?? 0}",
                      valueColor: const Color(0xFF006970),
                      boldValue: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // Accept Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006970),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MapRequestDetailsPage(
                          socket: widget.socket,
                          deliveryData: widget.deliveryData,
                          pickupLat: widget.deliveryData.pickup?.lat,
                          pickupLong: widget.deliveryData.pickup?.long,
                          dropLats: dropLocations.map((d) => d.lat ?? 0.0).toList(),
                          dropLons: dropLocations.map((d) => d.long ?? 0.0).toList(),
                          dropNames: dropLocations.map((d) => d.name ?? "Drop Location").toList(),
                          txtid: widget.txtID,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Accept Delivery",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationTile(String title, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF77869E)),
        ),
        SizedBox(height: 4.h),
        Text(
          address,
          style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF111111)),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, {Color? valueColor, bool boldValue = false}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF77869E)),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: boldValue ? FontWeight.w600 : FontWeight.w500,
              color: valueColor ?? const Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }
}