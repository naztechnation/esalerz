class ServiceTerm {
  final String companyName;
  final String workExperienceHeading;
  final String subtitle;

  ServiceTerm({
    required this.companyName,
    required this.workExperienceHeading,
    required this.subtitle,
  });
}


// service_data.dart



List<ServiceTerm> serviceTerms = [
  ServiceTerm(
    companyName: 'Company A',
    workExperienceHeading: '3 Years of Experience',
    subtitle: 'Providing quality services',
  ),
  ServiceTerm(
    companyName: 'Company B',
    workExperienceHeading: '5 Years of Experience',
    subtitle: 'Expert service provider',
  ),
  // Add more ServiceTerm instances as needed
];
