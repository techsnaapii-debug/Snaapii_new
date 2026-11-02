import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/article_api.dart';
import '../../services/auth_api.dart';
import '../../services/home_api.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  List<Map<String, dynamic>> _articles = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final articles = await ArticleApi.list(search: _searchController.text);
      if (mounted) setState(() => _articles = articles);
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _search(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), _load);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Articles'),
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF6B4EFF),
      elevation: 0,
    ),
    body: RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _searchController,
            onChanged: _search,
            decoration: InputDecoration(
              hintText: 'Search articles',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_loading)
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_error != null)
            _MessageCard(message: _error!, onRetry: _load)
          else if (_articles.isEmpty)
            const _MessageCard(message: 'No articles available yet.')
          else
            ..._articles.map(_articleCard),
        ],
      ),
    ),
  );

  Widget _articleCard(Map<String, dynamic> article) {
    final id = int.tryParse(article['id']?.toString() ?? '');
    final image = HomeApi.mediaUrl(article['banner_image']);
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: id == null
            ? null
            : () => Get.to(() => ArticleDetailScreen(articleId: id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              Image.network(
                image,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox(height: 0),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article['category_name']?.toString().isNotEmpty == true)
                    Text(
                      article['category_name'].toString(),
                      style: const TextStyle(color: Color(0xFF6B4EFF)),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    article['title']?.toString() ?? 'Article',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (article['description']?.toString().isNotEmpty ==
                      true) ...[
                    const SizedBox(height: 6),
                    Text(
                      article['description'].toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key, required this.articleId});
  final int articleId;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  Map<String, dynamic>? _article;
  int? _likes;
  bool _liked = false;
  bool _loading = true;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await Future.wait<Object>([
        ArticleApi.details(widget.articleId),
        ArticleApi.likeCount(widget.articleId),
      ]);
      if (mounted) {
        setState(() {
          _article = result[0] as Map<String, dynamic>;
          _likes = result[1] as int;
        });
      }
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggleLike() async {
    if (_sending) return;
    setState(() => _sending = true);
    try {
      final liked = await ArticleApi.setLiked(widget.articleId, !_liked);
      if (mounted) {
        setState(() {
          _liked = liked;
          _likes = (_likes ?? 0) + (liked ? 1 : -1);
        });
      }
    } on ApiException catch (error) {
      if (mounted) _notice(error.message);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _feedback(bool helpful) async {
    if (_sending) return;
    setState(() => _sending = true);
    try {
      await ArticleApi.submitFeedback(widget.articleId, helpful);
      if (mounted) _notice('Thanks for your feedback.');
    } on ApiException catch (error) {
      if (mounted) _notice(error.message);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _notice(String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    final article = _article;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF6B4EFF),
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: _MessageCard(message: _error!, onRetry: _load),
            )
          : article == null
          ? const Center(child: Text('Article not available.'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  article['title']?.toString() ?? 'Article',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (article['description']?.toString().isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  Text(article['description'].toString()),
                ],
                const SizedBox(height: 24),
                ...((article['sections'] as List?) ?? const [])
                    .whereType<Map>()
                    .map(
                      (section) => _section(Map<String, dynamic>.from(section)),
                    ),
                const Divider(height: 40),
                Row(
                  children: [
                    IconButton(
                      onPressed: _sending ? null : _toggleLike,
                      icon: Icon(
                        _liked ? Icons.favorite : Icons.favorite_border,
                      ),
                      color: const Color(0xFF6B4EFF),
                    ),
                    Text('${_likes ?? 0} likes'),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Was this article helpful?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _sending ? null : () => _feedback(true),
                      icon: const Icon(Icons.thumb_up_outlined),
                      label: const Text('Yes'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _sending ? null : () => _feedback(false),
                      icon: const Icon(Icons.thumb_down_outlined),
                      label: const Text('No'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _section(Map<String, dynamic> section) => Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section['heading']?.toString().isNotEmpty == true)
          Text(
            section['heading'].toString(),
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
          ),
        if (section['body']?.toString().isNotEmpty == true) ...[
          const SizedBox(height: 8),
          Text(section['body'].toString()),
        ],
        ...((section['bullet_points'] as List?) ?? const []).map(
          (point) => Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text('• $point'),
          ),
        ),
      ],
    ),
  );
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.message, this.onRetry});
  final String message;
  final Future<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 10),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ],
      ),
    ),
  );
}
