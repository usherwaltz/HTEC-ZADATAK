import 'package:flutter/material.dart';
import 'widgets/layout.dart';
import 'widgets/home_page/tournament_card.dart';
import 'widgets/app_bar/page_appbars.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  List tournaments = [];
  bool loading = false, allLoaded = false;

  /// This function mocks a API data fetch */
  fetchTournaments({pullToRefresh = false}) async {
    if(pullToRefresh) {
      setState(() {
        allLoaded = false;
      });
      tournaments.clear();
    }

    if(allLoaded) {
      return;
    }
    
    setState(() {
      loading = true;
    });
    
    await Future.delayed(const Duration(milliseconds: 500));
    List<int> newData = tournaments.length >= 60 ? [] : List.generate(20, (index) => index);
    if (newData.isNotEmpty) {
      tournaments.addAll(newData);
    }

    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  /// Pull To Refresh CallBack //
  Future<dynamic>ptrCallBack() async {
    fetchTournaments(pullToRefresh: true);
  }

  @override
  void initState() {
    super.initState();
    fetchTournaments();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading) {
        fetchTournaments();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        appBar: PageAppBars.homePage,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if(tournaments.isNotEmpty) {
              return Stack(
                children: [
                 RefreshIndicator(
                   onRefresh: ptrCallBack,
                   child:  ListView.separated(
                       controller: _scrollController,
                       separatorBuilder: (context, index) {
                         return const Divider(height: 10);
                       },
                       padding: const EdgeInsets.all(20.0),
                       itemCount: tournaments.length + (allLoaded?1:0),
                       itemBuilder: (context, index) {
                         if(index < tournaments.length) {
                           var tournamentId = index + 10001;
                           return TournamentCard(
                               tournamentId: tournamentId
                           );
                         } else {
                           return SizedBox(
                             width: constraints.maxWidth,
                             height: 50,
                             child: const Center(
                               child: Text(
                                 "All tournaments loaded",
                                 style: TextStyle(
                                     fontSize: 20
                                 ),
                               ),
                             ),
                           );
                         }
                       }
                   )
                 ),
                  if(loading)
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          height: 80,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                    )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
    );
  }
}
