import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_flutter/API/APIaccount.dart';
import 'package:project_flutter/Element/colorbutton.dart';
import '../../Element/General.dart';
import '../../Element/Titile.dart';
import 'package:image_picker/image_picker.dart';

enum sex { nam, nu }
sex _sex = sex.nam;

class SignupSreen extends StatefulWidget {
  const SignupSreen({Key? key}) : super(key: key);

  @override
  Signup createState() => Signup();
}

class Signup extends State<SignupSreen> {
  Column radio(String a, sex gioitinh) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioListTile<sex>(
          contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          title: Text(a),
          value: gioitinh,
          groupValue: _sex,
          onChanged: (sex? value) {
            setState(() {
              _sex = value!;
            });
          },
        ),
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _tendangnhap = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _matkhau = TextEditingController();
  final TextEditingController _xacnhanmatkhau = TextEditingController();
  TextEditingController _sdt = TextEditingController();
  TextEditingController _diachi = TextEditingController();
  TextEditingController _ngaysinh = TextEditingController();
  TextEditingController _gioitinh = TextEditingController();
  TextEditingController _hoten = TextEditingController();
  PickedFile? _imageFile;
  DateTime? _dateTime;
  final ImagePicker _picker = ImagePicker();
  DateTime now = DateTime.now();
  var _emailtontaiInvalid = false;
  var _emailInvalid = false;
  var _xacnhanmatkhauInvalid = false;
  var _sdtInvalid = false;
  var _hotenInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TitleAppBar('????ng k??'),
          backgroundColor: Color(0xffe59191),
        ),
        body: background(
            ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AvatarProfile(),
                      TextFormField(
                        onChanged: (text) async {
                          Map<String, String> data = {
                            '_email': text,
                          };
                          String? email = await checkEmail(data);
                          print(email);
                          if (email != null) {
                            setState(() {
                              _emailtontaiInvalid = true;
                            });
                          } else {
                            setState(() {
                              _emailtontaiInvalid = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Email",
                            errorText: _emailtontaiInvalid
                                ? 'Email ???? t???n t???i'
                                : _emailInvalid
                                    ? 'Email kh??ng h???p l???'
                                    : null,
                            icon: Icon(Icons.email),
                            labelStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: _email,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "H??? t??n",
                            errorText:
                                _hotenInvalid ? 'H??? t??n kh??ng h???p l???' : null,
                            icon: Icon(Icons.account_circle),
                            labelStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: _hoten,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "M???t kh???u",
                            icon: Icon(Icons.password),
                            labelStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _matkhau,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Nh???p l???i m???t kh???u",
                            errorText: _xacnhanmatkhauInvalid
                                ? 'M???t kh???u kh??ng tr??ng kh???p'
                                : null,
                            icon: Icon(Icons.password),
                            labelStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _xacnhanmatkhau,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "S??? ??i???n tho???i",
                            errorText: _sdtInvalid
                                ? 'S??? ??i???n tho???i kh??ng h???p l???'
                                : null,
                            icon: Icon(Icons.phone),
                            labelStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black),
                        keyboardType: TextInputType.number,
                        controller: _sdt,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "?????a ch???",
                            icon: Icon(Icons.home),
                            labelStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: _diachi,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Birthday(context),
                      Row(
                        children: [
                          Expanded(
                            child: radio("Nam", sex.nam),
                          ),
                          Expanded(
                            child: radio("N???", sex.nu),
                          ),
                        ],
                      ),
                      colorbutton(FlatButton(
                        onPressed: () {
                          checkTextField();
                          if (_emailInvalid == false &&
                              _hotenInvalid == false &&
                              _sdtInvalid == false &&
                              _xacnhanmatkhauInvalid == false &&
                              _emailtontaiInvalid == false) {
                            DangKiTaiKhoan();
                          }
                        },
                        child: const Text(
                          "T???o t??i kho???n",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
            context));
  }

  Future DangKiTaiKhoan() async {
    Map<String, String> data = {
      '_tendangnhap': _tendangnhap.text,
      '_hoten': _hoten.text,
      '_matkhau': _matkhau.text,
      '_sdt': _sdt.text,
      '_email': _email.text,
      '_diachi': _diachi.text,
      '_gioitinh': _sex == sex.nam ? '1' : '0',
      '_ngaysinh': _dateTime == null ? '' : getText(),
    };
    var res = await postData(data, _imageFile == null ? null : _imageFile);
    if (res == 'Success') {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      print('Fail');
    }
  }

  void takePhoto() async {
    final _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = _pickedFile!;
    });
  }

  Widget AvatarProfile() {
    return Center(
      child: Stack(
        children: [
          _imageFile == null
              ? CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('images/avatar.png'),
                )
              : CircleAvatar(
                  radius: 80.0,
                  backgroundImage: FileImage(File(_imageFile!.path)),
                ),
          Positioned(
              bottom: 20.0,
              right: 20.0,
              child: InkWell(
                  onTap: () {
                    takePhoto();
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black87,
                    size: 28.0,
                  )))
        ],
      ),
    );
  }

  String getText() {
    if (_dateTime == null) {
      return 'Ch???n ng??y sinh';
    } else {
      return '${_dateTime!.year}/${_dateTime!.month}/${_dateTime!.day}';
    }
  }

  Widget Birthday(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.date_range, color: Colors.black54),
        TextButton(
            onPressed: () {
              pickBirthday(context);
            },
            child: Text(
              getText(),
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ))
      ],
    );
  }

  Future pickBirthday(BuildContext context) async {
    final initialDate = DateTime.now();
    final newdate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 90),
        lastDate: DateTime(DateTime.now().year + 1));
    if (newdate == null) {
      return;
    }
    setState(() {
      _dateTime = newdate;
    });
  }

  void checkTextField() {
    setState(() {
      if (!_email.text.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        _emailInvalid = true;
      } else {
        _emailInvalid = false;
      }

      if (_hoten.text.contains(RegExp(r'^[*".!@#$%^&(){}:;<>,.?/~_+-=]'))) {
        _hotenInvalid = true;
      } else {
        _hotenInvalid = false;
      }

      if (!_sdt.text.contains(RegExp(r'(^[0-9]{10}$)'))) {
        _sdtInvalid = true;
      } else {
        _sdtInvalid = false;
      }

      if (_matkhau.text.toString() != _xacnhanmatkhau.text.toString()) {
        _xacnhanmatkhauInvalid = true;
      } else {
        _xacnhanmatkhauInvalid = false;
      }
    });
  }
}
