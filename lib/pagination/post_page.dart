import 'package:flutter/material.dart';
import 'package:flutter_application_1/pagination/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostPage extends ConsumerStatefulWidget {
  const PostPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {


  final controller=ScrollController();


@override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }


  void scrollListener(){
    if(controller.position.pixels>=controller.position.maxScrollExtent-200){
      ref.read(postProvider.notifier).fetchMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts=ref.watch(postProvider);
    return Scaffold(
appBar: AppBar(title: Text('Posts'),),
body:RefreshIndicator(
  onRefresh: ()async =>ref.read(postProvider.notifier).refresh(),
  child: ListView.builder(
    controller: controller,
    itemCount: posts.length,
    itemBuilder: (context,index){
    final post=posts[index];
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.body),
    );
  }),
)
    );
  }
}