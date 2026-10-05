import 'package:flutter/material.dart';

import '../models/message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<MessageModel> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Pesan sambutan otomatis
    _messages.addAll([
      MessageModel(
        id: '1',
        text: 'Halo! Selamat datang di Mercedes Showroom 🚗',
        isMe: false,
        timestamp: DateTime.now(),
      ),
      MessageModel(
        id: '2',
        text: 'Ada yang bisa saya bantu terkait mobil Mercedes?',
        isMe: false,
        timestamp: DateTime.now(),
      ),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ===== KIRIM PESAN =====
  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );
      _controller.clear();
    });

    _scrollToBottom();

    // Auto-reply dari "seller"
    _autoReply(text);
  }

  // ===== AUTO-REPLY =====
  void _autoReply(String userMessage) {
    // Tampilkan indikator "typing"
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _isTyping = true);
      _scrollToBottom();
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      String reply;
      final lower = userMessage.toLowerCase();

      if (lower.contains('harga') || lower.contains('price')) {
        reply = 'Untuk harga, S-Class mulai dari Rp 3.5 M, G-Class Rp 4.8 M, dan AMG GT Rp 5.2 M. Mau tipe yang mana? 😊';
      } else if (lower.contains('s-class') || lower.contains('s class')) {
        reply = 'Mercedes-Benz S-Class adalah sedan flagship kami dengan mesin 3.0L V6 Turbo dan top speed 250 km/h. Stok tersedia 5 unit!';
      } else if (lower.contains('g-class') ||
          lower.contains('g class') ||
          lower.contains('gwagon')) {
        reply = 'G-Class SUV ikonik! Mesin 4.0L V8 Biturbo, top speed 220 km/h. Cocok untuk off-road dan gaya. Stok hanya 2 unit!';
      } else if (lower.contains('test drive') || lower.contains('testdrive')) {
        reply = 'Test drive bisa dijadwalkan setiap hari 09.00-17.00. Silakan sebutkan tanggal dan tipe mobil yang ingin Anda coba ya! 🚗';
      } else if (lower.contains('cicilan') ||
          lower.contains('kredit') ||
          lower.contains('leasing')) {
        reply = 'Kami menyediakan cicilan mulai dari 1.5% per bulan dengan DP minimal 20%. Bisa tenor 1-5 tahun.';
      } else if (lower.contains('promo') || lower.contains('diskon')) {
        reply = 'Promo bulan ini: diskon hingga Rp 500 juta + gratis aksesoris original Mercedes! Berlaku sampai 31 Des 2025.';
      } else if (lower.contains('terima kasih') ||
          lower.contains('makasih') ||
          lower.contains('thanks')) {
        reply =
            'Sama-sama! Senang bisa membantu 😊 Ada lagi yang bisa saya bantu?';
      } else if (lower.contains('halo') ||
          lower.contains('hai') ||
          lower.contains('hello')) {
        reply =
            'Halo juga! Ada yang bisa saya bantu terkait mobil Mercedes? 🚗';
      } else {
        reply = 'Baik, saya catat pertanyaannya. Tim kami akan segera menghubungi Anda untuk info lebih detail ya 🙏';
      }

      setState(() {
        _isTyping = false;
        _messages.add(
          MessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: reply,
            isMe: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  // ===== SCROLL KE BAWAH =====
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFF00ADEF),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1A1A1A),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller Mercedes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.greenAccent),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showSnack('Fitur telepon'),
            icon: const Icon(Icons.call, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _showSnack('Fitur menu'),
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // ===== QUICK REPLY CHIPS =====
          if (_messages.length <= 2)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: const Color(0xFF1A1A1A),
              child: SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _quickChip('Harga S-Class'),
                    _quickChip('Test drive'),
                    _quickChip('Promo bulan ini'),
                    _quickChip('Cicilan'),
                  ],
                ),
              ),
            ),

          // ===== LIST PESAN =====
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                // Indikator typing
                if (index == _messages.length) {
                  return _buildTypingIndicator();
                }

                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),

          // ===== INPUT PESAN =====
          _buildInputArea(),
        ],
      ),
    );
  }

  // ===== BUBBLE PESAN =====
  Widget _buildMessageBubble(MessageModel msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: msg.isMe ? const Color(0xFF00ADEF) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
            bottomRight: Radius.circular(msg.isMe ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg.formattedTime,
                  style: const TextStyle(color: Colors.white60, fontSize: 10),
                ),
                if (msg.isMe) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all, color: Colors.white70, size: 14),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===== TYPING INDICATOR =====
  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(0),
            const SizedBox(width: 4),
            _dot(150),
            const SizedBox(width: 4),
            _dot(300),
          ],
        ),
      ),
    );
  }

  Widget _dot(int delayMs) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 600 + delayMs),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  // ===== INPUT AREA =====
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: const Color(0xFF1A1A1A),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Tombol attachment
            IconButton(
              onPressed: () => _showSnack('Fitur lampiran'),
              icon: const Icon(Icons.attach_file, color: Colors.white54),
            ),
            // Text field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                  decoration: const InputDecoration(
                    hintText: 'Ketik pesan...',
                    hintStyle: TextStyle(color: Colors.white54),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            // Tombol kirim
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF00ADEF),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== QUICK REPLY CHIP =====
  Widget _quickChip(String label) {
    return GestureDetector(
      onTap: () {
        _controller.text = label;
        _sendMessage();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F0F),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF00ADEF), width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF00ADEF),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ===== SNACKBAR HELPER =====
  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF00ADEF),
      ),
    );
  }
}
