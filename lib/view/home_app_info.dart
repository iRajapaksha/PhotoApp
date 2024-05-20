import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeAppInfo extends StatefulWidget {
  const HomeAppInfo({super.key});

  @override
  State<HomeAppInfo> createState() => _HomeAppInfoState();
}

class _HomeAppInfoState extends State<HomeAppInfo> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    const search = 'assets/icons/search.gif';
    const searchHeading = 'Filter Gallery';
    const searchText =
        'Search for similar, defected, or duplicate photos in the gallery';
    const post = 'assets/icons/post.gif';
    const postHeading = 'Generate Captions';
    const postText = 'Auto generate captions for your best looking photos';
    const share = 'assets/icons/refer.gif';
    const shareHeading = 'Share on Social Media';
    const shareText = 'Quick share on all the social media platforms';

    return Container(
      width: 300,
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      //  color: Colors.cyanAccent,
      ),
      child: Column(
        children: [
          // Ensure the PageView has a fixed height
          SizedBox(
            height: 400,
            child: PageView(
              controller: _pageController,
              children: [
                _onboardingPage(search, searchHeading, searchText),
                _onboardingPage(post, postHeading, postText),
                _onboardingPage(share, shareHeading, shareText),
              ],
            ),
          ),
          // Smooth Page Indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.black,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _onboardingPage(String image, String heading, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, width: 200, height: 200, ),
        const SizedBox(height: 24),
        Text(
          heading,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
