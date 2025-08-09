import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/ai_service.dart';
import '../utils/responsive_utils.dart';

class AiChatbotScreen extends StatefulWidget {
  const AiChatbotScreen({super.key});

  @override
  State<AiChatbotScreen> createState() => _AiChatbotScreenState();
}

class _AiChatbotScreenState extends State<AiChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  final AIService _aiService = AIService();

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(ChatMessage(
      text: "Hello! I'm AARAM AI, your government document assistant. I can help you with:\n\n• Document renewal procedures\n• Application status tracking\n• Form filling assistance\n• Expiry date information\n• Government service queries\n\nHow can I help you today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/ChatGPT Image Aug 8, 2025, 04_57_08 PM.png',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AARAM AI',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
                Text(
                  themeProvider.getText('online'),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1E3A8A)),
            onPressed: _showChatOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Actions
          _buildQuickActions(themeProvider),
          
          // Chat Messages
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState(themeProvider)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(_messages[index], themeProvider);
                    },
                  ),
          ),
          
          // Typing Indicator
          if (_isTyping) _buildTypingIndicator(themeProvider),
          
          // Message Input
          _buildMessageInput(themeProvider),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeProvider themeProvider) {
    final List<Map<String, dynamic>> actions = [
      {'text': themeProvider.getText('renew_documents'), 'icon': Icons.refresh},
      {'text': themeProvider.getText('check_status'), 'icon': Icons.track_changes},
      {'text': themeProvider.getText('form_help'), 'icon': Icons.help},
      {'text': themeProvider.getText('expiry_dates'), 'icon': Icons.calendar_today},
    ];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => _sendQuickMessage(action['text'] as String),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF1E3A8A).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      action['icon'] as IconData,
                      size: 16,
                      color: const Color(0xFF1E3A8A),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      action['text'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E3A8A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ThemeProvider themeProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            themeProvider.getText('start_conversation'),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            themeProvider.getText('ask_about_documents'),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message, ThemeProvider themeProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isUser ? const Color(0xFF1E3A8A) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: message.isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.timestamp),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.smart_toy,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                _buildTypingDot(1),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600 + (index * 200)),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildMessageInput(ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: themeProvider.getText('type_message'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    _messageController.clear();
    _addUserMessage(message);
    _getAIResponse(message);
  }

  void _sendQuickMessage(String action) {
    String message = '';
    switch (action) {
      case 'Renew Documents':
        message = 'How do I renew my documents?';
        break;
      case 'Check Status':
        message = 'How can I check my application status?';
        break;
      case 'Form Help':
        message = 'I need help filling government forms';
        break;
      case 'Expiry Dates':
        message = 'When do my documents expire?';
        break;
      case 'ഡോക്യുമെന്റുകൾ പുനർനവീകരിക്കുക':
        message = 'എനിക്ക് ഡോക്യുമെന്റുകൾ പുനർനവീകരിക്കാൻ എങ്ങനെ?';
        break;
      case 'നില പരിശോധിക്കുക':
        message = 'എനിക്ക് അപേക്ഷ നില എങ്ങനെ പരിശോധിക്കാം?';
        break;
      case 'ഫോം സഹായം':
        message = 'സർക്കാർ ഫോമുകൾ പൂരിപ്പിക്കാൻ സഹായം വേണം';
        break;
      case 'കാലഹരണപ്പെടൽ തീയതികൾ':
        message = 'എന്റെ ഡോക്യുമെന്റുകൾ എപ്പോൾ കാലഹരണപ്പെടും?';
        break;
    }
    _addUserMessage(message);
    _getAIResponse(message);
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _getAIResponse(String userMessage) async {
    setState(() {
      _isTyping = true;
    });

    try {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final aiResponse = await _aiService.getAIResponse(userMessage, themeProvider.currentLanguage);
      
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          text: aiResponse.message,
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          text: 'Sorry, I encountered an error. Please try again.',
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    }
  }

  void _simulateAIResponse(String userMessage) {
    setState(() {
      _isTyping = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          text: _generateAIResponse(userMessage),
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    });
  }

  String _generateAIResponse(String userMessage) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isMalayalam = themeProvider.currentLanguage == 'Malayalam';
    final lowerMessage = userMessage.toLowerCase();
    
    // Document renewal queries
    if (lowerMessage.contains('renew') || lowerMessage.contains('പുനർനവീകരിക്ക')) {
      if (isMalayalam) {
        return '''നിങ്ങളുടെ ഡോക്യുമെന്റുകൾ പുനർനവീകരിക്കാനുള്ള വഴികൾ:

**ആധാർ കാർഡ്:**
• uidai.gov.in സന്ദർശിക്കുക അല്ലെങ്കിൽ അടുത്തുള്ള ആധാർ സെന്റർ
• ആവശ്യമെങ്കിൽ ബയോമെട്രിക്സ് അപ്ഡേറ്റ് ചെയ്യുക
• കാലഹരണപ്പെടൽ തീയതി ഇല്ല, പക്ഷേ വിവരങ്ങൾ മാറുകയാണെങ്കിൽ അപ്ഡേറ്റ് ചെയ്യുക

**പാൻ കാർഡ്:**
• incometax.gov.in സന്ദർശിക്കുക
• പുതിയ പാൻ നൽകാൻ ഫോം 49A ഉപയോഗിക്കുക
• വിദേശ വംശജർക്ക് ഫോം 49AA ഉപയോഗിക്കുക
• പ്രോസസിംഗ് സമയം: 15-20 ദിവസം

**ഡ്രൈവിംഗ് ലൈസൻസ്:**
• sarathi.parivahan.gov.in സന്ദർശിക്കുക
• കാലഹരണപ്പെടുന്നതിന് 30 ദിവസം മുമ്പ് പുനർനവീകരിക്കുക
• ആവശ്യമെങ്കിൽ മെഡിക്കൽ സർട്ടിഫിക്കറ്റ് സമർപ്പിക്കുക
• ഫീസ്: സംസ്ഥാനത്തിനനുസരിച്ച് ₹200-500

**പാസ്പോർട്ട്:**
• passportindia.gov.in സന്ദർശിക്കുക
• കാലഹരണപ്പെടുന്നതിന് 1 വർഷം മുമ്പ് അപേക്ഷിക്കുക
• ആവശ്യമായ ഡോക്യുമെന്റുകൾ സമർപ്പിക്കുക
• പ്രോസസിംഗ് സമയം: 4-6 ആഴ്ച

ഏതെങ്കിലും ഡോക്യുമെന്റിനെക്കുറിച്ച് വിശദ വിവരങ്ങൾ വേണമോ?''';
      } else {
        return '''Here's how to renew your documents:

**Aadhaar Card:**
• Visit uidai.gov.in or nearest Aadhaar center
• Update biometrics if needed
• No expiry date, but update if details change

**PAN Card:**
• Visit incometax.gov.in
• Use Form 49A for new PAN
• Use Form 49AA for foreign nationals
• Processing time: 15-20 days

**Driving License:**
• Visit sarathi.parivahan.gov.in
• Renew 30 days before expiry
• Submit medical certificate if required
• Fee: ₹200-500 depending on state

**Passport:**
• Visit passportindia.gov.in
• Apply 1 year before expiry
• Submit required documents
• Processing time: 4-6 weeks

Would you like specific details for any document?''';
      }
    }
    
    // Status checking queries
    if (lowerMessage.contains('status') || lowerMessage.contains('നില')) {
      if (isMalayalam) {
        return '''നിങ്ങളുടെ അപേക്ഷ നില പരിശോധിക്കാനുള്ള വഴികൾ:

**ഓൺലൈൻ രീതികൾ:**
• ബന്ധപ്പെട്ട സർക്കാർ പോർട്ടലുകൾ സന്ദർശിക്കുക
• അപേക്ഷ റഫറൻസ് നമ്പർ ഉപയോഗിക്കുക
• എസ്എംഎസ്/ഇമെയിൽ അറിയിപ്പുകൾ പരിശോധിക്കുക

**ഓഫ്ലൈൻ രീതികൾ:**
• അടുത്തുള്ള സർക്കാർ ഓഫീസ് സന്ദർശിക്കുക
• ഹെൽപ്ലൈൻ നമ്പറുകൾ വിളിക്കുക
• IVRS സേവനങ്ങൾ ഉപയോഗിക്കുക

**സാധാരണ നില തരങ്ങൾ:**
• സമർപ്പിച്ചു - അപേക്ഷ ലഭിച്ചു
• അവലോകനത്തിൽ - പ്രോസസ് ചെയ്യുന്നു
• ഡോക്യുമെന്റുകൾ ആവശ്യമാണ് - കൂടുതൽ വിവരങ്ങൾ ആവശ്യമാണ്
• അനുവദിച്ചു - അപേക്ഷ വിജയകരമാണ്
• നിരസിച്ചു - അപേക്ഷ നിരസിച്ചു

**ഹെൽപ്ലൈൻ നമ്പറുകൾ:**
• ആധാർ: 1947
• പാൻ: 1800-180-1961
• പാസ്പോർട്ട്: 1800-258-1800
• ഡ്രൈവിംഗ് ലൈസൻസ്: സംസ്ഥാനത്തിനനുസരിച്ച് വ്യത്യാസപ്പെടും

ഏതെങ്കിലും പ്രത്യേക അപേക്ഷ പരിശോധിക്കാൻ സഹായിക്കണോ?''';
      } else {
        return '''To check your application status:

**Online Methods:**
• Visit respective government portals
• Use application reference number
• Check SMS/email notifications

**Offline Methods:**
• Visit nearest government office
• Call helpline numbers
• Use IVRS services

**Common Status Types:**
• Submitted - Application received
• Under Review - Being processed
• Documents Required - Additional info needed
• Approved - Application successful
• Rejected - Application denied

**Helpline Numbers:**
• Aadhaar: 1947
• PAN: 1800-180-1961
• Passport: 1800-258-1800
• Driving License: Varies by state

Would you like me to help you check a specific application?''';
      }
    }
    
    // Form help queries
    if (lowerMessage.contains('form') || lowerMessage.contains('ഫോം')) {
      if (isMalayalam) {
        return '''സർക്കാർ ഫോമുകളിൽ സഹായിക്കാം:

**സാധാരണ ഫോമുകൾ & സഹായം:**
• ആധാർ അപ്ഡേറ്റ് ഫോം - വിലാസം/ഫോട്ടോ മാറ്റങ്ങൾക്ക്
• പാൻ അപ്ലിക്കേഷൻ ഫോം 49A - പുതിയ പാൻ കാർഡുകൾക്ക്
• പാസ്പോർട്ട് അപ്ലിക്കേഷൻ ഫോം - പുതിയത്/പുനർനവീകരണം
• ഡ്രൈവിംഗ് ലൈസൻസ് ഫോം - പുതിയത്/പുനർനവീകരണം

**പൊതു നുറുങ്ങുകൾ:**
• എല്ലാ ഒറിജിനൽ ഡോക്യുമെന്റുകളും തയ്യാറാക്കുക
• ഫോട്ടോകൾ സ്പെസിഫിക്കേഷനുകൾ പാലിക്കുന്നുണ്ടെന്ന് ഉറപ്പാക്കുക
• എല്ലാ വിവരങ്ങളും ഇരട്ടി പരിശോധിക്കുക
• സാധുതാ കാലയളവിനുള്ളിൽ സമർപ്പിക്കുക
• റഫറൻസിനായി കോപ്പികൾ സൂക്ഷിക്കുക

**ഡോക്യുമെന്റ് ആവശ്യകതകൾ:**
• ഐഡന്റിറ്റി പ്രൂഫ് (ആധാർ/പാൻ)
• വിലാസ പ്രൂഫ് (യൂട്ടിലിറ്റി ബില്ലുകൾ)
• ജനന സർട്ടിഫിക്കറ്റ്
• പാസ്പോർട്ട് സൈസ് ഫോട്ടോകൾ
• പേയ്മെന്റ് പ്രൂഫ്

**ഒഴിവാക്കേണ്ട സാധാരണ തെറ്റുകൾ:**
• തെറ്റായ സ്പെല്ലിംഗുകൾ
• ഒഴിഞ്ഞ ഒപ്പുകൾ
• കാലഹരണപ്പെട്ട ഡോക്യുമെന്റുകൾ
• തെറ്റായ ഫോട്ടോ സ്പെസിഫിക്കേഷനുകൾ
• അപൂർണ്ണമായ വിവരങ്ങൾ

ഏത് പ്രത്യേക ഫോമിൽ സഹായം വേണം?''';
      } else {
        return '''I can help you with government forms:

**Common Forms & Help:**
• Aadhaar Update Form - For address/photo changes
• PAN Application Form 49A - For new PAN cards
• Passport Application Form - For new/renewal
• Driving License Form - For new/renewal

**General Tips:**
• Keep all original documents ready
• Ensure photos meet specifications
• Double-check all information
• Submit within validity period
• Keep copies for reference

**Document Requirements:**
• Identity proof (Aadhaar/PAN)
• Address proof (Utility bills)
• Birth certificate
• Passport size photos
• Payment proof

**Common Mistakes to Avoid:**
• Incorrect spellings
• Missing signatures
• Expired documents
• Wrong photo specifications
• Incomplete information

Which specific form do you need help with?''';
      }
    }
    
    // Expiry date queries
    if (lowerMessage.contains('expir') || lowerMessage.contains('കാലഹരണ')) {
      if (isMalayalam) {
        return '''ഡോക്യുമെന്റുകളുടെ സാധാരണ കാലഹരണപ്പെടൽ കാലയളവുകൾ:

**ആധാർ കാർഡ്:**
• കാലഹരണപ്പെടൽ തീയതി ഇല്ല
• വിവരങ്ങൾ മാറുകയാണെങ്കിൽ അപ്ഡേറ്റ് ചെയ്യുക
• 10 വർഷം마다 ബയോമെട്രിക് അപ്ഡേറ്റ് ശുപാർശ ചെയ്യുന്നു

**പാൻ കാർഡ്:**
• കാലഹരണപ്പെടൽ തീയതി ഇല്ല
• ജീവിതകാലത്തേക്ക് സാധുവാണ്
• വിവരങ്ങൾ മാറുകയാണെങ്കിൽ അപ്ഡേറ്റ് ചെയ്യുക

**ഡ്രൈവിംഗ് ലൈസൻസ്:**
• ഇഷ്യൂ തീയതിയിൽ നിന്ന് 20 വർഷം
• കാലഹരണപ്പെടുന്നതിന് 30 ദിവസം മുമ്പ് പുനർനവീകരിക്കുക
• പുനർനവീകരണത്തിന് മെഡിക്കൽ സർട്ടിഫിക്കറ്റ് ആവശ്യമാണ്

**പാസ്പോർട്ട്:**
• ഇഷ്യൂ തീയതിയിൽ നിന്ന് 10 വർഷം
• കാലഹരണപ്പെടുന്നതിന് 1 വർഷം മുമ്പ് പുനർനവീകരണത്തിന് അപേക്ഷിക്കുക
• കുട്ടികൾക്ക് വ്യത്യസ്ത സാധുത

**വോട്ടർ ഐഡി:**
• കാലഹരണപ്പെടൽ തീയതി ഇല്ല
• വിലാസം മാറുകയാണെങ്കിൽ അപ്ഡേറ്റ് ചെയ്യുക
• ജീവിതകാലത്തേക്ക് സാധുവാണ്

**ജനന സർട്ടിഫിക്കറ്റ്:**
• കാലഹരണപ്പെടൽ തീയതി ഇല്ല
• ജീവിതകാലത്തേക്ക് സാധുവാണ്
• വ്യത്യസ്ത ആവശ്യങ്ങൾക്ക് ഒന്നിലധികം കോപ്പികൾ ലഭിക്കുക

**പ്രധാന കുറിപ്പുകൾ:**
• കാലഹരണപ്പെടുന്നതിന് 30-60 ദിവസം മുമ്പ് ഓർമ്മപ്പെടുത്തലുകൾ സജ്ജമാക്കുക
• ബാക്കപ്പായി ഡിജിറ്റൽ കോപ്പികൾ സൂക്ഷിക്കുക
• വിലാസ മാറ്റങ്ങൾ ഉടൻ അപ്ഡേറ്റ് ചെയ്യുക
• ഡോക്യുമെന്റ് ചരിത്രം പരിപാലിക്കുക

കാലഹരണപ്പെടൽ ഓർമ്മപ്പെടുത്തലുകൾ സജ്ജമാക്കാൻ സഹായിക്കണോ?''';
      } else {
        return '''Here are typical expiry periods for documents:

**Aadhaar Card:**
• No expiry date
• Update if details change
• Biometric update every 10 years recommended

**PAN Card:**
• No expiry date
• Valid for lifetime
• Update if details change

**Driving License:**
• 20 years from issue date
• Renew 30 days before expiry
• Medical certificate required for renewal

**Passport:**
• 10 years from issue date
• Apply for renewal 1 year before expiry
• Different validity for minors

**Voter ID:**
• No expiry date
• Update if address changes
• Valid for lifetime

**Birth Certificate:**
• No expiry date
• Valid for lifetime
• Get multiple copies for different purposes

**Important Notes:**
• Set reminders 30-60 days before expiry
• Keep digital copies as backup
• Update address changes promptly
• Maintain document history

Would you like me to help you set up expiry reminders?''';
      }
    }
    
    // General government services
    if (lowerMessage.contains('government') || lowerMessage.contains('സർക്കാർ')) {
      if (isMalayalam) {
        return '''സഹായിക്കാൻ കഴിയുന്ന പ്രധാന സർക്കാർ സേവനങ്ങൾ:

**ഡോക്യുമെന്റ് സേവനങ്ങൾ:**
• ആധാർ സേവനങ്ങൾ (UIDAI)
• പാൻ കാർഡ് സേവനങ്ങൾ (ഇൻകം ടാക്സ്)
• പാസ്പോർട്ട് സേവനങ്ങൾ (MEA)
• ഡ്രൈവിംഗ് ലൈസൻസ് (RTO)
• വോട്ടർ ഐഡി (ECI)

**ഓൺലൈൻ പോർട്ടലുകൾ:**
• ഡിജിലോക്കർ - ഡിജിറ്റൽ ഡോക്യുമെന്റ് സംഭരണം
• UMANG - ഏകീകൃത സർക്കാർ സേവനങ്ങൾ
• MyGov - പൗര ഇടപെടൽ
• eCourts - നിയമ സേവനങ്ങൾ

**അടിയന്തിര സേവനങ്ങൾ:**
• പോലീസ്: 100
• ആംബുലൻസ്: 108
• സ്ത്രീ ഹെൽപ്ലൈൻ: 1091
• കുട്ടികളുടെ ഹെൽപ്ലൈൻ: 1098

**പ്രധാന വെബ്സൈറ്റുകൾ:**
• uidai.gov.in - ആധാർ
• incometax.gov.in - പാൻ/നികുതി
• passportindia.gov.in - പാസ്പോർട്ട്
• sarathi.parivahan.gov.in - ഡ്രൈവിംഗ് ലൈസൻസ്

**ഡിജിറ്റൽ സേവനങ്ങൾ:**
• ഡിജിറ്റൽ ഒപ്പുകൾ
• ഓൺലൈൻ പേയ്മെന്റുകൾ
• ഡോക്യുമെന്റ് വെരിഫിക്കേഷൻ
• നില പിന്തുടരൽ

ഏത് പ്രത്യേക സേവനത്തെക്കുറിച്ച് വിവരങ്ങൾ വേണം?''';
      } else {
        return '''Here are key government services I can help with:

**Document Services:**
• Aadhaar services (UIDAI)
• PAN card services (Income Tax)
• Passport services (MEA)
• Driving License (RTO)
• Voter ID (ECI)

**Online Portals:**
• DigiLocker - Digital document storage
• UMANG - Unified government services
• MyGov - Citizen engagement
• eCourts - Legal services

**Emergency Services:**
• Police: 100
• Ambulance: 108
• Women Helpline: 1091
• Child Helpline: 1098

**Important Websites:**
• uidai.gov.in - Aadhaar
• incometax.gov.in - PAN/Tax
• passportindia.gov.in - Passport
• sarathi.parivahan.gov.in - Driving License

**Digital Services:**
• Digital signatures
• Online payments
• Document verification
• Status tracking

What specific service do you need information about?''';
      }
    }
    
    // Default response
    if (isMalayalam) {
      return '''സർക്കാർ ഡോക്യുമെന്റ് സേവനങ്ങളിൽ സഹായിക്കാൻ ഞാൻ ഇവിടെയുണ്ട്! 

**സഹായിക്കാൻ കഴിയുന്നത്:**
• ഡോക്യുമെന്റ് പുനർനവീകരണ നടപടികൾ
• അപേക്ഷ നില പിന്തുടരൽ
• ഫോം പൂരിപ്പിക്കൽ മാർഗ്ഗനിർദ്ദേശം
• കാലഹരണപ്പെടൽ തീയതി വിവരങ്ങൾ
• സർക്കാർ സേവന ചോദ്യങ്ങൾ
• ഡിജിറ്റൽ ഡോക്യുമെന്റ് നിയന്ത്രണം

**വേഗ പ്രവർത്തനങ്ങൾ:**
• മുകളിലെ വേഗ പ്രവർത്തന ബട്ടണുകൾ ടാപ്പ് ചെയ്യുക
• ഡോക്യുമെന്റുകളെക്കുറിച്ച് പ്രത്യേക ചോദ്യങ്ങൾ ചോദിക്കുക
• ഘട്ടം ഘട്ടമായുള്ള മാർഗ്ഗനിർദ്ദേശം ലഭിക്കുക
• ഔദ്യോഗിക വെബ്സൈറ്റുകളും ഹെൽപ്ലൈനുകളും കണ്ടെത്തുക

**നിങ്ങൾ ചോദിക്കാവുന്ന ചോദ്യങ്ങളുടെ ഉദാഹരണങ്ങൾ:**
• "എനിക്ക് പാൻ കാർഡ് എങ്ങനെ പുനർനവീകരിക്കാം?"
• "പാസ്പോർട്ടിന് എന്ത് ഡോക്യുമെന്റുകൾ വേണം?"
• "ആധാർ നില എങ്ങനെ പരിശോധിക്കാം?"
• "എന്റെ ഡ്രൈവിംഗ് ലൈസൻസ് എപ്പോൾ കാലഹരണപ്പെടും?"

നിങ്ങളുടെ സർക്കാർ ഡോക്യുമെന്റുകളെക്കുറിച്ച് എന്ത് അറിയണം?''';
    } else {
      return '''I'm here to help you with government document services! 

**I can assist with:**
• Document renewal procedures
• Application status tracking
• Form filling guidance
• Expiry date information
• Government service queries
• Digital document management

**Quick Actions:**
• Tap the quick action buttons above
• Ask specific questions about documents
• Get step-by-step guidance
• Find official websites and helplines

**Examples of questions you can ask:**
• "How do I renew my PAN card?"
• "What documents do I need for passport?"
• "How to check Aadhaar status?"
• "When does my driving license expire?"

What would you like to know about your government documents?''';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _showChatOptions() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: Text(themeProvider.getText('clear_history')),
              onTap: () {
                Navigator.pop(context);
                _clearChat();
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: Text(themeProvider.getText('export_chat')),
              onTap: () {
                Navigator.pop(context);
                _exportChat();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(themeProvider.getText('chat_settings')),
              onTap: () {
                Navigator.pop(context);
                _openChatSettings();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
      _addWelcomeMessage();
    });
  }

  void _exportChat() {
    // TODO: Implement chat export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat export feature coming soon!')),
    );
  }

  void _openChatSettings() {
    // TODO: Implement chat settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat settings feature coming soon!')),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
