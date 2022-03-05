// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// import '../../../models/player_model.dart';
//
// class CreatePlayerFormBloc extends FormBloc<String, String> {
//   final firstName = TextFieldBloc();
//   final lastName = TextFieldBloc();
//   final description = TextFieldBloc();
//   final points = TextFieldBloc();
//   final birthday = TextFieldBloc();
//   final isProfessional = BooleanFieldBloc();
//   final profileImageUrl = TextFieldBloc();
//
//   CreatePlayerFormBloc() {
//     addFieldBlocs(fieldBlocs: [
//       firstName,
//       lastName,
//       description,
//       points,
//       birthday,
//       isProfessional,
//       profileImageUrl
//     ]);
//   }
//
//   void addErrors() {
//     firstName.addFieldError('Awesome Error!');
//     lastName.addFieldError('Awesome Error!');
//     description.addFieldError('Awesome Error!');
//     points.addFieldError('Awesome Error!');
//     birthday.addFieldError('Awesome Error!');
//     isProfessional.addFieldError('Awesome Error!');
//     profileImageUrl.addFieldError('Awesome Error!');
//   }
//
//   @override
//   void onSubmitting() async {
//     try {
//       await createPlayer();
//       emitSuccess(canSubmitAgain: false);
//     } catch (e) {
//       emitFailure();
//     }
//   }
//
//   Future createPlayer() async {
//
//     // create the instance of the player
//     SinglePlayer player = SinglePlayer(
//         firstName: firstName.value,
//         lastName: lastName.value,
//         description: description.value,
//         points: points.valueToInt,
//         dateOfBirth: birthday.value,
//         isProfessional: isProfessional.value ? 1 : 0,
//         profileImageUrl: profileImageUrl.value
//     );
//
//     //define the params and send out request
//     final url = Uri.parse('http://internships-mobile.htec.co.rs/api/players');
//     final response = await http.post(
//       url,
//       headers: {
//         'accept': 'application/json',
//         'x-tournament-id': "10001",
//         'content-type': 'application/json'
//       },
//       body: jsonEncode(player),
//     );
//
//     // return the success value, maybe better to check the status code since
//     // we never know if there will be a server side failure, I left it like this
//     // for now
//     return jsonDecode(response.body)['success'];
//   }
// }