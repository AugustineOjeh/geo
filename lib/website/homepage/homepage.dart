import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/app_bar.dart';
import 'package:grace_ogangwu/constants/keys.dart';
import 'package:grace_ogangwu/website/homepage/about_section.dart';
import 'package:grace_ogangwu/website/homepage/hero_section.dart';
import 'package:grace_ogangwu/website/homepage/how_i_work_section.dart';
import 'package:grace_ogangwu/website/homepage/what_i_offer_section.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // Check if user has active session and navigate to app
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppBar.dynamic(context),
    body: SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(key: SectionKeys.hero),
          AboutSection(key: SectionKeys.aboutMe),
          WhatIOfferSection(key: SectionKeys.services),
          HowIWorkSection(key: SectionKeys.process),
          
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
