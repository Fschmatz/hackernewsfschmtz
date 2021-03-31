import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(27, 0, 0, 0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'HN  ',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: " ",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: index == 0
                    ? const EdgeInsets.fromLTRB(15, 0, 15, 8)
                    : const EdgeInsets.fromLTRB(15, 8, 15, 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
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
                                        fontSize: 16.5,
                                      )),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Visibility(
                                  visible: index % 2 == 0,
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
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(17, 0, 0, 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.text_snippet_outlined,
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Icon(
                                          Icons.arrow_upward_outlined,
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SkeletonAnimation(
                                        gradientColor: Colors.white38,
                                        shimmerColor:
                                            Colors.grey.withOpacity(0.5),
                                        shimmerDuration: 3360,
                                        borderRadius: BorderRadius.circular(5),
                                        child: Text(
                                            "                               ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .hintColor)),
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
                                                  size: 17.5,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                                const SizedBox(
                                                  width: 40,
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
                                              size: 19,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                        ],
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
