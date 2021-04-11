import 'package:flutter/material.dart';
import 'package:application/constants.dart';
import 'package:application/models/contact.dart';
import 'package:application/util/database_helper.dart';

class Sign_in extends StatefulWidget {
  @override
  _Sign_state createState() => _Sign_state();
}

class _Sign_state extends State<Sign_in> {
  Contact _contact = Contact();
  List<Contact> _contacts = [];
  DatabaseHelper _dbHelper;
  final _formKey = GlobalKey<FormState>();
  final _ctrlName = TextEditingController();
  final _ctrlAlamat = TextEditingController();
  final _ctrlPendidikan = TextEditingController();
  final _ctrlKeahlian = TextEditingController();
  final _ctrlPengalaman = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshContactList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Data")),
        body: Center(
          // child: RaisedButton(
          //     onPressed: () {
          //       Navigator.pop(context);//untuk kembali ke halaman sebelumnya
          //     },
          //     child: Text("Id = "+id+" Name = "+name+" Phone ="+mobile)
          // ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[_form(), _list()],
          ),
        ));
  }

  _form() => Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ctrlName,
                decoration: InputDecoration(labelText: 'Nama lengkap'),
                onSaved: (val) => setState(() => _contact.name = val),
                validator: (val) => (val.length == 0 ? 'Wajib diisi!' : null),
              ),
              TextFormField(
                controller: _ctrlAlamat,
                decoration: InputDecoration(labelText: 'Alamat'),
                onSaved: (val) => setState(() => _contact.alamat = val),
                validator: (val) => (val.length == 0 ? 'Wajib diisi!' : null),
              ),
              TextFormField(
                controller: _ctrlPendidikan,
                decoration: InputDecoration(labelText: 'Pendidikan'),
                onSaved: (val) => setState(() => _contact.pendidikan = val),
                validator: (val) => (val.length == 0 ? 'Wajib diisi!' : null),
              ),
              TextFormField(
                controller: _ctrlKeahlian,
                decoration: InputDecoration(labelText: 'Keahlian'),
                onSaved: (val) => setState(() => _contact.keahlian = val),
                validator: (val) => (val.length == 0 ? 'Wajib diisi!' : null),
              ),
              TextFormField(
                controller: _ctrlPengalaman,
                decoration: InputDecoration(labelText: 'Pengalaman'),
                onSaved: (val) => setState(() => _contact.pengalaman = val),
                validator: (val) => (val.length == 0 ? 'Wajib diisi!' : null),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () => _onSubmit(),
                  child: Text('Simpan'),
                  color: mainColor,
                  textColor: Colors.white,
                ),
              )
            ],
          )));

  _refreshContactList() async {
    List<Contact> x = await _dbHelper.fetchContacts();
    setState(() {
      _contacts = x;
    });
  }

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // setState((){
      //   _contacts.add(Contact(id:null,name:_contact.name,mobile:_contact.mobile));
      // });
      if (_contact.id == null)
        await _dbHelper.insertContact(_contact);
      else
        await _dbHelper.updateContact(_contact);
      _refreshContactList();
      _resetForm();
      // form.reset();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlName.clear();
      _ctrlAlamat.clear();
      _ctrlPendidikan.clear();
      _ctrlKeahlian.clear();
      _ctrlPengalaman.clear();
      _contact.id = null;
    });
  }

  _list() => Expanded(
          child: Card(
        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading:
                      Icon(Icons.account_circle, color: mainColor, size: 40.0),
                  title: Text(
                    _contacts[index].name,
                    style: TextStyle(
                        color: mainColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _contacts[index].alamat,
                        style: TextStyle(
                            // color: mainColor,
                            // fontWeight: FontWeight.bold
                            ),
                      ),
                      Text(
                        _contacts[index].pendidikan,
                        style: TextStyle(
                            // color: mainColor,
                            // fontWeight: FontWeight.bold
                            ),
                      ),
                      Text(
                        _contacts[index].keahlian,
                        style: TextStyle(
                            // color: mainColor,
                            // fontWeight: FontWeight.bold
                            ),
                      ),
                      Text(
                        _contacts[index].pengalaman,
                        style: TextStyle(
                            // color: mainColor,
                            // fontWeight: FontWeight.bold
                            ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete_sweep, color: mainColor),
                      onPressed: () async {
                        await _dbHelper.deleteContact(_contacts[index].id);
                        _resetForm();
                        _refreshContactList();
                      }),
                  onTap: () {
                    setState(() {
                      _contact = _contacts[index];
                      _ctrlName.text = _contacts[index].name;
                      _ctrlAlamat.text = _contacts[index].alamat;
                      _ctrlPendidikan.text = _contacts[index].pendidikan;
                      _ctrlKeahlian.text = _contacts[index].keahlian;
                      _ctrlPengalaman.text = _contacts[index].pengalaman;
                    });
                  },
                ),
                Divider(
                  height: 5.0,
                )
              ],
            );
          },
        ),
      ));
}
