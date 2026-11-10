import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatelessWidget {
  Future<void> openOriginalArticle() async {
    final uri = Uri.tryParse(article.url);
    if (uri == null || (uri.scheme != 'https' && uri.scheme != 'http')) {
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  final Article article;
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Berita')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Utama Berita
            if (article.imageUrl.isNotEmpty)
              Image.network(
                article.imageUrl,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Icon(Icons.broken_image, size: 60)),
                  );
                },
              ),

            // 2. Informasi Berita dari Guru (Nama Sumber, Judul, Tanggal, & Deskripsi)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.sourceName,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tanggal publikasi: ${article.publishedAt}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.description.isEmpty
                        ? 'Deskripsi berita tidak tersedia.'
                        : article.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: openOriginalArticle,
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Baca Artikel Asli'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
