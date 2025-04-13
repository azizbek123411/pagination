import 'package:flutter/material.dart';
import 'package:flutter_application_1/pagination/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostPage extends ConsumerStatefulWidget {
  const PostPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      ref.read(postProvider.notifier).fetchMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postProvider);
    final postNotifier = ref.read(postProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) => postNotifier.search(value),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => postNotifier.refresh(),
                child: ListView.builder(
                    controller: controller,
                    itemCount: posts.length + (postNotifier.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < posts.length) {
                        final post = posts[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
          ],
        ));
  }
}
