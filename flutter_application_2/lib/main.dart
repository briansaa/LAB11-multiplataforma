import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino Y Material',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime cupertinoDate = DateTime(2024, 10, 26);
  DateTime cupertinoTime = DateTime(2024, 5, 10, 22, 35);
  DateTime cupertinoDateTime = DateTime(2024, 8, 3, 17, 45);
  DateTime materialDate = DateTime(2024, 10, 26);
  DateTime materialTime = DateTime(2024, 5, 10, 22, 35);

  void _showCupertinoDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: materialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != materialDate)
      setState(() {
        materialDate = picked;
      });
  }

  Future<void> _selectMaterialTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: materialTime.hour, minute: materialTime.minute),
    );
    if (picked != null)
      setState(() {
        materialTime = DateTime(materialDate.year, materialDate.month,
            materialDate.day, picked.hour, picked.minute);
      });
  }

  void _showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Cupertino Mensaje'),
        message: const Text('Este es para cupertino.'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('accion por  defecto'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Accion'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Destruir accion'),
          ),
        ],
      ),
    );
  }

  void _showMaterialActionSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('compartir'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('copiar link'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar nombre'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('eliminar coleccion'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino y Material Componentes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _PickerItem(
              label: 'Cupertino Dia',
              value:
                  '${cupertinoDate.month}-${cupertinoDate.day}-${cupertinoDate.year}',
              onPressed: () => _showCupertinoDialog(
                CupertinoDatePicker(
                  initialDateTime: cupertinoDate,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => cupertinoDate = newDate);
                  },
                ),
              ),
            ),
            _PickerItem(
              label: 'Cupertino Tiempo',
              value: '${cupertinoTime.hour}:${cupertinoTime.minute}',
              onPressed: () => _showCupertinoDialog(
                CupertinoDatePicker(
                  initialDateTime: cupertinoTime,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newTime) {
                    setState(() => cupertinoTime = newTime);
                  },
                ),
              ),
            ),
            _PickerItem(
              label: 'Cupertino dia y tiempo',
              value:
                  '${cupertinoDateTime.month}-${cupertinoDateTime.day}-${cupertinoDateTime.year} ${cupertinoDateTime.hour}:${cupertinoDateTime.minute}',
              onPressed: () => _showCupertinoDialog(
                CupertinoDatePicker(
                  initialDateTime: cupertinoDateTime,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() => cupertinoDateTime = newDateTime);
                  },
                ),
              ),
            ),
            _PickerItem(
              label: 'Material Dia',
              value:
                  '${materialDate.month}-${materialDate.day}-${materialDate.year}',
              onPressed: () => _selectMaterialDate(context),
            ),
            _PickerItem(
              label: 'Material Tiempo',
              value: '${materialTime.hour}:${materialTime.minute}',
              onPressed: () => _selectMaterialTime(context),
            ),
            _ActionSheetItem(
              label: 'Cupertino boton de accion',
              onPressed: () => _showCupertinoActionSheet(context),
            ),
            _ActionSheetItem(
              label: ' Material boton de accion',
              onPressed: () => _showMaterialActionSheet(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerItem extends StatelessWidget {
  const _PickerItem({
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: TextStyle(fontSize: 22.0)),
          CupertinoButton(
            onPressed: onPressed,
            child: Text(
              value,
              style: TextStyle(fontSize: 22.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionSheetItem extends StatelessWidget {
  const _ActionSheetItem({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label, style: TextStyle(fontSize: 22.0)),
      ),
    );
  }
}
