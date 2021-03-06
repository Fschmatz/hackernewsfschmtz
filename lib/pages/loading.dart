import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Loading extends StatelessWidget {

  String pageName;
  Loading({Key key,this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 3, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(18, 15, 18, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SkeletonAnimation(
                                gradientColor: Colors.white38,
                                shimmerColor: Colors.grey.withOpacity(0.2),
                                shimmerDuration: 3550,
                                borderRadius: BorderRadius.circular(5),
                                child: Text("   ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Visibility(
                                visible: index % 2 == 0,
                                child: SkeletonAnimation(
                                  gradientColor: Colors.white38,
                                  shimmerColor: Colors.grey.withOpacity(0.4),
                                  shimmerDuration: 3980,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Text("   ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SkeletonAnimation(
                                gradientColor: Colors.white38,
                                shimmerColor: Colors.grey.withOpacity(0.5),
                                shimmerDuration: 4360,
                                borderRadius: BorderRadius.circular(5),
                                child: Text("   ",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).hintColor)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.article_outlined,
                                        color: Theme.of(context).hintColor.withOpacity(0.6),
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Theme.of(context).hintColor.withOpacity(0.6),
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        color: Theme.of(context).hintColor.withOpacity(0.6),
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 40,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.comment_outlined,
                                        size: 21,
                                        color: Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Theme.of(context).cardTheme.color,
                                        onPrimary: Theme.of(context).accentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 40,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.share_outlined,
                                        size: 21,
                                        color:
                                        Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Theme.of(context).cardTheme.color,
                                        onPrimary: Theme.of(context).accentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );

  }
}

//margin: const EdgeInsets.fromLTRB(15, 10, 15,10),