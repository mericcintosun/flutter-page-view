import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'dart:async';
import 'dart:ui' as ui;

class EnterprisePageViewWidget extends StatefulWidget {
  final PageStorageKey<String> storageKey;

  const EnterprisePageViewWidget({super.key, required this.storageKey});

  @override
  State<EnterprisePageViewWidget> createState() =>
      _EnterprisePageViewWidgetState();
}

class _EnterprisePageViewWidgetState extends State<EnterprisePageViewWidget>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _indicatorController;

  int _currentPageIndex = 0;
  bool _isHorizontalAxis = true;
  bool _isVerticalAxis = false;
  bool _isSnapEnabled = true;
  bool _isAutoPlayEnabled = false;

  Timer? _autoPlayTimer;

  final List<PageData> _pageItems = [
    PageData('Enterprise Dashboard', Icons.dashboard, const Color(0xFF1A237E)),
    PageData('Analytics', Icons.analytics, const Color(0xFF0D47A1)),
    PageData('Settings', Icons.settings, const Color(0xFF1565C0)),
    PageData('Data Viz', Icons.data_usage, const Color(0xFF1976D2)),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _indicatorController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D1421), Color(0xFF2D3748)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(flex: 2, child: _buildPageView()),
              Container(height: 200, child: _buildControlPanel()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          scrollDirection: _isHorizontalAxis ? Axis.horizontal : Axis.vertical,
          pageSnapping: _isSnapEnabled,
          onPageChanged: (index) {
            setState(() => _currentPageIndex = index);
            _indicatorController.forward().then(
              (_) => _indicatorController.reverse(),
            );
            HapticFeedback.lightImpact();
          },
          itemCount: _pageItems.length,
          itemBuilder: (context, index) => _buildPage(index),
        ),
        Positioned(bottom: 20, left: 0, right: 0, child: _buildPageIndicator()),
      ],
    );
  }

  Widget _buildPage(int index) {
    final item = _pageItems[index];
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [item.color, item.color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(item.icon, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 24),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Professional Feature ${index + 1}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pageItems.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == _currentPageIndex ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == _currentPageIndex
                ? Colors.white
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F36).withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildNavigationButtons(),
            const SizedBox(height: 16),
            _buildConfigToggles(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _currentPageIndex > 0 ? _previousPage : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Previous'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _currentPageIndex < _pageItems.length - 1
                ? _nextPage
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }

  Widget _buildConfigToggles() {
    return Row(
      children: [
        Expanded(
          child: _buildToggle('Horizontal', _isHorizontalAxis, (v) {
            setState(() {
              _isHorizontalAxis = v;
              if (v) _isVerticalAxis = false;
            });
          }),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildToggle('Vertical', _isVerticalAxis, (v) {
            setState(() {
              _isVerticalAxis = v;
              if (v) _isHorizontalAxis = false;
            });
          }),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildToggle('Snap', _isSnapEnabled, (v) {
            setState(() => _isSnapEnabled = v);
          }),
        ),
      ],
    );
  }

  Widget _buildToggle(String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: value
            ? Colors.blue.withOpacity(0.2)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: value ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _indicatorController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }
}

class PageData {
  final String title;
  final IconData icon;
  final Color color;

  PageData(this.title, this.icon, this.color);
}
