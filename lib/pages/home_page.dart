import 'package:flutter/material.dart';
import 'package:ghibli/controllers/get_movies.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/pages/movies_page.dart';
import 'package:ghibli/pages/user_movie_list_page.dart';
import 'package:ghibli/repositories/movies_remote_data_source.dart';
import 'package:ghibli/repositories/movies_local_data_source.dart';
import 'package:ghibli/repositories/movies_repository_impl.dart';
import 'package:ghibli/services/hive_service_impl.dart';
import 'package:ghibli/services/http_service_impl.dart';
import 'package:ghibli/widgets/animated_appbar_widget.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool lastStatus = true;
  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  final GetMovies _controller = GetMovies(
    MoviesRepositoryImpl(
      MoviesRemoteDataSourceImpl(
        httpService: HttpServiceImpl(),
      ),
      MoviesLocalDataSourceImpl(
        hiveService: HiveServiceImpl(),
      ),
    ),
  );

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween =
        ColorTween(begin: Colors.transparent, end: Color.fromARGB(255, 0, 0, 0))
            .animate(_colorAnimationController);
  }

  bool scrollListener(ScrollNotification scrollInfo) {
    bool scroll = false;
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 600);
      return scroll = true;
    }
    return scroll;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: scrollListener,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: ValueListenableBuilder<List<Movie>?>(
                    valueListenable: _controller.movies,
                    builder: (__, movies, _) {
                      return movies != null
                          ? [
                              MoviesPage(movies: movies),
                              Center(),
                              UserList(movies: movies)
                            ][_selectedIndex]
                          : Center(child: CircularProgressIndicator());
                    }),
              ),
              AnimatedAppBar(
                colorAnimationController: _colorAnimationController,
                colorTween: _colorTween,
                items: _controller.movies.value,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 8, 8, 8)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              hoverColor: Colors.grey,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey.shade700.withOpacity(0.2),
              color: Colors.white,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.queue_music,
                  text: 'Songs',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'My List',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
