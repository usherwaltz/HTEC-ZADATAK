import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnir/models/players_model.dart';
import 'package:turnir/screens/blocs/tournament_details/tournament_details_bloc.dart';
import '../screens/widgets/app_bar/page_appbars.dart';
import '../screens/widgets/layout.dart';

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
          var players = Players(
              firstName: _controllerFirstName.value.text,
              lastName: _controllerLastName.value.text,
              points: _points,
              isProfessional: _checked ? 1 : 0,
              createdAt: "${DateTime.now()}",
              updatedAt: "",
              deletedAt: "",
              tournamentId: widget.tournamentId
          );

          context.read<TournamentDetailsBloc>().add(
              AddTournamentDetails(players)
          );
        },
        icon: const Icon(Icons.send),
        label: const Text('SUBMIT'),
      ),
      body: BlocListener<TournamentDetailsBloc, TournamentDetailsState>(
        listener: (context, state) {},
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [

                /// First Name
                TextFormField(
                  controller: _controllerFirstName,
                  decoration: const InputDecoration(
                      labelText: "First Name",
                      hintText: "Enter player firstname"
                  ),
                ),

                /// Last Name
                TextFormField(
                  controller: _controllerLastName,
                  decoration: const InputDecoration(
                      labelText: "Last Name",
                      hintText: "Enter player lastname"
                  ),
                ),

                /// Description
                TextFormField(
                  controller: _controllerDescription,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Enter player description"
                  ),
                ),

                /// Points
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (value) => _points = int.parse(value),
                  decoration: const InputDecoration(
                      labelText: "Points",
                      hintText: "Enter player points"
                  ),
                ),

                /// Birthday
                TextFormField(
                  controller: _controllerBirthday,
                  decoration: const InputDecoration(
                      labelText: "Birthday",
                      hintText: "yyyy-mm-dd H:i:s"
                  ),
                ),

                /// Is Professional
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Professional"),
                  value: _checked,
                  onChanged: (bool? value) {
                    setState(() {
                      _checked = !_checked;
                    });
                  },
                ),

                /// Profile Image Url
                TextFormField(
                  controller: _controllerProfileImageUrl,
                  decoration: const InputDecoration(
                      labelText: "Profile Image Url",
                      hintText: "http://internships-mobile.htec.co.rs/uploads/player_images/1528126297.png"
                  ),
                ),

                // allows a bit of overscroll so that the FAB button does not overlap with the profile image url input
                const SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
