import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pemilu_pintar/screens/form_c_hasil/widgets/pick_image_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemilu_pintar/common/widgets/my_form.dart';
import 'package:pemilu_pintar/common/widgets/my_solid_button.dart';

class FormCHasil extends StatefulWidget {
  const FormCHasil({super.key});

  @override
  State<FormCHasil> createState() => _FormCHasilState();
}

class _FormCHasilState extends State<FormCHasil> {
  File? _selectedImage;

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromGalery() async {
    final returnedImageGalery =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImageGalery == null) return;

    setState(() {
      _selectedImage = File(_selectedImage!.path);
    });
  }

  void _pickImage() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return PickImageSheet(
            onTapGalery: () {
              _pickImageFromGalery();
              Navigator.pop(context);
            },
            onTapCamera: () {
              _pickImageFromCamera();
              Navigator.pop(context);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input C-Hasil'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 12,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.photo,
                                ),
                                Text(
                                  'Foto C-Hasil',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                Gap(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MySolidButton(
                          onTap: _pickImage,
                          text: _selectedImage == null
                              ? 'Ambil Gambar'
                              : 'Ganti Gambar',
                          color: Colors.blue),
                    ),
                  ],
                ),
                Gap(20.h),
                MyForm(
                  hintText: 'Kecamatan',
                  label: '',
                  validator: (value) {
                    return null;
                  },
                ),
                Gap(16.h),
                MyForm(
                  hintText: 'Kelurahan',
                  label: '',
                  validator: (value) {
                    return null;
                  },
                ),
                Gap(16.h),
                MyForm(
                  hintText: 'Nomor TPS',
                  label: '',
                  validator: (value) {
                    return null;
                  },
                ),
                Gap(16.h),
                MyForm(
                  hintText: 'Nama Kandidat',
                  label: '',
                  validator: (value) {
                    return null;
                  },
                ),
                Gap(16.h),
                MyForm(
                  hintText: 'Jumlah Suara',
                  label: '',
                  validator: (value) {
                    return null;
                  },
                ),
                Gap(20.h),
                Row(
                  children: [
                    Expanded(
                        child: MySolidButton(
                      text: 'INPUT DATA',
                      color: Colors.blue,
                      onTap: () {
                        // if (_formKey.currentState!.validate()) {
                        //   _inputData();
                        // }
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
