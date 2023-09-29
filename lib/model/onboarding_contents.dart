class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to Esalerz ",
    image: "assets/images/image1.png",
    desc: "Your trusted companion for all kinds of human services needs. ",
  ),
  OnboardingContents(
    title: "Discover Services ",
    image: "assets/images/image2.png",
    desc:
        "Explore a wide range of home services tailored to your needs.",
  ),
  OnboardingContents(
    title: "Get Started ",
    image: "assets/images/image3.png",
    desc:
        "It's time to experience a new level of convenience with Esalerz. ",
  ),
];
