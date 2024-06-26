import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';

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
    const search = 'assets/icons/search.json';
    const searchHeading = 'Filter Gallery';
    const searchText =
        'Search for similar, defected, or duplicate photos in the gallery';
    const post = 'assets/icons/caption.json';
    const postHeading = 'Generate Captions';
    const postText = 'Auto generate captions for your best looking photos';
    const share = 'assets/icons/social_media.json';
    const shareHeading = 'Share on Social Media';
    const shareText = 'Quick share on all the social media platforms';

    return Container(
      width: 275,
      height: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Colors.cyanAccent,
      ),
      child: Column(
        children: [
          // Ensure the PageView has a fixed height
          SizedBox(
            height: 350,
            child: PageView(
              controller: _pageController,
              children: [
                _onboardingPage(
                  Lottie.asset(
                    search,
                    width: 300,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                  searchHeading,
                  searchText,
                ),
                _onboardingPage(
                  Lottie.asset(
                    post,
                    width: 300,
                    height: 225,
                    fit: BoxFit.fill,
                  ),
                  postHeading,
                  postText,
                ),
                _onboardingPage(
                  Lottie.asset(
                    share,
                    width: 300,
                    height: 225,
                    fit: BoxFit.fill,
                  ),
                  shareHeading,
                  shareText,
                ),
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
              dotWidth: 15,
              spacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _onboardingPage(Widget asset, String heading, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        asset,
        const SizedBox(height: 1),
        Text(
          heading,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        const SizedBox(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 255, 255, 255)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
