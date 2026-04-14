import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/game_provider.dart';
import '../providers/favorite_provider.dart'; // Importamos o novo Provider aqui!
import '../models/game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.gamepad, color: Color(0xFFE52521)),
            const SizedBox(width: 8),
            const Text(
              'N64 CLASSICS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 3.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFF0072CE)),
            onPressed: () {},
          )
        ],
      ),
      body: Consumer<GameProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFE52521)),
            );
          }

          if (provider.games.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum jogo encontrado.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.70,
            ),
            itemCount: provider.games.length,
            itemBuilder: (context, index) {
              final game = provider.games[index];
              return _buildModernRetroCard(game); 
            },
          );
        },
      ),
    );
  }

  Widget _buildModernRetroCard(Game game) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A4A4A),
            Color(0xFF2A2A2A),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Imagem da Capa
            game.imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: game.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white24,
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white24,
                      size: 50,
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: Colors.white24,
                    ),
                  ),

            // 2. Botão de Favorito MÁGICO (Substituímos aqui!)
            Positioned(
              top: 8,
              right: 8,
              child: Consumer<FavoriteProvider>(
                builder: (context, favProvider, child) {
                  final isFavorite = favProvider.isFavorite(game.id);

                  return GestureDetector(
                    onTap: () {
                      favProvider.toggleFavorite(game.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFFF2BA16),
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 3. Faixa preta com nome e nota
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFF2BA16), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          game.rating.toString(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
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