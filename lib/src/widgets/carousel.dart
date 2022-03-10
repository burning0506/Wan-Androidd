import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          PageView(
            controller: _pageController,
            children: const <Widget>[
              BannerItem(
                  imageURL:
                      'https://img.iplaysoft.com/wp-content/uploads/2019/free-images/free_stock_photo.jpg'),
              BannerItem(
                  imageURL: 'http://static.runoob.com/images/demo/demo2.jpg'),
            ],
          ),
          Container(
            color: Colors.black26,
            padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
            child: Row(
              children: [
                const Expanded(
                    flex: 1, child: Text('第一张图片', style: TextStyle(color: Colors.white))),
                Expanded(
                  flex: 0,
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 5.0),
                        decoration: const ShapeDecoration(
                            color: Colors.red, shape: CircleBorder()),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const ShapeDecoration(
                            color: Colors.green, shape: CircleBorder()),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class BannerItem extends StatelessWidget {
  const BannerItem({Key? key, required this.imageURL}) : super(key: key);

  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageURL, fit: BoxFit.cover);
  }
}



// import 'package:json_annotation/json_annotation.dart';
//
// part 'article.g.dart';
//
// @JsonSerializable()
// class Article {
//
//   String apkLink;
//   int audit;
//   String author;
//   bool canEdit;
//   int chapterId;
//   String chapterName;
//   bool collect;
//   int courseId;
//   String desc;
//   String descMd;
//   String envelopePic;
//   bool fresh;
//   String host;
//   int id;
//   String link;
//   String niceDate;
//   String niceShareDate;
//   String origin;
//   String prefix;
//   String projectLink;
//   int publishTime;
//   int realSuperChapterId;
//   int selfVisible;
//   int shareDate;
//   String shareUser;
//   int superChapterId;
//   String  superChapterName;
//   List<Tag> tags;
//   String title;
//   int type;
//   int userId;
//   int visible;
//   int zan;
//
//   Article(
//       this.apkLink,
//       this.audit,
//       this.author,
//       this.canEdit,
//       this.chapterId,
//       this.chapterName,
//       this.collect,
//       this.courseId,
//       this.desc,
//       this.descMd,
//       this.envelopePic,
//       this.fresh,
//       this.host,
//       this.id,
//       this.link,
//       this.niceDate,
//       this.niceShareDate,
//       this.origin,
//       this.prefix,
//       this.projectLink,
//       this.publishTime,
//       this.realSuperChapterId,
//       this.selfVisible,
//       this.shareDate,
//       this.shareUser,
//       this.superChapterId,
//       this.superChapterName,
//       this.tags,
//       this.title,
//       this.type,
//       this.userId,
//       this.visible,
//       this.zan);
//
//   factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ArticleToJson(this);
//
// }
//
// @JsonSerializable()
// class Tag {
//
//   String name;
//   String url;
//
//   Tag(this.name, this.url);
//
//   factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
//
//   Map<String, dynamic> toJson() => _$TagToJson(this);
//
// }