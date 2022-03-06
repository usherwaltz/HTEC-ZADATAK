import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'widgets/app_bar/page_appbars.dart';
import 'widgets/create_player_page/form.dart';
import 'widgets/layout.dart';

import '../models/player.dart';
import 'blocs/players/players_bloc.dart';

class UpdatePlayerPage extends StatefulWidget {
  final Player player;
  const UpdatePlayerPage(
      this.player,
    {Key? key}) : super(key: key);

  @override
  State<UpdatePlayerPage> createState() => _UpdatePlayerPageState();
}

class _UpdatePlayerPageState extends State<UpdatePlayerPage> {
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
  bool _checked = true;
  int _points = 0;
  DateTime selectedDate = DateTime.now();

  setValues() {
    _controllerFirstName.text = widget.player.firstName;
    _controllerLastName.text = widget.player.lastName;
    _controllerDescription.text = widget.player.description;
    _controllerBirthday.text = DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse(widget.player.dateOfBirth));
    _checked = widget.player.isProfessional == 1 ? true : false;
    _points = widget.player.points;
  }

  setPoints(newValue) {
    setState(() {
      _points = newValue;
    });
  }

  setChecked() {
    setState(() {
      _checked = !_checked;
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controllerBirthday.text = DateFormat("yMMMMd").format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerDescription.dispose();
    _controllerBirthday.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      appBar: PageAppBars.updatePlayer,
      fab: FloatingActionButton.extended(
        onPressed: () {
          Player player = Player(
              id: widget.player.id,
              firstName: _controllerFirstName.value.text,
              lastName: _controllerLastName.value.text,
              description: _controllerDescription.value.text,
              points: _points,
              dateOfBirth: DateFormat("y-MM-dd HH:mm:ss").format(selectedDate),
              profileImageUrl: "",
              isProfessional: _checked ? 1 : 0,
              createdAt: "${DateTime.now()}",
              updatedAt: "",
              deletedAt: "",
              tournamentId: widget.player.tournamentId,
          );

          context.read<PlayersBloc>().add(
              UpdatePlayer(player)
          );
        },
        icon: const Icon(Icons.save),
        label: const Text("SAVE"),
      ),
      body: BlocListener<PlayersBloc, PlayersState>(
        listener: (context, state) {
          if(state is PlayersLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.snackBarMessage.toString()))
            );
            Navigator.of(context).pop();
          }

          if(state is PlayersError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error))
            );
          }
        },
        child: PlayerForm(
        setChecked: setChecked,
        setPoints: setPoints,
        selectDate: selectDate,
        controllerFirstName: _controllerFirstName,
        controllerLastName: _controllerLastName,
        controllerDescription: _controllerDescription,
        controllerBirthday: _controllerBirthday,
        checked: _checked,
        tournamentId: widget.player.tournamentId,
        points: widget.player.points,
      ),
      )
    );
  }
}
