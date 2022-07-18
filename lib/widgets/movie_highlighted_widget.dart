import 'package:flutter/material.dart';
import 'package:ghibli/models/movie_model.dart';
import 'package:ghibli/pages/movie_details_page.dart';
import 'package:ghibli/widgets/vertical_icon_button.dart';

class MovieHighlightedWidget extends StatelessWidget {
  final Movie movie;
  final String assetImage;
  final String assetTitle;
  const MovieHighlightedWidget(
      {Key? key,
      required this.movie,
      required this.assetImage,
      required this.assetTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movies: movie),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: const [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  assetImage,
                  fit: BoxFit.fitWidth,
                  color: Color.fromARGB(255, 177, 0, 0).withOpacity(0.45),
                  colorBlendMode: BlendMode.overlay,
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    assetTitle,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // AddToListButton(
                          //   movie: movie,
                          //   hasTitle: true,
                          // ),
                          VerticalIconButton(
                              icon: Icons.play_arrow,
                              title: 'Watch',
                              onTap: () {}),
                          // TextButton.icon(
                          //   icon: Icon(
                          //     Icons.play_circle_fill,
                          //     color: Colors.black,
                          //     size: 24,
                          //   ),
                          //   onPressed: () {
                          //     // ignore: avoid_print
                          //     print('Play');
                          //   },
                          //   label: Text(
                          //     'Play'.toUpperCase(),
                          //     style:
                          //         TextStyle(color: Colors.black, fontSize: 18),
                          //   ),
                          //   style: ButtonStyle(
                          //     fixedSize: MaterialStateProperty.all<Size>(
                          //         Size(100, 30)),
                          //     backgroundColor: MaterialStateProperty.all<Color>(
                          //         Colors.white),
                          //   ),
                          // ),
                          VerticalIconButton(
                            icon: Icons.info_outline,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailsPage(movies: movie),
                                ),
                              );
                            },
                            title: 'Info',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
