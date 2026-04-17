class QuizOption {
  final String textEn;
  final String textHi;
  final int vataValue;
  final int pittaValue;
  final int kaphaValue;

  const QuizOption({
    required this.textEn,
    required this.textHi,
    this.vataValue = 0,
    this.pittaValue = 0,
    this.kaphaValue = 0,
  });
}

class QuizQuestion {
  final String id;
  final String textEn;
  final String textHi;
  final List<QuizOption> options;

  const QuizQuestion({
    required this.id,
    required this.textEn,
    required this.textHi,
    required this.options,
  });
}

class PrakritiQuizData {
  static const List<QuizQuestion> questions = [
    QuizQuestion(
      id: 'frame',
      textEn: 'What is your natural body frame?',
      textHi: 'आपकी प्राकृतिक शारीरिक बनावट कैसी है?',
      options: [
        QuizOption(textEn: 'Narrow/Thin', textHi: 'पतला/छरहरा', vataValue: 1),
        QuizOption(textEn: 'Medium/Athletic', textHi: 'मध्यम/एथलेटिक', pittaValue: 1),
        QuizOption(textEn: 'Large/Solid', textHi: 'चौड़ा/मजबूत', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'skin',
      textEn: 'How would you describe your skin?',
      textHi: 'आप अपनी त्वचा का वर्णन कैसे करेंगे?',
      options: [
        QuizOption(textEn: 'Dry/Rough', textHi: 'रूखी/खुरदरी', vataValue: 1),
        QuizOption(textEn: 'Sensitive/Warm', textHi: 'संवेदनशील/गर्म', pittaValue: 1),
        QuizOption(textEn: 'Oily/Smooth', textHi: 'तेलीय/चिकनी', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'hair',
      textEn: 'What is the texture of your hair?',
      textHi: 'आपके बालों की बनावट कैसी है?',
      options: [
        QuizOption(textEn: 'Dry/Frizzy/Thin', textHi: 'रूखे/घुंघराले/पतले', vataValue: 1),
        QuizOption(textEn: 'Fine/Early Gray', textHi: 'महीन/जल्द सफेद होने वाले', pittaValue: 1),
        QuizOption(textEn: 'Thick/Shiny/Oily', textHi: 'घने/चमकदार/तेलीय', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'digestion',
      textEn: 'How is your digestion generally?',
      textHi: 'आपका पाचन आम तौर पर कैसा रहता है?',
      options: [
        QuizOption(textEn: 'Irregular/Gas-prone', textHi: 'अनियमित/गैस की समस्या', vataValue: 1),
        QuizOption(textEn: 'Strong/Frequent Acidity', textHi: 'तीव्र/अक्सर एसिडिटी', pittaValue: 1),
        QuizOption(textEn: 'Slow/Heavy after meals', textHi: 'धीमा/खाने के बाद भारीपन', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'sleep',
      textEn: 'How do you typically sleep?',
      textHi: 'आप आमतौर पर कैसे सोते हैं?',
      options: [
        QuizOption(textEn: 'Light/Interrupted', textHi: 'हल्की/बीच में टूटने वाली', vataValue: 1),
        QuizOption(textEn: 'Moderate/Restful', textHi: 'मध्यम/आरामदायक', pittaValue: 1),
        QuizOption(textEn: 'Heavy/Long/Hard to wake', textHi: 'गहरी/लंबी/मुश्किल से जागना', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'speech',
      textEn: 'How would you describe your speech?',
      textHi: 'आप अपनी वाणी का वर्णन कैसे करेंगे?',
      options: [
        QuizOption(textEn: 'Fast/Talkative', textHi: 'तेज/बातूनी', vataValue: 1),
        QuizOption(textEn: 'Precise/Direct/Argumentative', textHi: 'सटीक/सीधी/तार्किक', pittaValue: 1),
        QuizOption(textEn: 'Slow/Thoughtful/Pleasant', textHi: 'धीमी/विचारशील/मधुर', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'weather',
      textEn: 'Which weather do you prefer?',
      textHi: 'आप कौन सा मौसम पसंद करते हैं?',
      options: [
        QuizOption(textEn: 'Warm/Tropical', textHi: 'गर्म/उष्णकटिबंधीय', vataValue: 1),
        QuizOption(textEn: 'Cool/Windy', textHi: 'ठंडा/हवादार', pittaValue: 1),
        QuizOption(textEn: 'Dry/Sunny', textHi: 'सूखा/धूप वाला', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'stamina',
      textEn: 'What is your physical stamina like?',
      textHi: 'आपकी शारीरिक सहनशक्ति कैसी है?',
      options: [
        QuizOption(textEn: 'Low/Variable energy', textHi: 'कम/बदलती ऊर्जा', vataValue: 1),
        QuizOption(textEn: 'Moderate/Competitive', textHi: 'मध्यम/प्रतिस्पर्धी', pittaValue: 1),
        QuizOption(textEn: 'High/Great endurance', textHi: 'अधिक/महान सहनशक्ति', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'memory',
      textEn: 'How is your memory?',
      textHi: 'आपकी याददाश्त कैसी है?',
      options: [
        QuizOption(textEn: 'Quick to learn, Quick to forget', textHi: 'जल्द सीखना, जल्द भूलना', vataValue: 1),
        QuizOption(textEn: 'Sharp/Logical/Focused', textHi: 'तेज/तार्किक/केंद्रित', pittaValue: 1),
        QuizOption(textEn: 'Slow to learn, Long-lasting', textHi: 'धीरे सीखना, लंबे समय तक याद रहना', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'mind',
      textEn: 'What is the usual state of your mind?',
      textHi: 'आपके मन की सामान्य स्थिति क्या है?',
      options: [
        QuizOption(textEn: 'Restless/Active/Creative', textHi: 'अशांत/सक्रिय/रचनात्मक', vataValue: 1),
        QuizOption(textEn: 'Intense/Determined/Focused', textHi: 'तीव्र/दृढ़/केंद्रित', pittaValue: 1),
        QuizOption(textEn: 'Calm/Graceful/Stable', textHi: 'शांत/सुंदर/स्थिर', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'walk',
      textEn: 'How do you usually walk?',
      textHi: 'आप आमतौर पर कैसे चलते हैं?',
      options: [
        QuizOption(textEn: 'Fast/Hurried', textHi: 'तेज/जल्दबाजी में', vataValue: 1),
        QuizOption(textEn: 'Steady/Purposeful', textHi: 'स्थिर/उद्देश्यपूर्ण', pittaValue: 1),
        QuizOption(textEn: 'Slow/Elegant', textHi: 'धीमी/शालीन', kaphaValue: 1),
      ],
    ),
    QuizQuestion(
      id: 'appetite',
      textEn: 'How would you describe your appetite?',
      textHi: 'आप अपनी भूख का वर्णन कैसे करेंगे?',
      options: [
        QuizOption(textEn: 'Irregular/Variable', textHi: 'अनियमित/बदलती हुई', vataValue: 1),
        QuizOption(textEn: 'Intense/Cannot miss meals', textHi: 'तीव्र/खाना नहीं छोड़ सकते', pittaValue: 1),
        QuizOption(textEn: 'Moderate/Constant', textHi: 'मध्यम/स्थिर', kaphaValue: 1),
      ],
    ),
  ];
}
