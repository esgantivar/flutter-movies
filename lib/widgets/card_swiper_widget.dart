import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> items;

  CardSwiper({@required this.items});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          items[index].uniqueId = '${items[index]}-card';
          return Hero(
              tag: items[index].id,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'detalle',
                          arguments: items[index]),
                      child: FadeInImage(
                          image: NetworkImage(items[index].posterImg()),
                          placeholder: AssetImage('assets/img/no-image.jpg'),
                          fit: BoxFit.cover))));
        },
        itemCount: items.length,
      ),
    );
  }
}
