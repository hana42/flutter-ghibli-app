import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/pages/profile_page.dart';
import 'package:ghibli/widgets/custom_search.dart';

class AnimatedAppBar extends StatelessWidget {
  final AnimationController colorAnimationController;
  final Animation colorTween;
  final List<Movie>? items;

  const AnimatedAppBar({
    Key? key,
    required this.colorAnimationController,
    required this.colorTween,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: AnimatedBuilder(
        animation: colorAnimationController,
        builder: (context, child) => AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: colorTween.value,
          elevation: 0,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.cast)),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        searchLabel: 'Search movies',
                        suggestion: Center(
                          child: Text(
                              'Filter movie by name, characters or date released'),
                        ),
                        failure: Center(
                          child: Text('No movies found :('),
                        ),
                        filter: (e) => [
                          e.title,
                          e.overview.toString(),
                          e.releaseDate!.year.toString()
                        ],
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ProfilePage(),
                      ),
                    );

                    // Navigator.pushReplacementNamed(context, '/profile');
                  },
                  child: Image.asset(
                    'assets/icons/nausicaaofthevalleyofthewind.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
