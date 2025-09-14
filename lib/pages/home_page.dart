// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; // <- kPrimary, kRadius, kBorder, AppColors

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Projects (store semantic color keys rather than hard Color(...) to allow theme tokens)
  final List<_ProjectData> _projects = [
    _ProjectData(name: 'Aranya', location: 'Mumbai, Maharashtra', pending: 20, total: 100, colorKey: 'greenLight'),
    _ProjectData(name: 'Mahalaxmi', location: 'Thane, Maharashtra', pending: 60, total: 100, colorKey: 'orangeLight'),
    _ProjectData(name: 'Vaikunth', location: 'Navi Mumbai, Maharashtra', pending: 70, total: 100, colorKey: 'blueLight'),
    _ProjectData(name: 'Revanta', location: 'Navi Mumbai, Maharashtra', pending: 50, total: 100, colorKey: 'yellowLight'),
  ];

  String _selectedProjectName = 'Aranya';

  // Use semantic bg keys for metric cards so colors resolve from theme at runtime
  final List<_MetricCardData> cards = [
    _MetricCardData(title: 'MAT', subtitle: 'Material Testing', pending: 10, total: 25, icon: Icons.science_outlined, bgKey: 'metricLight'),
    _MetricCardData(title: 'QA/RFIC', subtitle: 'Issue Management', pending: 5, total: 28, icon: Icons.build_outlined, bgKey: 'metricOrange'),
    _MetricCardData(title: 'NC', subtitle: 'Non Conformance', pending: 10, total: 25, icon: Icons.report_problem_outlined, bgKey: 'metricNeutral'),
    _MetricCardData(title: 'Audit', subtitle: 'Site Inspection', pending: 5, total: 25, icon: Icons.search_outlined, bgKey: 'metricSky'),
  ];

  _ProjectData get _selectedProject => _projects.firstWhere((p) => p.name == _selectedProjectName, orElse: () => _projects.first);

  @override
  Widget build(BuildContext context) {
    // Read theme extension tokens (fall back to constants if not provided)
    final appColors = Theme.of(context).extension<AppColors>();
    final borderColor = appColors?.border ?? kBorder;
    final primary = appColors?.primary ?? kPrimary;
    final selectionDark = appColors?.selectionDark ?? kSelectionDark;
    final selectionGreenLight = appColors?.selectionGreenLight ?? kSelectionGreenLight;
    final selectionSky = appColors?.selectionSky ?? kSelectionSky;
    final selectionOrange = appColors?.selectionOrange ?? kSelectionOrange;
    final selectionNeutral = appColors?.selectionNeutral ?? kSelectionNeutral;
    final selectionLight = appColors?.selectionLight ?? kSelectionLight;
    final selectionGrey = appColors?.selectionGrey ?? kSelectionGrey;
    final selectionWhite = appColors?.selectionWhite ?? kSelectionWhite;
    final selectionCharcoal = appColors?.selectionCharcoal ?? kSelectionCharcoal;

    // small helper map to resolve keys for project bg
    Color resolveProjectBg(String key) {
      switch (key) {
        case 'greenLight':
          return selectionGreenLight;
        case 'blueLight':
          return selectionSky.withOpacity(0.08);
        case 'orangeLight':
          return selectionOrange.withOpacity(0.06);
        case 'yellowLight':
          return selectionNeutral.withOpacity(0.08);
        default:
          return selectionLight;
      }
    }

    // resolve metric bg keys (used only as fallback for any non-hardcoded ones)
    Color resolveMetricBg(String key) {
      switch (key) {
        case 'metricOrange':
          return selectionOrange.withOpacity(0.12);
        case 'metricNeutral':
          return selectionNeutral.withOpacity(0.10);
        case 'metricSky':
          return selectionSky.withOpacity(0.10);
        case 'metricLight':
        default:
          return selectionLight.withOpacity(0.08);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white, // from app_theme
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpg', height: 128, width: 128, fit: BoxFit.contain),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh, color: selectionCharcoal)),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person, color: Colors.white, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                Text('dig2', style: TextStyle(color: selectionDark, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              _buildProjectSelector(borderColor),
              const SizedBox(height: 38),
              _buildHighlightedProject(_selectedProject, resolveProjectBg(_selectedProject.colorKey), borderColor),
              const SizedBox(height: 18),
              Column(
                children: cards
                    .map((c) => _metricCard(c, resolveMetricBg(c.bgKey), primary, selectionDark, selectionGrey, selectionWhite))
                    .toList(),
              ),
              const SizedBox(height: 16),
              _graphCard(primary, selectionDark, selectionGrey),
              const SizedBox(height: 20),
              _footerCard(primary, selectionGrey),
              const SizedBox(height: 10),
              Container(height: 4, width: 80, decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(8))),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectSelector(Color borderColor) {
    final current = _selectedProject;
    final appColors = Theme.of(context).extension<AppColors>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Projects', style: TextStyle(fontWeight: FontWeight.w600, color: appColors?.selectionDark ?? kSelectionDark)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _openProjectList,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: appColors?.selectionWhite ?? kSelectionWhite,
              borderRadius: BorderRadius.circular(kRadius),
              border: Border.all(color: borderColor),
              boxShadow: const [BoxShadow(color: Color(0x04000000), blurRadius: 6, offset: Offset(0, 4))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(current.name, style: TextStyle(fontWeight: FontWeight.w700, color: appColors?.selectionDark ?? kSelectionDark)),
                    const SizedBox(height: 6),
                    Text(current.location, style: TextStyle(color: appColors?.selectionGrey ?? kSelectionGrey)),
                  ]),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openProjectList() {
    final appColors = Theme.of(context).extension<AppColors>();
    final borderColor = appColors?.border ?? kBorder;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (ctx) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(height: 6, width: 60, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4))),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.of(ctx).pop(), icon: const Icon(Icons.arrow_back)),
                      const SizedBox(width: 8),
                      const Text('Back to Dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Align(alignment: Alignment.centerLeft, child: Text('Select Projects', style: TextStyle(fontWeight: FontWeight.w700))),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _projects.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, idx) {
                        final p = _projects[idx];
                        final isSelected = p.name == _selectedProjectName;
                        final appColorsLocal = Theme.of(context).extension<AppColors>();

                        // resolve highlighted project background using tokens (fallbacks are in app_theme.dart)
                        final bg = _resolveProjectBgFromKey(p.colorKey, appColorsLocal);

                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedProjectName = p.name);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: appColorsLocal?.selectionWhite ?? kSelectionWhite,
                              borderRadius: BorderRadius.circular(kRadius),
                              border: Border.all(color: isSelected ? (appColorsLocal?.primary ?? kPrimary) : borderColor, width: isSelected ? 2 : 1),
                              boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 6))],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(p.name, style: TextStyle(fontWeight: FontWeight.w800, color: appColorsLocal?.selectionDark ?? kSelectionDark)),
                                    const SizedBox(height: 6),
                                    Text(p.location, style: TextStyle(color: appColorsLocal?.selectionGrey ?? kSelectionGrey)),
                                  ]),
                                ),

                                // stacked counts: pending and total
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${p.pending}', style: TextStyle(color: (appColorsLocal?.primary ?? kPrimary), fontWeight: FontWeight.w800, fontSize: 16)),
                                    const SizedBox(height: 6),
                                    Text('${p.total}', style: TextStyle(color: appColorsLocal?.selectionGrey ?? kSelectionGrey)),
                                  ],
                                ),

                                const SizedBox(width: 12),

                                // percent indicator (right)
                                _projectPercentWidget(p.pending, p.total),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _resolveProjectBgFromKey(String key, AppColors? appColors) {
    // fallback colors are defined in your app_theme consts
    switch (key) {
      case 'greenLight':
        // prefer explicit green light token
        return appColors?.selectionGreenLight ?? kSelectionGreenLight;
      case 'blueLight':
        return appColors?.selectionSky?.withOpacity(0.08) ?? kSelectionSky.withOpacity(0.08);
      case 'orangeLight':
        return appColors?.selectionOrange?.withOpacity(0.06) ?? kSelectionOrange.withOpacity(0.06);
      case 'yellowLight':
        return appColors?.selectionNeutral?.withOpacity(0.08) ?? kSelectionNeutral.withOpacity(0.08);
      default:
        return appColors?.selectionLight ?? kSelectionLight;
    }
  }

  Widget _buildHighlightedProject(_ProjectData p, Color bg, Color borderColor) {
    final appColors = Theme.of(context).extension<AppColors>();
    final percent = p.total == 0 ? 0 : ((p.pending / p.total) * 100).toInt();
    final progress = p.total == 0 ? 0.0 : (p.pending / p.total);

    // pull from theme extension with fallback to constants
    final greenBg = appColors?.selectionGreenLight ?? kSelectionGreenLight; // subtle green background
    final border = appColors?.border ?? kBorder;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: greenBg, // background
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: border), // border
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(p.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: appColors?.selectionDark ?? kSelectionDark)),
          const SizedBox(height: 4),
          Text(p.location, style: TextStyle(color: appColors?.selectionGrey ?? kSelectionGrey, fontSize: 13)),
          const SizedBox(height: 14),

          Row(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${p.pending}', style: TextStyle(color: (appColors?.primary ?? kPrimary), fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text('Pending', style: TextStyle(color: appColors?.selectionGrey ?? kSelectionGrey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${p.total}', style: TextStyle(color: appColors?.selectionDark ?? kSelectionDark, fontWeight: FontWeight.w700, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text('Total', style: TextStyle(color: appColors?.selectionGrey ?? kSelectionGrey, fontSize: 12)),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$percent%', style: TextStyle(color: (appColors?.selectionGreen ?? kSelectionGreen), fontWeight: FontWeight.w700, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text('Complete', style: TextStyle(color: appColors?.selectionGrey ?? kSelectionGrey, fontSize: 12)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progress,
              backgroundColor: appColors?.border ?? kBorder,
              valueColor: AlwaysStoppedAnimation(appColors?.primary ?? kPrimary),
            ),
          ),
        ],
      ),
    );
  }

  /// METRIC CARD
  /// Hardcoded icon-box backgrounds & borders for MAT/QA/NC/Audit as requested.
  Widget _metricCard(
    _MetricCardData d,
    Color bgFromResolver,
    Color primary,
    Color selectionDark,
    Color selectionGrey,
    Color selectionWhite,
  ) {
    const hardBorder = Color(0xFFF3F4F6);

    // Override icon-box bg for each card according to your Figma values
    Color iconBoxBg;
    switch (d.title) {
      case 'MAT':
        iconBoxBg = const Color(0xFFFAF5FF); // #FAF5FF
        break;
      case 'QA/RFIC':
        iconBoxBg = const Color(0xFFFFF7ED); // #FFF7ED
        break;
      case 'NC':
        iconBoxBg = const Color(0xFFFEFCE8); // #FEFCE8
        break;
      case 'Audit':
        iconBoxBg = const Color(0xFFEFF6FF); // #EFF6FF
        break;
      default:
        iconBoxBg = bgFromResolver;
    }

    final double progress = d.total == 0 ? 0 : (d.pending / d.total);

    return Container(
     // margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4), 
      margin: const EdgeInsets.only(bottom: 20, top:20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: selectionWhite,
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: hardBorder),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 6))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconBoxBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: hardBorder),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(d.icon, color: primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(d.title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: selectionDark)),
                  const SizedBox(height: 4),
                  Text(d.subtitle, style: TextStyle(color: selectionGrey)),
                ]),
              ),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('${d.pending}', style: TextStyle(color: primary, fontWeight: FontWeight.w800, fontSize: 18)),
                const SizedBox(height: 4),
                Text('Pending', style: TextStyle(color: selectionGrey, fontSize: 12))
              ]),
              const SizedBox(width: 16),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('${d.total}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: selectionDark)),
                const SizedBox(height: 4),
                Text('Total', style: TextStyle(color: selectionGrey, fontSize: 12))
              ]),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: hardBorder,
              valueColor: AlwaysStoppedAnimation(primary),
            ),
          ),
        ],
      ),
    );
  }

  // Graph card: outer card stays white; icon box uses the requested pink bg
  Widget _graphCard(Color primary, Color selectionDark, Color selectionGrey) {
    const iconBg = Color(0xFFFEF2F2); // icon box bg only
    const iconBorder = Color(0xFFF3F4F6);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      decoration: BoxDecoration(
        color: kSelectionWhite,
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(kRadius),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 6))],
      ),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10), border: Border.all(color: iconBorder)),
          padding: const EdgeInsets.all(12),
          child: Icon(Icons.show_chart_outlined, color: primary),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text('Graph Dashboard', style: TextStyle(fontWeight: FontWeight.w700, color: selectionDark))),
        Icon(Icons.chevron_right, color: selectionGrey),
      ]),
    );
  }

  Widget _footerCard(Color primary, Color selectionGrey) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(color: kSelectionWhite, borderRadius: BorderRadius.circular(kRadius), boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 6))]),
      child: Column(children: [
        Text('An Innovation For You', style: TextStyle(color: selectionGrey)),
        const SizedBox(height: 8),
        Text('Qcop App Version: 1.0.9', style: TextStyle(color: primary, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text('SCA Infotech Private Limited', style: TextStyle(color: selectionGrey)),
      ]),
    );
  }

  Widget _projectPercentWidget(int pending, int total) {
    final pct = total == 0 ? 0 : ((pending / total) * 100).toInt();
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text('$pct%', style: TextStyle(color: kPrimary, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text('Complete', style: TextStyle(color: kSelectionGrey, fontSize: 12))
    ]);
  }
}

// Data models
class _MetricCardData {
  final String title;
  final String subtitle;
  final int pending;
  final int total;
  final IconData icon;
  final String bgKey; // semantic key -> resolved at render time
  const _MetricCardData({
    required this.title,
    required this.subtitle,
    required this.pending,
    required this.total,
    required this.icon,
    required this.bgKey,
  });
}

class _ProjectData {
  final String name;
  final String location;
  final int pending;
  final int total;
  final String colorKey; // semantic key -> resolve at runtime
  _ProjectData({
    required this.name,
    required this.location,
    required this.pending,
    required this.total,
    required this.colorKey,
  });
}
