import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/constant.dart';
import '../models/article_model.dart';
import '../services/net_service.dart';
import 'detail.dart';

class All extends StatefulWidget {
  const All(this.title, {this.isShowAll = true, super.key});
  final String? title;
  final bool? isShowAll;
  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.title ?? '',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Constant.BACK_COLOR),
      )),
      body: Column(
        children: [
          FutureBuilder<List<ArticleModel>>(
              future: widget.isShowAll!
                  ? NetService().getArticle()
                  : NetService().getHotNew(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = snapshot.data?[index];
                      return _buildCardListView(data);
                    },
                    itemCount: snapshot.data?.length,
                  );
                }
                if (snapshot.hasError) {}
                return CircularProgressIndicator();
              }),
        ],
      ),
    );
  }

  _buildCardListView(ArticleModel? data) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Detail(data)),
          );
        },
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(data?.imaeUrl ?? ''),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  data?.title ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
}
