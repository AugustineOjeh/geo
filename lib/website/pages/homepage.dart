import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/keys.dart';
import 'package:grace_ogangwu/website/sections/about_section.dart';
import 'package:grace_ogangwu/website/sections/faq_section.dart';
import 'package:grace_ogangwu/website/sections/footer.dart';
import 'package:grace_ogangwu/website/sections/hero_section.dart';
import 'package:grace_ogangwu/website/sections/how_i_work_section.dart';
import 'package:grace_ogangwu/website/sections/packages_section.dart';
import 'package:grace_ogangwu/website/sections/partners_section.dart';
import 'package:grace_ogangwu/website/sections/testimonial_section.dart';
import 'package:grace_ogangwu/website/sections/what_i_offer_section.dart';

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

  void _backToTop() => _navigate(SectionKeys.hero);

  void _navigate(GlobalKey sectionKey) {
    Scrollable.ensureVisible(
      sectionKey.currentContext!,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    // appBar: CustomAppBar.dynamic(context, navigate: _navigate),
    body: SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(key: SectionKeys.hero, navigate: _navigate),
          AboutSection(key: SectionKeys.aboutMe),
          WhatIOfferSection(key: SectionKeys.services),
          HowIWorkSection(key: SectionKeys.process),
          PartnersSection(key: SectionKeys.partners),
          TestimonialSection(key: SectionKeys.testimonial),
          PackagesSection(key: SectionKeys.bookClass),
          FaqSection(key: SectionKeys.faq),
          // Blogs
          Footer(key: SectionKeys.footer, backToTop: _backToTop),
        ],
      ),
    ),
  );
}
