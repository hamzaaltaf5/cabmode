import 'package:flutter/material.dart';

import '../../widgets/booking_detail_widget.dart';

class CompletedRidesScreen extends StatefulWidget {
  const CompletedRidesScreen({super.key});

  @override
  State<CompletedRidesScreen> createState() => _CompletedRidesScreenState();
}

class _CompletedRidesScreenState extends State<CompletedRidesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return BookingDetailsWidget(
          status: 'Completed',
          statusColor: Colors.green,
        );
      },
    );
  }
}
