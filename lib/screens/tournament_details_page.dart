import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../models/players_model.dart';
import '../../helper_widgets/layout.dart';
import '../../helper_classes/page_appbars.dart';

class TournamentDetailsPage extends StatefulWidget {
  final int tournamentId;

  const TournamentDetailsPage({
    Key? key,
    required this.tournamentId
  }) : super(key: key);

  @override
  State<TournamentDetailsPage> createState() => _TournamentDetailsPageState();
}

class _TournamentDetailsPageState extends State<TournamentDetailsPage> {

  late Future futurePlayers;

  Future fetchPlayersList() async {
    const url = 'http://internships-mobile.htec.co.rs/api/players';
    final response = await http.get(Uri.parse(url), headers: {"x-tournament-id":"${widget.tournamentId}"});

    if(response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      var parsed = decodedResponse['data'];
      List<Players> players = convertToPlayerModel(parsed);

      players.sort((b, a) => a.points.compareTo(b.points));
      return players;
    } else {
      throw Exception("Failed to load data");
    }
  }

  convertToPlayerModel(List responseData) {
    return List<Players>.from(responseData.map((i) => Players.fromJson(i)));
  }

  // sortPlayersByPoints(players) {
  //   var newMap = Map.fromEntries(originalMap.entries.toList()..sort((e1, e2) =>
  //       int.parse(e1.value["SortOrder"]).compareTo(int.parse(e2.value["SortOrder"]))));
  //   players as List;
  //   players.sort((a, b) => a.points.compareTo(b.points));
  // }

  @override
  void initState() {
    super.initState();
    print('new State');
    futurePlayers = fetchPlayersList();
  }

  @override
  Widget build(BuildContext context) {
    var appbar = PageAppBars.tournamentDetailsPage;
    appbar.tournamentId = widget.tournamentId;
    return Layout(
      appBar: appbar,
      body: FutureBuilder(
       future: futurePlayers,
        builder: (context, AsyncSnapshot snapshot) {
         if(snapshot.hasData) {
           List<dynamic> playersList = snapshot.data;
           return ListView.separated(
             separatorBuilder: (context, index) {
               return const Divider(height: 10);
             },
             padding: const EdgeInsets.all(20.0),
             itemCount: playersList.length,
             itemBuilder: (context, index) {
               Players player = playersList[index];
               return GestureDetector(
                 onTap: () {},
                 child: SizedBox(
                   height: 150,
                   child: Card(
                     elevation: 10,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 20, right: 20),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Text(
                             "${player.firstName} ${player.lastName}",
                             style: const TextStyle(
                               fontSize: 20
                             ),
                           ),
                           Text(
                               'Points: ${player.points}'
                           ),
                           Text(
                               player.isProfessional == 1 ?
                                 "Professional: Yes" :
                                 "Professional: No"
                           ),
                           if(player.tournamentId)
                             Text("Tournament ID: ${player.tournamentId}")
                         ],
                       ),
                     ),
                   ),
                 ),
               );
             },
           );
         } else if (snapshot.hasError) {
           return Text("${snapshot.error}");
         }

         return const Center(
           child: CircularProgressIndicator()
         );
        },
      )
    );
  }
}
