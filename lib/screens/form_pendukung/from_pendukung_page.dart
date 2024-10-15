import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';
import 'package:nik_validator/nik_validator.dart';
import 'package:pemilu_pintar/common/widgets/message_util.dart';
import 'package:pemilu_pintar/common/widgets/my_form.dart';
import 'package:pemilu_pintar/common/widgets/my_solid_button.dart';
import 'package:pemilu_pintar/constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pemilu_pintar/models/user.dart';
import 'package:pemilu_pintar/screens/form_c_hasil/widgets/pick_image_sheet.dart';
import 'package:pemilu_pintar/screens/form_pendukung/widgets/nik_item.dart';
import 'package:pemilu_pintar/services/database_services.dart';

class FormPendukungPage extends StatefulWidget {
  const FormPendukungPage({super.key});

  @override
  State<FormPendukungPage> createState() => _FormPendukungPageState();
}

class _FormPendukungPageState extends State<FormPendukungPage> {
  DatabaseServices databaseServices = DatabaseServices();
  File? _selectedImage;
  Size? _imageSize;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  final _namaController = TextEditingController();
  final _usiaController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _jenisKelaminController = TextEditingController();
  final _provinsiController = TextEditingController();
  final _agamaController = TextEditingController();
  final _kotaController = TextEditingController();
  final _kecamatanController = TextEditingController();
  final _kodePosController = TextEditingController();

  // Future<void> scanKtp() async {
  //   try {
  //     OcrResultModel res = await MncIdentifierOcr.startCaptureKtp(
  //         withFlash: true, cameraOnly: true);
  //     log('result: ${res.ktp!.nik.toString()}');
  //     setState(() {
  //       _nikController.text = res.ktp!.nik.toString();
  //       _namaController.text = res.ktp!.nama.toString();
  //       _tempatLahirController.text = res.ktp!.tempatLahir.toString();
  //       _tanggalLahirController.text = res.ktp!.tglLahir.toString();
  //       _jenisKelaminController.text = res.ktp!.jenisKelamin.toString();
  //       _alamatController.text = res.ktp!.alamat.toString();
  //       _agamaController.text = res.ktp!.agama.toString();
  //     });
  //   } catch (e) {
  //     debugPrint('something goes wrong $e');
  //   }
  // }

  void _getImageSize(File? imageFile) async {
    final completer = Completer<Size>();

    final Image image = Image.file(imageFile!);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size size = await completer.future;
    _imageSize = size;
  }

  void recognizeImage() async {
    TextRecognizer _textDetector = TextRecognizer();
    _getImageSize(_selectedImage);

    /// Creating an InputImage object using the image path
    final inputImage = InputImage.fromFilePath(_selectedImage!.path);

    /// Retrieving the RecognisedText from the InputImage
    final text = await _textDetector.processImage(inputImage);
    RegExp regEx = RegExp(nikPattern);

    /// Finding matching value with NIK pattern and store to list
    for (TextBlock block in text!.blocks) {
      for (TextLine line in block.lines) {
        String _text = line.text.trim().replaceAll(" ", "");

        if (regEx.hasMatch(_text)) {
          /// Parsing raw text and find NIK Informations
          var result = await parse(regEx.stringMatch(_text)!);
          if (result != null) {
            // _nik?.add(_result);
            log(result.age.toString());
            setState(() {
              _nikController.text = result.nik.toString();
              _tanggalLahirController.text = result.bornDate.toString();
              _jenisKelaminController.text = result.gender.toString();
              _usiaController.text = result.age.toString();
              _provinsiController.text = result.province.toString();
              _kotaController.text = result.city.toString();
              _kecamatanController.text = result.subdistrict.toString();
              _kodePosController.text = result.postalCode.toString();
            });
          }
        }
      }
    }
  }

  /// Parsing NIK Informations
  Future<NIKModel?>? parse(String text) async {
    NIKModel result = await NIKValidator.instance.parse(nik: text);
    if (result.valid == true) {
      return result;
    }
    return null;
  }

  void _pickImage() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return PickImageSheet(
            onTapGalery: () {
              pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
            onTapCamera: () {
              Navigator.pop(context);
            },
          );
        });
  }

  void pickImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image == null) {
      return;
    }
    setState(() {
      _selectedImage = File(image.path);
    });
    recognizeImage();
  }

  void _inputData() {
    isLoading = true;
    final nik = _nikController.text;
    final name = _namaController.text;
    final gender = _jenisKelaminController.text;
    final dateOfBirth = _tanggalLahirController.text;
    final age = _usiaController.text;
    final province = _provinsiController.text;
    final city = _kotaController.text;
    final subDistrict = _kecamatanController.text;
    final postalCode = _kodePosController.text;

    try {
      final user = User(
        nik: nik,
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        age: age,
        province: province,
        city: city,
        subDistrict: subDistrict,
        postalCode: postalCode,
        isTimSaksi: false,
        isAdmin: false,
        createdOn: Timestamp.now(),
        updatedOn: Timestamp.now(),
        inputBy: '',
      );
      databaseServices.addDataPendukung(user, context);
    } catch (e) {
      log(e.toString());
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Input Data Pendukung'),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade100,
                    Colors.orange.shade100,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 2.5,
                        child: _selectedImage == null
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.photo,
                                      ),
                                      Text(
                                        'Scan Foto KTP',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Gap(16.h),
                      Row(
                        children: [
                          Expanded(
                            child: MySolidButton(
                                onTap: _pickImage,
                                text: 'Ambil Foto KTP',
                                color: Colors.purple),
                          ),
                        ],
                      ),
                      Gap(16.h),
                      MyForm(
                        controller: _nikController,
                        hintText: 'NIK',
                        label: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'NIK tidak boleh kosong!';
                          }
                          if (value.length < 16 || value.length > 16) {
                            return 'NIK terdiri dari 16 angka!';
                          }
                          return null;
                        },
                      ),
                      Gap(12.h),
                      MyForm(
                        controller: _namaController,
                        hintText: 'Nama',
                        label: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Gap(12.h),
                      MyForm(
                        controller: _jenisKelaminController,
                        hintText: 'Jenis Kelamin',
                        label: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Jenis Kelamin tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Gap(12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (screenWidht - 28) / 2.1,
                            child: MyForm(
                              controller: _tanggalLahirController,
                              hintText: 'Tanggal Lahir',
                              label: '',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Tanggal lahir tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: (screenWidht - 28) / 2.1,
                            child: MyForm(
                              controller: _usiaController,
                              hintText: 'Usia',
                              label: '',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Usia tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Gap(12.h),
                      MyForm(
                        controller: _provinsiController,
                        hintText: 'Provinsi',
                        label: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Provinsi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Gap(12.h),
                      MyForm(
                        controller: _kotaController,
                        hintText: 'Kota',
                        label: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kota tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Gap(12.h),
                      MyForm(
                        controller: _kecamatanController,
                        hintText: 'Kecamatan',
                        label: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kecamatan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Gap(12.h),
                      MyForm(
                        controller: _kodePosController,
                        hintText: 'Kode Pos',
                        label: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kode Pos tidak boleh kosong';
                          }
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
                              if (_formKey.currentState!.validate()) {
                                _inputData();
                              } else {
                                MessageUtil.showMessage(
                                    context,
                                    'Semua Kolom Harus Terisi !!!',
                                    MessageType.error);
                              }
                            },
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.blueGrey.withOpacity(0.5)),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
