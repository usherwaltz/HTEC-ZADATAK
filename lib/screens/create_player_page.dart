import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/app_bar/page_appbars.dart';
import 'widgets/create_player_page/form.dart';
import '../models/player.dart';
import 'widgets/layout.dart';
import 'package:intl/intl.dart';
import 'blocs/players/players_bloc.dart';

class CreatePlayerPage extends StatefulWidget {
  final int tournamentId;

  const CreatePlayerPage({
    Key? key,
    required this.tournamentId,
  }) : super(key: key);

  @override
  State<CreatePlayerPage> createState() => _CreatePlayerPageState();
}

class _CreatePlayerPageState extends State<CreatePlayerPage> {
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
  final TextEditingController _controllerProfileImageUrl = TextEditingController();
  bool _checked = true;
  int _points = 0;
  DateTime selectedDate = DateTime.now();

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
  void dispose() {
    super.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerDescription.dispose();
    _controllerBirthday.dispose();
    _controllerProfileImageUrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      appBar: PageAppBars.createPlayer,
      fab: FloatingActionButton.extended(
        onPressed: () {
          var player = Player(
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
              tournamentId: widget.tournamentId
          );

          context.read<PlayersBloc>().add(
              CreatePlayer(player)
          );
        },
        icon: const Icon(Icons.send),
        label: const Text('SUBMIT'),
      ),
      body: BlocListener<PlayersBloc, PlayersState>(
        listener: (context, state) {
          if(state is PlayersLoaded) {
            if(state.snackBarMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.snackBarMessage.toString())
                  )
              );
              Navigator.of(context).pop();
            }
          }

          if(state is PlayersError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Oops, something went wrong")
                )
            );
          }
        },
        child: PlayerForm(
          tournamentId: widget.tournamentId,
          controllerBirthday: _controllerBirthday,
          controllerDescription: _controllerDescription,
          controllerFirstName: _controllerFirstName,
          controllerLastName: _controllerLastName,
          selectDate: selectDate,
          setPoints: setPoints,
          setChecked: setChecked,
          checked: _checked,
        )
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
