import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'feed_controller.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key key, this.title = "Feed"}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 16, left: 16),
              child: Text(
                "Destaques",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Observer(builder: (_) {
              if (controller.highlightsRequestStatus == RequestStatus.waiting) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (controller.highlightsRequestStatus == RequestStatus.error) {
                return Text(
                    "Houve um erro buscando as notícias em destaque. Insira uma bela imagem de feedback aqui com sua imaginação.");
              } else if (controller.highlightsRequestStatus == RequestStatus.initial) {
                return Container();
              }

              if (controller.highlights != null)
                return SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.highlights.length,
                      itemBuilder: (_, index) {
                        final news = controller.highlights[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            news.imageUrl != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          news.imageUrl,
                                          width: 128,
                                          height: 128,
                                          fit: BoxFit.fitHeight,
                                        )),
                                  )
                                : Container(),
                            Container(
                              width: 174,
                              child: Column(
                                children: [
                                  Text(
                                    news.title,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.bookmark_border_outlined),
                                        onPressed: () => null,
                                      ),
                                      Text(controller.timeFrom(news.publishedAt) + " horas atrás"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ));
              else
                return Text(
                    "A lista está vazia, mas voce pode encará-la como 'cheia de nada', se te fizer se sentir melhor <3");
            }),
          ],
        ),
      ),
    );
  }
}
