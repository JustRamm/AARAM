import 'dart:convert';
import 'package:dio/dio.dart';

class DocumentStatus {
  final String documentType;
  final String status;
  final String? applicationNumber;
  final String? issueDate;
  final String? expiryDate;
  final String? remarks;

  DocumentStatus({
    required this.documentType,
    required this.status,
    this.applicationNumber,
    this.issueDate,
    this.expiryDate,
    this.remarks,
  });

  factory DocumentStatus.fromJson(Map<String, dynamic> json) {
    return DocumentStatus(
      documentType: json['documentType'] ?? '',
      status: json['status'] ?? '',
      applicationNumber: json['applicationNumber'],
      issueDate: json['issueDate'],
      expiryDate: json['expiryDate'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentType': documentType,
      'status': status,
      'applicationNumber': applicationNumber,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      'remarks': remarks,
    };
  }
}

class GovernmentService {
  final String serviceName;
  final String description;
  final String officialUrl;
  final String phoneNumber;
  final List<String> requiredDocuments;
  final double fee;
  final String processingTime;

  GovernmentService({
    required this.serviceName,
    required this.description,
    required this.officialUrl,
    required this.phoneNumber,
    required this.requiredDocuments,
    required this.fee,
    required this.processingTime,
  });

  factory GovernmentService.fromJson(Map<String, dynamic> json) {
    return GovernmentService(
      serviceName: json['serviceName'] ?? '',
      description: json['description'] ?? '',
      officialUrl: json['officialUrl'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      requiredDocuments: json['requiredDocuments'] != null 
        ? List<String>.from(json['requiredDocuments'])
        : [],
      fee: json['fee']?.toDouble() ?? 0.0,
      processingTime: json['processingTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'description': description,
      'officialUrl': officialUrl,
      'phoneNumber': phoneNumber,
      'requiredDocuments': requiredDocuments,
      'fee': fee,
      'processingTime': processingTime,
    };
  }
}

class GovernmentAPIService {
  static final GovernmentAPIService _instance = GovernmentAPIService._internal();
  factory GovernmentAPIService() => _instance;
  GovernmentAPIService._internal();

  final Dio _dio = Dio();
  
  // Base URLs for government APIs
  static const String _uidaiBaseUrl = 'https://resident.uidai.gov.in/api';
  static const String _panBaseUrl = 'https://tin.tin.nsdl.com/api';
  static const String _rtoBaseUrl = 'https://sarathi.parivahan.gov.in/api';
  static const String _passportBaseUrl = 'https://passportindia.gov.in/api';
  static const String _voterBaseUrl = 'https://voterportal.eci.gov.in/api';

  // Aadhaar Services
  Future<DocumentStatus?> checkAadhaarStatus(String enrollmentNumber) async {
    try {
      // In production, this would make a real API call to UIDAI
      // For demo, we'll return mock data
      await Future.delayed(const Duration(seconds: 1));
      
      return DocumentStatus(
        documentType: 'Aadhaar Card',
        status: 'Active',
        applicationNumber: enrollmentNumber,
        issueDate: '2020-03-15',
        expiryDate: 'Lifetime',
        remarks: 'Aadhaar card is active and valid',
      );
    } catch (e) {
      return null;
    }
  }

  Future<GovernmentService> getAadhaarServices() async {
    return GovernmentService(
      serviceName: 'Aadhaar Services',
      description: 'Complete Aadhaar card services including generation, update, and download',
      officialUrl: 'https://uidai.gov.in',
      phoneNumber: '1947',
      requiredDocuments: [
        'Birth Certificate',
        'Address Proof',
        'Photo',
        'Mobile Number'
      ],
      fee: 0.0,
      processingTime: '15-20 days',
    );
  }

  // PAN Services
  Future<DocumentStatus?> checkPANStatus(String panNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      return DocumentStatus(
        documentType: 'PAN Card',
        status: 'Active',
        applicationNumber: panNumber,
        issueDate: '2018-07-22',
        expiryDate: 'Lifetime',
        remarks: 'PAN card is active and valid',
      );
    } catch (e) {
      return null;
    }
  }

  Future<GovernmentService> getPANServices() async {
    return GovernmentService(
      serviceName: 'PAN Services',
      description: 'PAN card generation, update, and reprint services',
      officialUrl: 'https://www.incometax.gov.in',
      phoneNumber: '1800-180-1961',
      requiredDocuments: [
        'Photo',
        'ID Proof',
        'Address Proof',
        'Mobile Number'
      ],
      fee: 93.0,
      processingTime: '7-10 days',
    );
  }

  // Driving License Services
  Future<DocumentStatus?> checkDrivingLicenseStatus(String licenseNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      return DocumentStatus(
        documentType: 'Driving License',
        status: 'Active',
        applicationNumber: licenseNumber,
        issueDate: '2020-01-15',
        expiryDate: '2040-01-15',
        remarks: 'Driving license is valid for 20 years',
      );
    } catch (e) {
      return null;
    }
  }

  Future<GovernmentService> getDrivingLicenseServices() async {
    return GovernmentService(
      serviceName: 'Driving License Services',
      description: 'Driving license generation, renewal, and duplicate services',
      officialUrl: 'https://sarathi.parivahan.gov.in',
      phoneNumber: '1800-11-0031',
      requiredDocuments: [
        'Medical Certificate',
        'Photo',
        'Address Proof',
        'Age Proof'
      ],
      fee: 200.0,
      processingTime: '10-15 days',
    );
  }

  // Passport Services
  Future<DocumentStatus?> checkPassportStatus(String passportNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      return DocumentStatus(
        documentType: 'Passport',
        status: 'Active',
        applicationNumber: passportNumber,
        issueDate: '2020-05-20',
        expiryDate: '2030-05-20',
        remarks: 'Passport is valid for 10 years',
      );
    } catch (e) {
      return null;
    }
  }

  Future<GovernmentService> getPassportServices() async {
    return GovernmentService(
      serviceName: 'Passport Services',
      description: 'Passport application, renewal, and reissue services',
      officialUrl: 'https://passportindia.gov.in',
      phoneNumber: '1800-258-1800',
      requiredDocuments: [
        'Birth Certificate',
        'Address Proof',
        'Photo',
        'Police Verification'
      ],
      fee: 1500.0,
      processingTime: '30-45 days',
    );
  }

  // Voter ID Services
  Future<DocumentStatus?> checkVoterIDStatus(String voterIdNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      return DocumentStatus(
        documentType: 'Voter ID',
        status: 'Active',
        applicationNumber: voterIdNumber,
        issueDate: '2019-11-10',
        expiryDate: 'Lifetime',
        remarks: 'Voter ID is active and valid',
      );
    } catch (e) {
      return null;
    }
  }

  Future<GovernmentService> getVoterIDServices() async {
    return GovernmentService(
      serviceName: 'Voter ID Services',
      description: 'Voter ID generation and update services',
      officialUrl: 'https://voterportal.eci.gov.in',
      phoneNumber: '1950',
      requiredDocuments: [
        'Age Proof',
        'Address Proof',
        'Photo',
        'Mobile Number'
      ],
      fee: 0.0,
      processingTime: '15-20 days',
    );
  }

  // Document Renewal Services
  Future<bool> initiateDocumentRenewal(String documentType, Map<String, dynamic> userData) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      // In production, this would submit the renewal application to the respective government portal
      print('Renewal initiated for $documentType with data: $userData');
      
      return true;
    } catch (e) {
      return false;
    }
  }

  // Form Auto-filling Service
  Future<Map<String, dynamic>> getAutoFillData(String documentType) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      // In production, this would fetch user data from DigiLocker or other verified sources
      final mockData = {
        'aadhaar': {
          'name': 'John Doe',
          'dateOfBirth': '1990-01-01',
          'address': '123 Main Street, City, State - 123456',
          'mobile': '9876543210',
          'email': 'john.doe@email.com',
        },
        'pan': {
          'name': 'John Doe',
          'dateOfBirth': '1990-01-01',
          'address': '123 Main Street, City, State - 123456',
          'mobile': '9876543210',
          'email': 'john.doe@email.com',
        },
        'driving_license': {
          'name': 'John Doe',
          'dateOfBirth': '1990-01-01',
          'address': '123 Main Street, City, State - 123456',
          'mobile': '9876543210',
          'bloodGroup': 'O+',
        },
      };
      
      return mockData[documentType.toLowerCase()] ?? {};
    } catch (e) {
      return {};
    }
  }

  // Payment Integration
  Future<String?> initiatePayment(String serviceType, double amount) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      // In production, this would integrate with payment gateways like Razorpay, PayU, etc.
      final transactionId = 'TXN${DateTime.now().millisecondsSinceEpoch}';
      
      print('Payment initiated for $serviceType: $amount, Transaction ID: $transactionId');
      
      return transactionId;
    } catch (e) {
      return null;
    }
  }

  // Document Verification
  Future<bool> verifyDocument(String documentType, String documentNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      // In production, this would verify documents with respective government databases
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get all available services
  Future<List<GovernmentService>> getAllServices() async {
    return [
      await getAadhaarServices(),
      await getPANServices(),
      await getDrivingLicenseServices(),
      await getPassportServices(),
      await getVoterIDServices(),
    ];
  }

  // Search services
  Future<List<GovernmentService>> searchServices(String query) async {
    final allServices = await getAllServices();
    return allServices.where((service) => 
      service.serviceName.toLowerCase().contains(query.toLowerCase()) ||
      service.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Get service by type
  Future<GovernmentService?> getServiceByType(String documentType) async {
    switch (documentType.toLowerCase()) {
      case 'aadhaar':
        return await getAadhaarServices();
      case 'pan':
        return await getPANServices();
      case 'driving_license':
      case 'license':
        return await getDrivingLicenseServices();
      case 'passport':
        return await getPassportServices();
      case 'voter_id':
      case 'voterid':
        return await getVoterIDServices();
      default:
        return null;
    }
  }
}
