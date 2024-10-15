import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    this.onEdit,
    this.onDelete,
    required this.name,
    required this.contact,
    this.isAdmin = false,
    this.onTap,
  });
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final String name;
  final String contact;
  final bool? isAdmin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: isAdmin!
          ? PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      onTap: onEdit,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          Gap(8.h),
                          Text(
                            'Edit',
                            style: GoogleFonts.poppins(),
                          ),
                        ],
                      )),
                  PopupMenuItem(
                      onTap: onDelete,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          Gap(8.h),
                          Text(
                            'Hapus',
                            style: GoogleFonts.poppins(),
                          ),
                        ],
                      )),
                ];
              },
            )
          : null,
      leading: const Icon(Icons.person),
      tileColor: Colors.orange.shade200,
      style: ListTileStyle.list,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      title: Text(
        name,
        style: GoogleFonts.poppins(),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              'Kontak: $contact',
              style: GoogleFonts.poppins(),
            ),
          ),
          Gap(4.w),
          Icon(
            Icons.copy,
            size: 16.h,
            color: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}
