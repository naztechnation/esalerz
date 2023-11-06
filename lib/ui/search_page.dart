import 'package:flutter/material.dart';
import '../res/app_colors.dart';
import 'widgets/text_edit_view.dart';

class SearchPage extends StatefulWidget {
  final List<String> postsLists;
  const SearchPage({super.key, required this.postsLists});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

bool showother = false;

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  List<String> postsList = [];

  @override
  void initState() {
    postsList = widget.postsLists;
    super.initState();
  }

  void searchPostList(String query) {
    setState(() {
      postsList = widget.postsLists
          .where((posts) => posts.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.lightPrimary,
                          size: 25,
                        ),
                      )),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: const Text(
                    "Search Esalers",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: const SizedBox(
                    width: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: TextEditView(
                    controller: searchController,
                    hintText: 'Search your service here...',
                    filled: false,
                    autofocus: false,
                    isDense: true,
                    onChanged: (query) {
                      searchPostList(query);
                    },
                    suffixIcon: GestureDetector(
                        onTap: () {
                          searchController.clear();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 25,
                          color: AppColors.lightPrimary,
                        )),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.search),
                    ),
                    borderColor: AppColors.lightPrimary,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightPrimary,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search Results",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8.0),
                Text(
                  "(${postsList.length})",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    if (postsList.isNotEmpty) ...[
                      ListView.builder(
                          itemCount: postsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () {
                                // AppNavigator.pushAndStackPage(context,
                                //     page: MovieDetailsScreen(
                                //       videoLinks: postsList[index].videoLink!,
                                //       postId: postsList[index].id!,
                                //     ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        postsList[index],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Padding(
                                      padding: EdgeInsets.only(right: 12.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ] else ...[
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "No data for this search",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              "We’re sorry, the keyword you  were looking for could not be found. Please search with another keywords.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
