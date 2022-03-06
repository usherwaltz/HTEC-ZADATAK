import 'package:flutter/material.dart';
import '../screens/blocs/players/players_repository.dart';
import '../models/player.dart';
import '../screens/widgets/app_bar/appbar_default.dart';
import '../screens/widgets/layout.dart';

class BracketsPage extends StatefulWidget {
  final int tournamentId;
  const BracketsPage({Key? key, required this.tournamentId}) : super(key: key);

  @override
  State<BracketsPage> createState() => _BracketsPageState();
}

class _BracketsPageState extends State<BracketsPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Layout(
            appBar: AppBarDefault(
              title: 'Brackets: ${widget.tournamentId}',
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: "Starting Bracket"),
                  Tab(text: "Eighth Finals"),
                  Tab(text: "Quarter Finals"),
                  Tab(text: "Semi Finals"),
                  Tab(text: "Final"),
                ],
              ),
              height: 100.0,
            ),
            body: TabBarView(
              children: [
                RoundOne(widget.tournamentId),
                const RoundHasNotStarted(),
                const RoundHasNotStarted(),
                const RoundHasNotStarted(),
                const RoundHasNotStarted()
              ],
            )
        )
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.strokeWidth = 3;
    paint.color = Colors.white;
    
    canvas.drawLine(
      Offset(size.width - size.width, size.height / 3.33),
      Offset(size.width, size.height * 1 / 2),
      paint
    );
    canvas.drawLine(
        Offset(size.width - size.width, size.height - size.height * 3.33),
        Offset(size.width, size.height * 1 / 2),
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RoundOne extends StatefulWidget {
  final int tournamentId;
  RoundOne(this.tournamentId, {Key? key}) : super(key: key);

  @override
  State<RoundOne> createState() => _RoundOneState();
}

class _RoundOneState extends State<RoundOne> with AutomaticKeepAliveClientMixin {
  final PlayersRepository _playersRepository = PlayersRepository();

  Future<List<List<Player>>> fetchBracket() async {
    return await _playersRepository.fetchBracketByTournamentId(widget.tournamentId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchBracket(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  Player playerHome = snapshot.data[index][0];
                  Player playerAway = snapshot.data[index][1];

                  return Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: ListTile(
                                    title: Text("${playerHome.firstName} ${playerHome.lastName}"),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: ListTile(
                                    title: Text("${playerAway.firstName} ${playerAway.lastName}"),
                                  ),
                                )
                              ],
                            )
                          ),
                          // CustomPaint(
                          //   foregroundPainter: LinePainter(),
                          // )
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RoundHasNotStarted extends StatelessWidget {
  const RoundHasNotStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Wait until this round stars"),
    );
  }
}


