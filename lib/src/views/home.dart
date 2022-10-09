import 'package:flutter/material.dart';
import 'package:shop/src/constants/constant.dart';
import 'package:shop/src/services/net_service.dart';
import 'package:shop/src/views/all.dart';
import 'package:shop/src/views/detail.dart';
import 'package:shop/src/widgets/main_drawer.dart';

import '../models/article_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(
          'home',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Constant.BACK_COLOR),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hot',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => All('Hot',isShowAll:false ,)),
                      );
                    },
                    child: Text(
                      'See all',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Constant.GRAY_COLOR,
                          ),
                    ),
                  )
                ],
              ),
              FutureBuilder<List<ArticleModel>>(
                  future: NetService().getHotNew(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final data = snapshot.data?[index];
                            return _buildCards(data);
                          },
                          itemCount: snapshot.data?.length,
                        ),
                      );
                    }
                 
                    return Text('loading...');
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'For you',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => All('For you')),
                      );
                    },
                    child: Text(
                      'See all',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Constant.GRAY_COLOR,
                          ),
                    ),
                  )
                ],
              ),
              FutureBuilder<List<ArticleModel>>(
                  future: NetService().getArticle(),
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
          
                  return Text('loading...');
                  }),
            ],
          ),
        ),
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

  _buildCards(ArticleModel? data) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Detail(data)),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(5),
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(data?.imaeUrl ?? ''),
                      ),
                    ),
                    const Positioned(
                        top: 5,
                        right: 5,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text('HOT'),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  data?.title ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      );
}
