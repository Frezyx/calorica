import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.82,
          width: size.width,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'СРЕДА 17 ЯНВАРЯ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: theme.primaryColor,
                            ),
                          ),
                          Text(
                            'Вин Дизель',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Container(
            height: 70,
            width: 70,
            transform: Matrix4.translationValues(0.0, -35, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  'https://n1s2.hsmedia.ru/58/4f/51/584f51161e2d2aa53e40503a45f03545/300x300_21_af5d655946ce349d411ea78072f08329@681x1024_0xc0a839a2_1989400291463495968.jpeg',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
