import 'package:flutter/material.dart';

// Colors & tokens - replace with your app_theme values if you have them
const Color kPrimary = Color(0xFFEF4A23); // orange used in screenshot
const double kRadius = 12.0;
const double kCardElevation = 2.0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Example dynamic values (you can populate from API)
  int totalPending = 43;
  int totalItems = 191;

  final List<_MetricCardData> cards = [
    _MetricCardData(
      title: 'MAT',
      subtitle: 'Material Testing2222',
      pending: 5,
      total: 28,
      icon: Icons.science_outlined,
      bg: Color(0xFFF6E9FF),
    ),
    _MetricCardData(
      title: 'Snag',
      subtitle: 'Issue Management',
      pending: 8,
      total: 32,
      icon: Icons.build_outlined,
      bg: Color(0xFFFFF3EA),
    ),
    _MetricCardData(
      title: 'NC',
      subtitle: 'Non Conformance',
      pending: 15,
      total: 67,
      icon: Icons.report_problem_outlined,
      bg: Color(0xFFFFF9E6),
    ),
    _MetricCardData(
      title: 'Audit',
      subtitle: 'Site Inspection',
      pending: 3,
      total: 19,
      icon: Icons.search_outlined,
      bg: Color(0xFFEFF7FF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          children: [
            // logo - use your asset logo
            Image.asset('assets/images/logo.jpg', height: 36, width: 36, fit: BoxFit.contain),
            const SizedBox(width: 12),
            const Text(
              'Piramal',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 6),
            const Text('Realty', style: TextStyle(color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // refresh action
            },
            icon: const Icon(Icons.refresh, color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: kPrimary, shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person, color: Colors.white, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('dig2', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // Top summary pills
              Row(
                children: [
                  Expanded(child: _buildSummaryCard('Total Pending', totalPending.toString())),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSummaryCard('Total Items', totalItems.toString())),
                ],
              ),

              const SizedBox(height: 18),

              // Selected project / site card
              _siteCard(),

              const SizedBox(height: 18),

              // Metric cards list
              Column(
                children: cards.map((c) => _metricCard(c)).toList(),
              ),

              const SizedBox(height: 16),

              // Graph Dashboard card
              _graphCard(),

              const SizedBox(height: 20),

              // Footer app/version card
              _footerCard(),

              const SizedBox(height: 10),

              // small bottom indicator bar like screenshot
              Container(height: 4, width: 80, decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(8))),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kRadius),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          // decorative left curve like screenshot
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _siteCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: const Color(0xFFF0A899)),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 6))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Left content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Construction Site A', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                SizedBox(height: 6),
                Text('Mumbai, Maharashtra', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          // Active pill + chevron
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: Colors.green[600], borderRadius: BorderRadius.circular(20)),
            child: const Text('Active', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _metricCard(_MetricCardData d) {
    final double progress = d.total == 0 ? 0 : (d.pending / d.total);
    final progressPercent = (progress * 100).toInt();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kRadius),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 6))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // icon container
              Container(
                decoration: BoxDecoration(color: d.bg, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(12),
                child: Icon(d.icon, color: kPrimary),
              ),
              const SizedBox(width: 12),

              // title/subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(d.subtitle, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),

              // pending/total
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${d.pending}', style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text('${d.total}\nTotal', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                ],
              ),

              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 12),

          // progress bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFF1F1F1),
                    valueColor: const AlwaysStoppedAnimation(kPrimary),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('$progressPercent%', style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _graphCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kRadius),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 6))],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: const Color(0xFFFFEAE8), borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.show_chart_outlined, color: kPrimary),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Text('Graph Dashboard', style: TextStyle(fontWeight: FontWeight.w700))),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _footerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kRadius),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 6))],
      ),
      child: Column(
        children: const [
          Text('An Innovation For You', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Qcop App Version: 1.0.9', style: TextStyle(color: kPrimary, fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          Text('SCA Infotech Private Limited', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _MetricCardData {
  final String title;
  final String subtitle;
  final int pending;
  final int total;
  final IconData icon;
  final Color bg;

  const _MetricCardData({
    required this.title,
    required this.subtitle,
    required this.pending,
    required this.total,
    required this.icon,
    required this.bg,
  });
}
