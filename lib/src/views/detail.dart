import 'package:flutter/material.dart';

import 'package:shop/src/models/article_model.dart';

import '../constants/constant.dart';

class Detail extends StatefulWidget {
  const Detail(this.data, {super.key});
  final ArticleModel? data;
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Detail',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Constant.BACK_COLOR),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.data?.imaeUrl ?? ''),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 8.0, left: 8.0, bottom: 20.0),
              child: Column(
                children: [
                  Text(
                    widget.data?.title ?? '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.data?.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Divider(
                    height: 2,
                    color: Constant.GRAY_COLOR,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.data?.context ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
