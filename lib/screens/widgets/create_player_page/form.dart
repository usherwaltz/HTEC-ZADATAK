import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerForm extends StatefulWidget {
  final int tournamentId;
  final TextEditingController controllerFirstName;
  final TextEditingController controllerLastName;
  final TextEditingController controllerDescription;
  final TextEditingController controllerBirthday;
  final Function selectDate;
  final Function setPoints;
  final Function setChecked;
  final bool checked;
  final int points;


  const PlayerForm({
    Key? key,
    required this.tournamentId,
    required this.controllerFirstName,
    required this.controllerLastName,
    required this.controllerDescription,
    required this.controllerBirthday,
    required this.setChecked,
    required this.selectDate,
    required this.setPoints,
    required this.checked,
    this.points = 0
  }) : super(key: key);

  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [

            TextFormField(
              initialValue: "${widget.tournamentId}",
              enabled: false,decoration: const InputDecoration(
              labelText: "Tournament ID",
            ),
            ),

            /// First Name
            TextFormField(
              controller: widget.controllerFirstName,
              decoration: const InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter players firstname"
              ),
            ),

            /// Last Name
            TextFormField(
              controller: widget.controllerLastName,
              decoration: const InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter players lastname"
              ),
            ),

            /// Description
            TextFormField(
              controller: widget.controllerDescription,
              maxLines: 5,
              decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Enter players description"
              ),
            ),

            /// Points
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => widget.setPoints(int.parse(value)),
              initialValue: "${widget.points}",
              decoration: const InputDecoration(
                  labelText: "Points",
                  hintText: "Enter players points"
              ),
            ),

            /// Birthday
            TextFormField(
              controller: widget.controllerBirthday,
              enableInteractiveSelection: false,
              focusNode: AlwaysDisabledFocusNode(),
              decoration: InputDecoration(
                  labelText: "Birthday",
                  icon: InkWell(
                    onTap: () => widget.selectDate(context),
                    child: const Icon(Icons.calendar_today),
                  )
              ),
            ),

            /// Is Professional
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Professional"),
              value: widget.checked,
              onChanged: (bool? value) {
                widget.setChecked();
              },
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
