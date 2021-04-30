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
          separatorBuilder: (BuildContext context, int index) => Divider(height: 8,),
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
                                shimmerDuration: 3800,
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
                                  shimmerDuration: 3820,
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
                                shimmerDuration: 3860,
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
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.comment_outlined,
                                          size: 21,
                                          color: Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
                                        ),
                                        const SizedBox(
                                          width: 48,
                                        ),
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    minWidth: 0,
                                    child: Icon(
                                      Icons.share_outlined,
                                      size: 21,
                                      color:
                                      Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
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