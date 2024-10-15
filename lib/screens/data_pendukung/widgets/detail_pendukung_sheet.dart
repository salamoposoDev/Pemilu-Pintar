import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pemilu_pintar/models/user.dart';

class DetailPendukungSheet extends StatelessWidget {
  const DetailPendukungSheet({
    this.user,
    super.key,
  });
  final List<User>? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Detail'),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close),
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 4 / 2.5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Center(
                child: Text('Foto KTP'),
              ),
            ),
          ),
          ListView.builder(
            itemCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: ListTile(
                  tileColor: Colors.grey.shade50,
                  title: Text('Salahuddin'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
