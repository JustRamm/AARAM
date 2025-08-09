import 'dart:convert';
import 'package:dio/dio.dart';

class AIResponse {
  final String message;
  final String type;
  final Map<String, dynamic>? data;
  final List<String>? suggestions;

  AIResponse({
    required this.message,
    required this.type,
    this.data,
    this.suggestions,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      data: json['data'],
      suggestions: json['suggestions'] != null 
        ? List<String>.from(json['suggestions'])
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'data': data,
      'suggestions': suggestions,
    };
  }
}

class AIService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  final Dio _dio = Dio();
  
  // For demo purposes, we'll use a mock AI service
  // In production, you would integrate with OpenAI, Google AI, or other AI services
  Future<AIResponse> getAIResponse(String userMessage, String language) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));
      
      final lowerMessage = userMessage.toLowerCase();
      final isMalayalam = language == 'Malayalam';
      
      // Document renewal queries
      if (lowerMessage.contains('renew') || lowerMessage.contains('പുനർനവീകരിക്ക')) {
        return _getRenewalResponse(isMalayalam);
      }
      
      // Status check queries
      if (lowerMessage.contains('status') || lowerMessage.contains('നില') || 
          lowerMessage.contains('check') || lowerMessage.contains('പരിശോധിക്ക')) {
        return _getStatusResponse(isMalayalam);
      }
      
      // Form help queries
      if (lowerMessage.contains('form') || lowerMessage.contains('ഫോം') || 
          lowerMessage.contains('help') || lowerMessage.contains('സഹായം')) {
        return _getFormHelpResponse(isMalayalam);
      }
      
      // Expiry queries
      if (lowerMessage.contains('expiry') || lowerMessage.contains('കാലഹരണപ്പെടൽ') || 
          lowerMessage.contains('expire') || lowerMessage.contains('കാലഹരണപ്പെടും')) {
        return _getExpiryResponse(isMalayalam);
      }
      
      // Government services queries
      if (lowerMessage.contains('government') || lowerMessage.contains('സർക്കാർ') || 
          lowerMessage.contains('service') || lowerMessage.contains('സേവനം')) {
        return _getGovernmentServicesResponse(isMalayalam);
      }
      
      // Aadhaar specific queries
      if (lowerMessage.contains('aadhaar') || lowerMessage.contains('ആധാർ')) {
        return _getAadhaarResponse(isMalayalam);
      }
      
      // PAN specific queries
      if (lowerMessage.contains('pan') || lowerMessage.contains('പാൻ')) {
        return _getPANResponse(isMalayalam);
      }
      
      // Driving license queries
      if (lowerMessage.contains('driving') || lowerMessage.contains('ലൈസൻസ്') || 
          lowerMessage.contains('license')) {
        return _getDrivingLicenseResponse(isMalayalam);
      }
      
      // Default response
      return _getDefaultResponse(isMalayalam);
      
    } catch (e) {
      return AIResponse(
        message: language == 'Malayalam'
          ? 'ക്ഷമിക്കണം, ഒരു പിശക് സംഭവിച്ചു. ദയവായി വീണ്ടും ശ്രമിക്കുക.'
          : 'Sorry, an error occurred. Please try again.',
        type: 'error',
      );
    }
  }

  AIResponse _getRenewalResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''ഡോക്യുമെന്റുകൾ പുനർനവീകരിക്കാനുള്ള വഴികൾ:

📋 **ആധാർ കാർഡ് പുനർനവീകരണം:**
• ഔദ്യോഗിക വെബ്സൈറ്റ്: uidai.gov.in
• ഫോൺ നമ്പർ: 1947
• ആവശ്യമായ രേഖകൾ: ഫോട്ടോ, വിലാസ തെളിവ്

📋 **പാൻ കാർഡ് പുനർനവീകരണം:**
• ഔദ്യോഗിക വെബ്സൈറ്റ്: incometax.gov.in
• ഫോൺ നമ്പർ: 1800-180-1961
• ആവശ്യമായ രേഖകൾ: ഫോട്ടോ, ഐഡി പ്രൂഫ്

📋 **ഡ്രൈവിംഗ് ലൈസൻസ് പുനർനവീകരണം:**
• ഔദ്യോഗിക വെബ്സൈറ്റ്: sarathi.parivahan.gov.in
• ആവശ്യമായ രേഖകൾ: മെഡിക്കൽ സർട്ടിഫിക്കറ്റ്, ഫോട്ടോ

ഞാൻ നിങ്ങൾക്ക് ഫോം പൂരിപ്പിക്കാൻ സഹായിക്കാം!''',
        type: 'renewal',
        suggestions: [
          'ആധാർ കാർഡ് പുനർനവീകരിക്കാൻ',
          'പാൻ കാർഡ് പുനർനവീകരിക്കാൻ',
          'ഡ്രൈവിംഗ് ലൈസൻസ് പുനർനവീകരിക്കാൻ'
        ],
      );
    } else {
      return AIResponse(
        message: '''Here's how to renew your documents:

📋 **Aadhaar Card Renewal:**
• Official Website: uidai.gov.in
• Phone Number: 1947
• Required Documents: Photo, Address Proof

📋 **PAN Card Renewal:**
• Official Website: incometax.gov.in
• Phone Number: 1800-180-1961
• Required Documents: Photo, ID Proof

📋 **Driving License Renewal:**
• Official Website: sarathi.parivahan.gov.in
• Required Documents: Medical Certificate, Photo

I can help you fill out the forms!''',
        type: 'renewal',
        suggestions: [
          'Renew Aadhaar Card',
          'Renew PAN Card',
          'Renew Driving License'
        ],
      );
    }
  }

  AIResponse _getStatusResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''അപേക്ഷ നില പരിശോധിക്കാനുള്ള വഴികൾ:

🔍 **ആധാർ അപേക്ഷ നില:**
• വെബ്സൈറ്റ്: resident.uidai.gov.in/check-aadhaar-status
• ഫോൺ നമ്പർ: 1947

🔍 **പാൻ അപേക്ഷ നില:**
• വെബ്സൈറ്റ്: tin.tin.nsdl.com/pan/
• ഫോൺ നമ്പർ: 1800-180-1961

🔍 **ഡ്രൈവിംഗ് ലൈസൻസ് നില:**
• വെബ്സൈറ്റ്: sarathi.parivahan.gov.in/sarathiservice

നിങ്ങളുടെ അപേക്ഷ നമ്പർ നൽകുക, ഞാൻ നില പരിശോധിക്കാം!''',
        type: 'status',
        suggestions: [
          'ആധാർ നില പരിശോധിക്കുക',
          'പാൻ നില പരിശോധിക്കുക',
          'ലൈസൻസ് നില പരിശോധിക്കുക'
        ],
      );
    } else {
      return AIResponse(
        message: '''Here's how to check application status:

🔍 **Aadhaar Application Status:**
• Website: resident.uidai.gov.in/check-aadhaar-status
• Phone Number: 1947

🔍 **PAN Application Status:**
• Website: tin.tin.nsdl.com/pan/
• Phone Number: 1800-180-1961

🔍 **Driving License Status:**
• Website: sarathi.parivahan.gov.in/sarathiservice

Provide your application number, I'll check the status!''',
        type: 'status',
        suggestions: [
          'Check Aadhaar Status',
          'Check PAN Status',
          'Check License Status'
        ],
      );
    }
  }

  AIResponse _getFormHelpResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''സർക്കാർ ഫോമുകൾ പൂരിപ്പിക്കാൻ സഹായം:

📝 **ഫോം പൂരിപ്പിക്കാനുള്ള നുറുങ്ങുകൾ:**
• എല്ലാ വിവരങ്ങളും കൃത്യമായി നൽകുക
• ആവശ്യമായ രേഖകൾ അറ്റാച്ച് ചെയ്യുക
• ഫോട്ടോ ഗുണനിലവാരം നല്ലതായിരിക്കണം
• സിഗ്നേച്ചർ ക്ലിയറായിരിക്കണം

📝 **സാധാരണ പിശകുകൾ:**
• അപൂർണ്ണമായ വിവരങ്ങൾ
• തെറ്റായ ഫോട്ടോ വലുപ്പം
• അസാധുവായ രേഖകൾ

ഞാൻ നിങ്ങൾക്ക് ഫോം പൂരിപ്പിക്കാൻ സഹായിക്കാം!''',
        type: 'form_help',
        suggestions: [
          'ആധാർ ഫോം സഹായം',
          'പാൻ ഫോം സഹായം',
          'ലൈസൻസ് ഫോം സഹായം'
        ],
      );
    } else {
      return AIResponse(
        message: '''Help with government form filling:

📝 **Form Filling Tips:**
• Provide all information accurately
• Attach required documents
• Ensure photo quality is good
• Signature should be clear

📝 **Common Mistakes:**
• Incomplete information
• Wrong photo size
• Invalid documents

I can help you fill out the forms!''',
        type: 'form_help',
        suggestions: [
          'Aadhaar Form Help',
          'PAN Form Help',
          'License Form Help'
        ],
      );
    }
  }

  AIResponse _getExpiryResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''നിങ്ങളുടെ ഡോക്യുമെന്റുകളുടെ കാലഹരണപ്പെടൽ തീയതികൾ:

📅 **ആധാർ കാർഡ്:** കാലഹരണപ്പെടില്ല (Lifetime)
📅 **പാൻ കാർഡ്:** കാലഹരണപ്പെടില്ല (Lifetime)
📅 **ഡ്രൈവിംഗ് ലൈസൻസ്:** 20 വയസ്സ് അല്ലെങ്കിൽ 50 വയസ്സ്
📅 **പാസ്പോർട്ട്:** 10 വയസ്സ്
📅 **വോട്ടർ ഐഡി:** കാലഹരണപ്പെടില്ല (Lifetime)
📅 **ജനന സർട്ടിഫിക്കറ്റ്:** കാലഹരണപ്പെടില്ല (Lifetime)

ഞാൻ നിങ്ങൾക്ക് ഓർമ്മപ്പെടുത്തലുകൾ സജ്ജമാക്കാം!''',
        type: 'expiry',
        suggestions: [
          'ആധാർ കാലഹരണപ്പെടൽ',
          'ലൈസൻസ് കാലഹരണപ്പെടൽ',
          'പാസ്പോർട്ട് കാലഹരണപ്പെടൽ'
        ],
      );
    } else {
      return AIResponse(
        message: '''Your document expiry dates:

📅 **Aadhaar Card:** Never expires (Lifetime)
📅 **PAN Card:** Never expires (Lifetime)
📅 **Driving License:** 20 years or 50 years
📅 **Passport:** 10 years
📅 **Voter ID:** Never expires (Lifetime)
📅 **Birth Certificate:** Never expires (Lifetime)

I can set up reminders for you!''',
        type: 'expiry',
        suggestions: [
          'Aadhaar Expiry',
          'License Expiry',
          'Passport Expiry'
        ],
      );
    }
  }

  AIResponse _getGovernmentServicesResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''സർക്കാർ സേവനങ്ങൾ:

🏛️ **ആധാർ സേവനങ്ങൾ:**
• ആധാർ ജനറേഷൻ
• ആധാർ അപ്ഡേറ്റ്
• ആധാർ ഡൗൺലോഡ്
• ആധാർ ലോക്ക്/അൺലോക്ക്

🏛️ **പാൻ സേവനങ്ങൾ:**
• പാൻ ജനറേഷൻ
• പാൻ അപ്ഡേറ്റ്
• പാൻ റീപ്രിന്റ്

🏛️ **ഡ്രൈവിംഗ് ലൈസൻസ്:**
• ലൈസൻസ് ജനറേഷൻ
• ലൈസൻസ് റീന്യൂവൽ
• ലൈസൻസ് ഡ്യൂപ്ലിക്കേറ്റ്

ഏത് സേവനവും ആവശ്യമുണ്ടെങ്കിൽ ചോദിക്കാം!''',
        type: 'government_services',
        suggestions: [
          'ആധാർ സേവനങ്ങൾ',
          'പാൻ സേവനങ്ങൾ',
          'ലൈസൻസ് സേവനങ്ങൾ'
        ],
      );
    } else {
      return AIResponse(
        message: '''Government Services:

🏛️ **Aadhaar Services:**
• Aadhaar Generation
• Aadhaar Update
• Aadhaar Download
• Aadhaar Lock/Unlock

🏛️ **PAN Services:**
• PAN Generation
• PAN Update
• PAN Reprint

🏛️ **Driving License:**
• License Generation
• License Renewal
• License Duplicate

Ask for any service you need!''',
        type: 'government_services',
        suggestions: [
          'Aadhaar Services',
          'PAN Services',
          'License Services'
        ],
      );
    }
  }

  AIResponse _getAadhaarResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''ആധാർ കാർഡ് സേവനങ്ങൾ:

🆔 **ആധാർ ജനറേഷൻ:**
• ഫോൺ നമ്പർ: 1947
• വെബ്സൈറ്റ്: uidai.gov.in
• ആവശ്യമായ രേഖകൾ: ജനന സർട്ടിഫിക്കറ്റ്, വിലാസ തെളിവ്

🆔 **ആധാർ അപ്ഡേറ്റ്:**
• ഓൺലൈൻ: resident.uidai.gov.in
• എൻറോൾമെന്റ് സെന്റർ: അടുത്തുള്ള എൻറോൾമെന്റ് സെന്റർ

🆔 **ആധാർ ഡൗൺലോഡ്:**
• mAadhaar ആപ്പ്
• ഔദ്യോഗിക വെബ്സൈറ്റ്

ആധാർ സംബന്ധിച്ച ഏത് സഹായവും ആവശ്യമുണ്ടെങ്കിൽ ചോദിക്കാം!''',
        type: 'aadhaar',
        suggestions: [
          'ആധാർ ജനറേഷൻ',
          'ആധാർ അപ്ഡേറ്റ്',
          'ആധാർ ഡൗൺലോഡ്'
        ],
      );
    } else {
      return AIResponse(
        message: '''Aadhaar Card Services:

🆔 **Aadhaar Generation:**
• Phone Number: 1947
• Website: uidai.gov.in
• Required Documents: Birth Certificate, Address Proof

🆔 **Aadhaar Update:**
• Online: resident.uidai.gov.in
• Enrollment Center: Nearest enrollment center

🆔 **Aadhaar Download:**
• mAadhaar App
• Official Website

Ask for any Aadhaar-related help!''',
        type: 'aadhaar',
        suggestions: [
          'Aadhaar Generation',
          'Aadhaar Update',
          'Aadhaar Download'
        ],
      );
    }
  }

  AIResponse _getPANResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''പാൻ കാർഡ് സേവനങ്ങൾ:

💳 **പാൻ ജനറേഷൻ:**
• ഫോൺ നമ്പർ: 1800-180-1961
• വെബ്സൈറ്റ്: incometax.gov.in
• ആവശ്യമായ രേഖകൾ: ഫോട്ടോ, ഐഡി പ്രൂഫ്

💳 **പാൻ അപ്ഡേറ്റ്:**
• ഓൺലൈൻ: tin.tin.nsdl.com
• ഫിസിക്കൽ ഫോം: എൻഎസ്ഡിഎൽ സെന്റർ

💳 **പാൻ റീപ്രിന്റ്:**
• ഔദ്യോഗിക വെബ്സൈറ്റ്
• ഫോൺ നമ്പർ: 1800-180-1961

പാൻ സംബന്ധിച്ച ഏത് സഹായവും ആവശ്യമുണ്ടെങ്കിൽ ചോദിക്കാം!''',
        type: 'pan',
        suggestions: [
          'പാൻ ജനറേഷൻ',
          'പാൻ അപ്ഡേറ്റ്',
          'പാൻ റീപ്രിന്റ്'
        ],
      );
    } else {
      return AIResponse(
        message: '''PAN Card Services:

💳 **PAN Generation:**
• Phone Number: 1800-180-1961
• Website: incometax.gov.in
• Required Documents: Photo, ID Proof

💳 **PAN Update:**
• Online: tin.tin.nsdl.com
• Physical Form: NSDL Center

💳 **PAN Reprint:**
• Official Website
• Phone Number: 1800-180-1961

Ask for any PAN-related help!''',
        type: 'pan',
        suggestions: [
          'PAN Generation',
          'PAN Update',
          'PAN Reprint'
        ],
      );
    }
  }

  AIResponse _getDrivingLicenseResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''ഡ്രൈവിംഗ് ലൈസൻസ് സേവനങ്ങൾ:

🚗 **ലൈസൻസ് ജനറേഷൻ:**
• ഫോൺ നമ്പർ: 1800-11-0031
• വെബ്സൈറ്റ്: sarathi.parivahan.gov.in
• ആവശ്യമായ രേഖകൾ: മെഡിക്കൽ സർട്ടിഫിക്കറ്റ്, ഫോട്ടോ

🚗 **ലൈസൻസ് റീന്യൂവൽ:**
• ഓൺലൈൻ: sarathi.parivahan.gov.in
• ആർട്ടിഒ ഓഫീസ്: അടുത്തുള്ള ആർട്ടിഒ

🚗 **ലൈസൻസ് ഡ്യൂപ്ലിക്കേറ്റ്:**
• ഔദ്യോഗിക വെബ്സൈറ്റ്
• ഫോൺ നമ്പർ: 1800-11-0031

ലൈസൻസ് സംബന്ധിച്ച ഏത് സഹായവും ആവശ്യമുണ്ടെങ്കിൽ ചോദിക്കാം!''',
        type: 'driving_license',
        suggestions: [
          'ലൈസൻസ് ജനറേഷൻ',
          'ലൈസൻസ് റീന്യൂവൽ',
          'ലൈസൻസ് ഡ്യൂപ്ലിക്കേറ്റ്'
        ],
      );
    } else {
      return AIResponse(
        message: '''Driving License Services:

🚗 **License Generation:**
• Phone Number: 1800-11-0031
• Website: sarathi.parivahan.gov.in
• Required Documents: Medical Certificate, Photo

🚗 **License Renewal:**
• Online: sarathi.parivahan.gov.in
• RTO Office: Nearest RTO

🚗 **License Duplicate:**
• Official Website
• Phone Number: 1800-11-0031

Ask for any license-related help!''',
        type: 'driving_license',
        suggestions: [
          'License Generation',
          'License Renewal',
          'License Duplicate'
        ],
      );
    }
  }

  AIResponse _getDefaultResponse(bool isMalayalam) {
    if (isMalayalam) {
      return AIResponse(
        message: '''സർക്കാർ ഡോക്യുമെന്റ് സേവനങ്ങളിൽ സഹായിക്കാൻ ഞാൻ ഇവിടെയുണ്ട്!

എനിക്ക് സഹായിക്കാൻ കഴിയുന്ന കാര്യങ്ങൾ:
• ഡോക്യുമെന്റ് പുനർനവീകരണം
• അപേക്ഷ നില പരിശോധന
• ഫോം പൂരിപ്പിക്കൽ സഹായം
• കാലഹരണപ്പെടൽ തീയതികൾ
• സർക്കാർ സേവനങ്ങൾ

എന്തെങ്കിലും ചോദിക്കാം!''',
        type: 'general',
        suggestions: [
          'ഡോക്യുമെന്റുകൾ പുനർനവീകരിക്കുക',
          'നില പരിശോധിക്കുക',
          'ഫോം സഹായം'
        ],
      );
    } else {
      return AIResponse(
        message: '''I'm here to help you with government document services!

I can help you with:
• Document renewal
• Application status checking
• Form filling assistance
• Expiry dates
• Government services

Ask me anything!''',
        type: 'general',
        suggestions: [
          'Renew Documents',
          'Check Status',
          'Form Help'
        ],
      );
    }
  }
}
