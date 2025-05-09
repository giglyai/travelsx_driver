import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE

        // drawer menu
        'en_US': {
          'profile': 'Profile',
          'document': 'Documents',
          'vehicle': 'Vehicle',
          'my_agency': 'My Agency',
          'offers': 'Offers',
          'earnings': 'Earnings',
          'trips': 'Rides',
          'wallet': 'Wallet',
          'notification': 'Notification',
          'logout': 'Logout',
          'terms_condition': 'Terms & Condition',
          'help': 'Help',
          'privacy_policy': 'Privacy Policy',
          'choose_language': 'Choose Language',
          'rides': 'Rides',

          //new user
          'name_address': 'Name Address',
          'name': 'Name',
          'address': 'Address',
          'enter_your_name': 'Enter Your Name',
          'continue': 'Continue',
          'search_for_a_place': 'Search for place',

          //driver onboarding screen and vehicle screen
          'vehicle_details': 'Vehicle Details',
          'add_your_vehicle_details': 'Add your vehicle details',
          'vehicle_category': 'Vehicle Category',
          'select_category': 'Select Category',
          'vehicle_model': 'Vehicle Model',
          'select_model': 'Select Model',
          'vehicle_number': 'Vehicle Number',
          'enter_vehicle_number_here': 'Enter vehicle number here',
          'drivers_license': 'Drivers license',
          'enter_drivers_license_number_here': 'Drivers license',
          'vehicle_type': 'Vehicle Name',
          'save': 'Save',

          //home screen
          'online': 'Online',
          'offline': 'Offline',
          'search': 'Search Rides',
          'upcoming_rides': 'Upcoming Rides',
          'pickup_time': 'Pickup time',
          'start_now': 'Start Now',
          'Do_you_want_to_cancel_this_ride': 'Do you want to cancel this\nride',
          'No_ride_available_moment_please_try_requesting_later':
              'No ride available at this moment. Please try \nrequesting later',
          'ok': 'Ok',
          'how_are_you_travelling_to_user_location?':
              'How are you travelling to user location?',

          //account verified bottomsSheet
          "Your_account_is_not_verified": "Your account is not verified",
          "complete_your_profile": "Complete your profile",
          "upload_the_following_documents": "Upload the following documents",
          "your_account_is_under_verification":
              "Your account is under verification",
          "This_might_take_upto_24_hours": "This might take upto 24 hours",
          "chat_with_help_team": "Chat with help team",

          //driver document screen
          'driver_document': 'Driver Document',
          'select_document_from_gallery': 'Select document from gallery',
          'upload_documents': 'Upload documents',
          'upload_front_side_image_of_your_documents':
              'Upload front side image of your\n Documents',
          'upload_back_side_image_of_your_documents':
              'Upload back side image of your\n Documents',
          'documents_submitted': 'Documents Submitted ',
          'verification_is_under_process': 'Verification is under process',
          'your_account_is_verified': 'Your account is verified',

          //profile screen
          'edit_account': 'Edit Account',
          'first_name': 'First Name',
          'last_name': 'Last Name',
          'phone_number': 'Phone Number',
          'email': 'Email',
          'enter_valid_email': 'Enter Valid Email',
          'account_deletion': 'Account deletion',
          'Choose_from_library': 'Choose from library',
          'take_photo': 'Take Photo',
          'confirm': 'Confirm',
          'cancel': 'Cancel',
          'confirm_deletion': 'Confirm Deletion!',
          'are_you_sure_you_want_to_delete_this_account_permamnently_you_can':
              'Are you sure you want to Delete this account permamnently! You can ',

          // my agencies screen
          'my_agencies': 'My Agencies',

          // offer or promotion screen
          'active': 'Active',
          'completed': 'Completed',
          'no_data_available': 'No data available',

          // earnings screen
          'earning_activity': 'Earning Activity',
          'total_earnings': 'Total Earnings',
          'breakdown': 'Breakdown',
          'total_trips': 'Total Trips',
          'total_distance': 'Total Distance',
          'total_time': 'Total Time',
          'payment_received_for_completed_trip':
              'Payment Received for Completing \nthe Trip',

          //trips screen
          'trip': 'Rides',
          'complete': 'completed',
          'cancelled': 'Cancelled',
          'assigned': 'Assigned',
          'completed_trips': 'Completed Trips',
          'breakdown_trips': 'Breakdown',
          'total_distance_trips': 'Total Distance',
          'total_time_trips': 'Total Time',
          'assigned_trips': 'Assigned Trips',

          //wallet screen
          'wallets': 'Wallet',
          'balance': 'Balance',
          'cash_out_balance': 'Cash Out Balance',
          'no_data': 'No Data',
          'cashout_method"': 'Cashout Method"',
          'bank_account"': 'Bank account ****** 3654',
          'instant_cash_subtotal"': 'Instant cash subtotal',
          'processing_fee"': 'Processing fee',
          'Cash_out_transfer_total"': 'Cash Out Transfer Total',
          'this_transferred"':
              'This is the amount that will be transferred to \nyour bank account when you tap “Cashout”.',
          'add_money': 'Add money',
          'enter_amount': 'Enter amount',
          'you_can_also_select_amount': 'You can also select amount',
          'minimum_amount_100': '(Minimum Amount: INR 100)',
          'inr': 'INR',
          'your_balance': 'Your balance',

          //notification screen
          'notifications': 'Notifications',
          'recent': 'recent',
          'all': 'All',

          //Choose Language screen
          'select_your_language': 'Select your language',
          'you_can_change_your_language_on_this_screen_anytime':
              'you can change your language on this \nscreen anytime',
          'language': 'Language',
          'choose_language_op': 'Choose Language',
          'hindi': 'Hindi',
          'english': 'English',
        },
        //HINDI LANGUAGE
        'hi_IN': {
          // drawer menu
          'profile': 'प्रोफ़ाइल',
          'document': 'दस्तावेज़',
          'vehicle': 'वाहन',
          'my_agency': 'मेरी एजेंसी',
          'offers': 'ऑफर',
          'earnings': 'कमाई',
          'trips': 'यात्राएं',
          'wallet': 'वॉलेट',
          'notification': 'सूचना',
          'logout': 'लॉग आउट करें',
          'terms_condition': 'शर्तें और निबंधन ',
          'help': 'सहायता',
          'privacy_policy': 'गोपनीयता नीति',
          'choose_language': 'भाषा चुनें',
          'rides': 'सवारी',

          //new user
          'name_address': 'नाम और पता',
          'name': 'नाम',
          'address': 'पता',
          'search_for_a_place': 'जगह खोजें',
          'enter_your_name': 'अपना नाम दर्ज करें',
          'continue': 'जारी रखनां',

          //driver onboarding screen and vehicle screen
          'vehicle_details': 'वाहन की सूचना',
          'add_your_vehicle_details': 'अपने वाहन का विवरण जोड़ें',
          'vehicle_category': 'वाहन श्रेणी',
          'select_category': 'श्रेणी चुनना',
          'vehicle_model': 'वाहन मॉडल',
          'select_model': 'श्रेणी मॉडल',
          'vehicle_number': 'गाडी नंबर',
          'enter_vehicle_number_here': 'यहां वाहन नंबर दर्ज करें',
          'drivers_license': 'ड्राइवर का लाइसेंस',
          'enter_drivers_license_number_here':
              'यहां ड्राइवर लाइसेंस नंबर दर्ज करें',
          'vehicle_type': 'वाहन का नाम',
          'save': 'बचाना',

          //home screen
          'online': 'ऑनलाइन',
          'offline': 'ऑफ़लाइन',
          'search': 'खोज',
          'upcoming_rides': 'आगामी सवारी',
          'pickup_time': 'समय लेने',
          'start_now': 'शुरू करें',
          'Do_you_want_to_cancel_this_ride':
              'क्या आप यह यात्रा रद्द करना \nचाहते हैं?',
          'No_ride_available_moment_please_try_requesting_later':
              'इस समय कोई सवारी उपलब्ध नहीं है. कृपया बाद में अनुरोध \nकरने का प्रयास करें',
          'ok': 'ठीक है',
          'how_are_you_travelling_to_user_location?':
              'आप उपयोगकर्ता स्थान की यात्रा कैसे कर रहे हैं?',

          //account verified bottomsSheet
          "Your_account_is_not_verified": "आपका खाता सत्यापित नहीं है",
          "complete_your_profile": "अपनी प्रोफ़ाइल पूरी करें",
          "upload_the_following_documents": "निम्नलिखित दस्तावेज़ अपलोड करें",
          "your_account_is_under_verification":
              "आपका खाता सत्यापन के अंतर्गत है",
          "This_might_take_upto_24_hours":
              "इसमें 24 घंटे तक का समय लग सकता हैै",
          "chat_with_help_team": "सहायता टीम से चैट करें",

          //driver document screen
          'driver_document': 'चालक दस्तावेज़',
          'select_document_from_gallery': 'गैलरी से दस्तावेज़ का चयन करें',
          'upload_documents': 'दस्तावेज़ अपलोड करें',
          'upload_front_side_image_of_your_documents':
              'अपने दस्तावेज़ों की सामने की ओर की छवि\n अपलोड करें',
          'upload_back_side_image_of_your_documents':
              'अपने दस्तावेज़ों की पिछली ओर की छवि\n अपलोड करें',
          'documents_submitted': 'दस्तावेज प्रस्तुत किये गये',
          'verification_is_under_process': 'सत्यापन प्रक्रियाधीन है',
          'your_account_is_verified': 'आपका खाता सत्यापित है',

          //profile screen
          'edit_account': 'खाता संपादित करें',
          'first_name': 'पहला नाम',
          'last_name': 'उपनाम',
          'phone_number': 'फ़ोन नंबर',
          'email': 'ईमेल',
          'enter_valid_email': 'मान्य ईमेल दर्ज करें',
          'account_deletion': 'खाता हटाना',
          'choose_from_library': 'पुस्तकालय से चुनें',
          'take_photo': 'फोटो लो',
          'confirm': 'पुष्टि करना',
          'cancel': 'रद्द करना',
          'confirm_deletion': 'मिटाने की पुष्टि!',
          'are_you_sure_you_want_to_delete_this_account_permamnently_you_can':
              'क्या आप वाकई इस खाते को स्थायी रूप से हटाना चाहते हैं! कर सकते हो',
          'your_account_has_been_deleted': 'आपका खाता हटा दिया गया है',
          'you_can_still_recover_you_account_within_7_days_after_that_it_will_be_lost_forever':
              'आप अभी भी 7 दिनों के भीतर अपना खाता पुनर्प्राप्त कर सकते हैं, \nउसके बाद यह हमेशा के लिए खो जाएगा',

          // my agencies screen
          'my_agencies': 'मेरी एजेंसियाँ',

          // offer or promotion screen
          'active': 'सक्रिय',
          'completed': 'पुरा होना',
          'no_data_available': 'कोई डेटा मौजूद नहीं',

          // earnings screen
          'earning_activity': 'कमाई गतिविधि',
          'total_earnings': 'कुल कमाई',
          'breakdown': 'टूट - फूट',
          'total_trips': 'कुल यात्राएँ',
          'total_distance': 'कुल दूरी',
          'total_time': 'कुल समय',
          'payment_received_for_completed_trip':
              'यात्रा पूरी करने के लिए भुगतान प्राप्त हुआ',

          //trips screen
          'trip': 'ट्रिप्स',
          'complete': 'पुरा होना',
          'cancelled': 'रद्द',
          'assigned': 'सौंपा गया',
          'completed_trips': 'यात्राएँ पूरी कीं',
          'breakdown_trips': 'टूट - फूट',
          'total_distance_trips': 'कुल दूरी',
          'total_time_trips': 'कुल समय',
          'assigned_trips': 'नियुक्त यात्राएँ',

          //wallet screen
          'wallets': 'बटुआ',
          'balance': 'संतुलन',
          'cash_out_balance': 'कैश आउट बैलेंस',
          'no_data': 'कोई डेटा नहीं',
          'cashout_method"': 'कैशआउट विधि',
          'bank_account"': 'बैंक खाता ****** 3654',
          'instant_cash_subtotal"': 'तत्काल नकद उप-योग',
          'processing_fee"': 'प्रक्रमण संसाधन शुल्क',
          'Cash_out_transfer_total"': 'कैश आउट ट्रांसफर कुल',
          'this_transferred"':
              'यह वह राशि है जो "कैशआउट" पर टैप करने पर आपके \nबैंक खाते में स्थानांतरित कर दी जाएगी।',
          'add_money': 'पैसे जोड़ें',
          'enter_amount': 'राशि डालें',
          'you_can_also_select_amount': 'आप राशि भी चुन सकते हैं',
          'minimum_amount_100': '(न्यूनतम राशि: INR 100)',
          'inr': 'आईएनआर',
          'your_balance': 'आपका बैलेंस',

          //notification screen
          'notifications': 'सूचनाएं',
          'recent': 'हाल ही का',
          'all': 'सभी',

          //Choose Language screen
          'select_your_language': 'अपनी भाषा का चयन करें',
          'you_can_change_your_language_on_this_screen_anytime':
              'आप इस स्क्रीन पर कभी भी अपनी \nभाषा बदल सकते हैं',
          'language': 'भाषा',
          'choose_language_op': 'भाषा चुनें',
          'hindi': 'हिंदी',
          'english': 'अंग्रेज़ी',
        },
      };
}
