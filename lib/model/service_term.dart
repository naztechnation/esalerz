class ServiceTerm {
  final String companyName;
  final String workExperience;
  final String subtitle;
  final String service;
  final String frequency;
  final String roundTheClock;
  final String type;
  final String serviceArea;
  final String regularService;

  ServiceTerm({
    required this.service,
    required this.frequency,
    required this.roundTheClock,
    required this.type,
    required this.serviceArea,
    required this.regularService,
    required this.companyName,
    required this.workExperience,
    required this.subtitle,
  });
}

// service_data.dart

List<ServiceTerm> serviceTerms = [
  ServiceTerm(
    companyName: 'Premium Esowp',
    workExperience: '3 Years of Experience',
    subtitle: 'Providing quality services',
    service: 'Wall protection',
    frequency: 'Monthly',
    roundTheClock: 'Yes',
    type: 'Gas fumigation',
    serviceArea: 'Ngozika estate, awka',
    regularService: 'Yes',
  ),
  // ServiceTerm(
  //   companyName: 'Company A',
  //   workExperienceHeading: '3 Years of Experience',
  //   subtitle: 'Providing quality services',
  //   service: 'Wall protection',
  //   frequency: 'Monthly',
  //   roundTheClock: true,
  //   type: 'Gas fumigation',
  //   serviceArea: 'Ngozika',
  //   regularService: true,
  // ),
  // ServiceTerm(
  //   companyName: 'Company A',
  //   workExperienceHeading: '3 Years of Experience',
  //   subtitle: 'Providing quality services',
  //   service: 'Wall protection',
  //   frequency: 'Monthly',
  //   roundTheClock: true,
  //   type: 'Gas fumigation',
  //   serviceArea: 'Ngozika',
  //   regularService: true,
  // ),
  // Add more ServiceTerm instances as needed
];
