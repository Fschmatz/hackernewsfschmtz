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
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.fromLTRB(15, 10, 15,10),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                side: BorderSide(
                  color: Colors.grey[850],
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 10),
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
                                  shimmerDuration: 3300,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Text("   ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Visibility(
                                  visible: index % 3 == 0,
                                  child: SkeletonAnimation(
                                    gradientColor: Colors.white38,
                                    shimmerColor: Colors.grey.withOpacity(0.4),
                                    shimmerDuration: 3320,
                                    borderRadius: BorderRadius.circular(5),
                                    child: Text("   ",
                                        style: TextStyle(
                                          fontSize: 16.5,
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                SkeletonAnimation(
                                  gradientColor: Colors.white38,
                                  shimmerColor: Colors.grey.withOpacity(0.5),
                                  shimmerDuration: 3360,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.article_outlined,
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Icon(
                                          Icons.arrow_upward_outlined,
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SkeletonAnimation(
                                      gradientColor: Colors.white38,
                                      shimmerColor:
                                      Colors.grey.withOpacity(0.5),
                                      shimmerDuration: 3360,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Text(
                                          "                      ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .hintColor)),
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
                                            size: 20,
                                            color: Theme.of(context)
                                                .hintColor,
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
                                        size: 20,
                                        color:
                                        Theme.of(context).hintColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
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
              ),
            );
          },
        ),
      ],
    );

  }
}
