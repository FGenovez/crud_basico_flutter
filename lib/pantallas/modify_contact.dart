import 'package:crud_en_flutter/modelos/usuario.model.dart';
import 'package:crud_en_flutter/peticiones/cliente.peticion.dart';
import 'package:flutter/material.dart';
import 'package:crud_en_flutter/pantallas/text_box.dart';

class ModifyUsuario extends StatefulWidget {
  final Usuario _usuario;
  ModifyUsuario(this._usuario);
  @override
  State<StatefulWidget> createState() => _ModifyUsuario();
}

class _ModifyUsuario extends State<ModifyUsuario> {
  TextEditingController controlleruclCodigo;
  TextEditingController controlleruclCodcel;
  TextEditingController controlleruclCoduni;
  TextEditingController controlleruclUsuario;
  TextEditingController controlleruclEstado;

  @override
  void initState() {
    Usuario c = widget._usuario;
    controlleruclCodigo =
        new TextEditingController(text: c.uclCodigo.toString());
    controlleruclCodcel = new TextEditingController(text: c.uclCodcel);
    controlleruclCoduni =
        new TextEditingController(text: c.uclCoduni.toString());
    controlleruclUsuario = new TextEditingController(text: c.uclUsuario);
    controlleruclEstado = new TextEditingController(text: c.uclEstado);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Usuario"),
      ),
      body: ListView(
        children: [
          TextBox(controlleruclCodcel, "CodCEL"),
          TextBox(controlleruclCoduni, "CodUNI"),
          TextBox(controlleruclUsuario, "Usuario"),
          TextBox(controlleruclEstado, "Estado"),
          TextBox(controlleruclCodigo, "Codigo"),
          ElevatedButton(
              onPressed: () {
                String uclcodcel = controlleruclCodcel.text;
                String uclcoduni = controlleruclCoduni.text;
                String uclusuario = controlleruclUsuario.text;
                String uclestado = controlleruclEstado.text;
                String uclcodigo = controlleruclCodigo.text;

                if (uclcodcel.isNotEmpty &&
                    uclusuario.isNotEmpty &&
                    uclestado.isNotEmpty) {
                  Usuario c = new Usuario(
                      uclCodigo: int.parse(uclcodigo),
                      uclCodcel: uclcodcel,
                      uclCoduni: int.parse(uclcoduni),
                      uclEstado: uclestado,
                      uclUsuario: uclusuario);
                  modifyUsusario(c, uclcodigo).then((usuario) {
                    if (usuario.uclCodcel != '') {
                      print('Usuario modificado...!');
                      Navigator.pop(context);
                    }
                  });
                }
              },
              child: Text("Actualizar")),
        ],
      ),
    );
  }
}
