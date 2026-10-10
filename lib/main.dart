import 'package:flutter/material.dart';

void main() => runApp(const MashhadApp());

const bg = Color(0xFF0B0E14);
const panel = Color(0xFF171C26);
const accent = Color(0xFF3478F6);
const muted = Color(0xFF9AA4B2);

class MashhadApp extends StatelessWidget {
  const MashhadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sara cinama',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.dark),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class TitleItem {
  final String name, type, year, rating, description;
  final Color color;
  const TitleItem(this.name, this.type, this.year, this.rating, this.description, this.color);
}

const items = <TitleItem>[
  TitleItem('رحلة أخيرة', 'فيلم', '2025', '8.4', 'مغامرة مشوّقة عن رحلة تغيّر حياة أبطالها إلى الأبد.', Color(0xFF7D3C98)),
  TitleItem('مدينة الظلال', 'مسلسل', '2026', '9.1', 'أسرار مدينة صغيرة تبدأ بالظهور بعد حادث غامض.', Color(0xFF174A68)),
  TitleItem('خط النار', 'فيلم', '2024', '7.8', 'فريق إنقاذ يواجه سباقاً مع الوقت لإنقاذ العالقين.', Color(0xFF9C4A28)),
  TitleItem('ما وراء البحر', 'مسلسل', '2025', '8.6', 'دراما إنسانية عن العائلة والاختيارات الصعبة.', Color(0xFF176B62)),
  TitleItem('المهمة صفر', 'فيلم', '2023', '7.9', 'عميل سابق يعود في مهمة لا تحتمل الخطأ.', Color(0xFF455A64)),
  TitleItem('أيام بعيدة', 'مسلسل', '2024', '8.2', 'حكايات متشابكة تجمع أصدقاء فرّقتهم السنوات.', Color(0xFF795548)),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;
  String category = 'الكل';
  String query = '';
  final searchController = TextEditingController();
  final saved = <String>{};

  List<TitleItem> get filtered => items.where((x) {
    final matchCategory = category == 'الكل' || x.type == category;
    final matchQuery = x.name.contains(query.trim());
    final matchSaved = tab != 2 || saved.contains(x.name);
    return matchCategory && matchQuery && matchSaved;
  }).toList();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSaved = tab == 2;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                child: Row(children: [
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.play_arrow_rounded, size: 32, color: Colors.white)),
                  const SizedBox(width: 10),
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('مشهد', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, letterSpacing: -.5)),
                    Text('أفلام ومسلسلات تستحق وقتك', style: TextStyle(fontSize: 12, color: muted)),
                  ])),
                  IconButton(onPressed: () => _showInfo(context), icon: const Icon(Icons.info_outline_rounded, color: muted)),
                ]),
              )),
              SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: TextField(
                  controller: searchController,
                  onChanged: (v) => setState(() => query = v),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن فيلم أو مسلسل...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true, fillColor: panel,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              )),
              if (tab == 0 && query.isEmpty)
                SliverToBoxAdapter(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => _details(context, items[1]),
                    child: Container(
                      height: 190, padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft,
                          colors: [Color(0xFF2859A8), Color(0xFF20283B), Color(0xFF422449)]),
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(.14), borderRadius: BorderRadius.circular(30)),
                          child: const Text('اختيار الأسبوع', style: TextStyle(fontSize: 11))),
                        const SizedBox(height: 9),
                        const Text('مدينة الظلال', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                        const Text('مسلسل  •  2026  •  ★ 9.1', style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 12),
                        const Row(children: [Icon(Icons.play_circle_fill_rounded, size: 25), SizedBox(width: 7), Text('اكتشف التفاصيل', style: TextStyle(fontWeight: FontWeight.bold))]),
                      ]),
                    ),
                  ),
                )),
              SliverToBoxAdapter(child: SizedBox(height: 14, child: Container())),
              SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(children: [
                  Expanded(child: Text(isSaved ? 'قائمتي' : (query.isNotEmpty ? 'نتائج البحث' : 'اكتشف المحتوى'),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
                  Text('${filtered.length} عنوان', style: const TextStyle(color: muted, fontSize: 12)),
                ]),
              )),
              SliverToBoxAdapter(child: SizedBox(height: 52, child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                scrollDirection: Axis.horizontal,
                children: ['الكل', 'فيلم', 'مسلسل'].map((c) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ChoiceChip(label: Text(c), selected: category == c,
                    onSelected: (_) => setState(() => category = c),
                    selectedColor: accent, backgroundColor: panel,
                    labelStyle: TextStyle(color: category == c ? Colors.white : muted, fontWeight: FontWeight.w700),
                    side: BorderSide.none),
                )).toList(),
              ))),
              if (filtered.isEmpty)
                const SliverFillRemaining(hasScrollBody: false, child: Center(child: Text('لا توجد نتائج هنا بعد', style: TextStyle(color: muted))))
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 100),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = filtered[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(17),
                        onTap: () => _details(context, item),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(child: Stack(children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
                                  colors: [item.color, item.color.withOpacity(.45), panel]),
                              ),
                              child: Center(child: Icon(item.type == 'فيلم' ? Icons.movie_creation_outlined : Icons.live_tv_rounded,
                                size: 55, color: Colors.white.withOpacity(.8))),
                            ),
                            Positioned(top: 8, right: 8, child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                              decoration: BoxDecoration(color: Colors.black.withOpacity(.45), borderRadius: BorderRadius.circular(8)),
                              child: Text('★ ${item.rating}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            )),
                            Positioned(top: 3, left: 3, child: IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () => setState(() => saved.contains(item.name) ? saved.remove(item.name) : saved.add(item.name)),
                              icon: Icon(saved.contains(item.name) ? Icons.bookmark : Icons.bookmark_border,
                                color: Colors.white, size: 22),
                            )),
                          ])),
                          const SizedBox(height: 8),
                          Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                          const SizedBox(height: 3),
                          Text('${item.type}  •  ${item.year}', style: const TextStyle(color: muted, fontSize: 11)),
                        ]),
                      );
                    }, childCount: filtered.length),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 18, crossAxisSpacing: 14, childAspectRatio: .68),
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color(0xFF11151D),
          indicatorColor: accent.withOpacity(.22),
          selectedIndex: tab,
          onDestinationSelected: (v) => setState(() { tab = v; if (v != 2) category = 'الكل'; }),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore_rounded), label: 'استكشف'),
            NavigationDestination(icon: Icon(Icons.bookmarks_outlined), selectedIcon: Icon(Icons.bookmarks_rounded), label: 'قائمتي'),
          ],
        ),
      ),
    );
  }

  void _details(BuildContext context, TitleItem item) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: panel,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
      builder: (context) => Directionality(textDirection: TextDirection.rtl, child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 42, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)))),
          const SizedBox(height: 22),
          Container(height: 145, width: double.infinity, decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(colors: [item.color, item.color.withOpacity(.35), bg])),
            child: Icon(item.type == 'فيلم' ? Icons.movie_outlined : Icons.live_tv_rounded, size: 62)),
          const SizedBox(height: 18),
          Text(item.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text('${item.type}  •  ${item.year}  •  ★ ${item.rating}', style: const TextStyle(color: muted)),
          const SizedBox(height: 14),
          Text(item.description, style: const TextStyle(fontSize: 15, height: 1.7)),
          const SizedBox(height: 18),
          SizedBox(width: double.infinity, child: FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
                content: Text('أضف رابط تشغيل مرخّص لهذا العنوان داخل المشروع لتفعيل المشاهدة.')));
            },
            icon: const Icon(Icons.play_arrow_rounded), label: const Text('مشاهدة'),
            style: FilledButton.styleFrom(backgroundColor: accent, padding: const EdgeInsets.all(15)))),
          const SizedBox(height: 8),
          const Text('هذه نسخة واجهة تجريبية؛ لا تحتوي على أفلام أو روابط بث مضمّنة.', style: TextStyle(color: muted, fontSize: 11)),
        ]),
      )));
  }

  void _showInfo(BuildContext context) {
    showAboutDialog(context: context, applicationName: 'مشهد',
      applicationVersion: '1.0.0',
      applicationLegalese: 'واجهة تجريبية. أضف فقط مصادر وروابط تملك حق بثّها أو استخدامها.');
  }
}