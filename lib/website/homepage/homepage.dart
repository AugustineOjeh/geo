import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/app_bar.dart';
import 'package:grace_ogangwu/constants/keys.dart';
import 'package:grace_ogangwu/website/homepage/hero_section.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Check if user has active session and navigate to app
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppBar.dynamic(context),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(key: SectionKeys.hero),
          
          // About me section
          // Service section
          // How I work section
          // Tech partners
          // Testimonial
          // Packages
          // FAQs
          // Blogs
          // Footer
        ],
      ),
    ),
  );
}
