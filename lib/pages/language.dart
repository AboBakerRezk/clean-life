import 'package:clean_life/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';


mixin AppLocale {
  static const String airs37 = 'Please enter the name of a location or country to search';
  static const String airs38 = 'Descriptive grade:';
  static const String airs1 = 'No water quality data to display.';
  static const String airs36 = 'Water Quality Index:';
  static const String airs40 = 'excellent';
  static const String air1 = 'Loading...';
  static const String air2 = 'Loading site...';
  static const String air3 = 'Sweden';
  static const String air4 = 'Finland';
  static const String air5 = 'New Zealand';
  static const String air6 = 'India';
  static const String air7 = 'China';
  static const String air8 = 'Pakistan';
  static const String air9 = 'Copenhagen';
  static const String air10 = 'Helsinki';
  static const String air11 = 'Oslo';
  static const String air12 = 'Delhi';
  static const String air13 = 'Beijing';
  static const String air14 = 'Kaol Walmor';
  static const String air15 = 'Air quality data not found.';
  static const String air16 = 'An error occurred while fetching data.';
  static const String air17 = 'Internet connection error.';
  static const String air18 = 'Location services are disabled.';
  static const String air19 = 'Location permission denied.';
  static const String air20 = 'Location permission permanently denied.';
  static const String air21 = 'Your current location';
  static const String air22 = 'Air quality data not found.';
  static const String air23 = 'An error occurred while fetching air quality data.';
  static const String air24 = 'Internet connection error or obtaining location.:';
  static const String air25 = 'Location:';
  static const String air26 = 'Location not found.';
  static const String air27 = 'Internet connection error.';
  static const String air28 = 'Good';
  static const String air29 = 'Acceptable';
  static const String air30 = 'Moderate';
  static const String air31 = 'Poor';
  static const String air32 = 'Very Poor';
  static const String air33 = 'Unknown';
  static const String air34 = 'Air Quality Index';
  static const String air35 = 'Enter city name';
  static const String air36 = 'Air Quality Index:';
  static const String air37 = 'Tips for dealing with current air quality';
  static const String air38 = 'Pollutants and their concentrations';
  static const String air39 = 'Best and worst countries';
  static const String air40 = 'Map';
  static const String air41 = 'About the app';
  static const String air42 = 'Learn more';
  static const String air43 = 'Low';
  static const String air44 = 'Moderate';
  static const String air45 = 'High';
  static const String air46 = 'Unable to open link';
  static const String air47 = 'About the app';
  static const String air48 = 'App description';
  static const String air49 = 'This app helps users monitor real-time air quality based on live API data. The app allows users to know the air quality status at their current locations or manually.\n\nThe app provides data on pollutants such as PM2.5 and PM10 and CO, and also allows users to get tips on how to protect themselves from air pollution.';
  static const String air50 = 'Developer contact information';
  static const String air51 = 'Email:';
  static const String air52 = 'Data source:';
  static const String air53 = 'Why did you design this app?';
  static const String air54 = 'This app was designed to help individuals improve their awareness of the air quality around them and protect their health and that of their loved ones. Since air pollution poses an increasing threat to public health, the app aims to provide accurate and updated information about air quality in an easy and simplified manner.';
  static const String air55 = '- Enable users to know the air quality status in their area moment by moment.\n- Provide practical tips to maintain their health when facing high pollution levels.\n- Contribute to enhancing environmental awareness and encouraging healthy behaviors.';
  static const String air56 = 'Icon message';
  static const String air57 = 'We strive to make the world a healthier place by facilitating access to air quality information and supporting individuals in making informed decisions to protect their health and that of their communities.';
  static const String air58 = 'Explanation of the bird icon';
  static const String air59 = 'The bird icon was carefully chosen to convey the app\'s core message. The bird symbolizes:\n\n1. Purity and clean air:\nBirds are usually a symbol of a clean and healthy environment, as they do not live in polluted areas. The icon represents hope for a better environment and clean air.\n\n2. Freedom and proper breathing:\nThe bird\'s free flight symbolizes breathing freely without worrying about air pollution.\n\n3. Connection to nature:\nThe bird gently reminds us of nature and our need to preserve it through awareness of air quality and supporting environmental efforts.';
  static const String air60 = 'The icon is not just a design; it is a call to users to care about the air quality around them, protect themselves and nature, and achieve a better balance between humans and the environment.';
  static const String air61 = 'Location services are disabled';
  static const String air62 = 'Please enable location services to access the app\'s features.';
  static const String air63 = 'OK';
  static const String air64 = 'Location permissions denied';
  static const String air65 = 'Please allow permissions to access your location.';
  static const String air66 = 'Retry';
  static const String air67 = 'Location permissions permanently denied';
  static const String air68 = 'Please enable permissions from the app settings to access your location.';
  static const String air69 = 'Open settings';
  static const String air70 = 'Failed to fetch air quality data. Please try again later.';
  static const String air71 = 'An error occurred while fetching data. Please check your internet connection and try again.';
  static const String air72 = 'Error';
  static const String air73 = 'OK';
  static const String air74 = 'Good';
  static const String air75 = 'Moderate';
  static const String air76 = 'Unhealthy';
  static const String air77 = 'Very Unhealthy';
  static const String air78 = 'Hazardous';
  static const String air79 = 'Unknown';
  static const String air80 = 'Your current location';
  static const String air81 = 'Air Quality Level';
  static const String air82 = 'Air Quality';
  static const String air83 = 'Air pollution has become a critical issue directly affecting our health and environment. Air pollution results from many human activities such as industrial vehicles, emissions from factories and vehicles. It can lead to respiratory diseases and heart diseases, in addition to its impact on the environment in general.';
  static const String air84 = 'Tips for dealing with air quality:';
  static const String air85 = 'Additional tips:';
  static const String air86 = 'In the end, paying attention to air quality and protecting your health is essential. Everyone can play a role in reducing pollution and maintaining a healthy environment for all. If we all work together, we can improve air quality and ensure a better life for future generations.';
 static const String air94 = '1. Make sure to know the daily Air Quality Index in your area and follow local instructions regarding outdoor activities.';
  static const String air95 = '2. When air quality is poor, try to stay indoors as much as possible and avoid crowded places.';
  static const String air96 = '3. If you suffer from respiratory diseases, consult your doctor on how to protect yourself from the effects of pollution.';
  static const String air97 = '4. Engage with the local community and participate in efforts to reduce pollution.';
  static const String air98 = 'New Delhi';
  static const String air99 = 'Lahore';
  static const String air100 = 'Dhaka';
  static const String air101 = 'Karachi';
  static const String air102 = 'Beijing';
  static const String air103 = 'Ulaanbaatar';
  static const String air104 = 'Cairo';
  static const String air105 = 'Jakarta';
  static const String air106 = 'Baghdad';
  static const String air107 = 'Mumbai';
  static const String air108 = 'India';
  static const String air109 = 'Pakistan';
  static const String air110 = 'Bangladesh';
  static const String air111 = 'Pakistan';
  static const String air112 = 'China';
  static const String air113 = 'Mongolia';
  static const String air114 = 'Egypt';
  static const String air115 = 'Indonesia';
  static const String air116 = 'Iraq';
  static const String air117 = 'India';
  static const String air118 = 'Reykjavik';
  static const String air119 = 'Zurich';
  static const String air120 = 'Helsinki';
  static const String air121 = 'Vancouver';
  static const String air122 = 'Calgary';
  static const String air123 = 'Wellington';
  static const String air124 = 'Portland';
  static const String air125 = 'Stockholm';
  static const String air126 = 'Oslo';
  static const String air127 = 'Copenhagen';
  static const String air128 = 'Iceland';
  static const String air129 = 'Switzerland';
  static const String air130 = 'Finland';
  static const String air131 = 'Canada';
  static const String air132 = 'Canada';
  static const String air133 = 'New Zealand';
  static const String air134 = 'USA';
  static const String air135 = 'Sweden';
  static const String air136 = 'Norway';
  static const String air137 = 'Denmark';
  static const String air138 = 'Air pollution rate';
  static const String air139 = 'All countries';
  static const String air140 = 'Most polluted';
  static const String air141 = 'Best quality';
  static const String air142 = 'Unknown';
  static const String air143 = 'Failed to fetch air pollution data. Error code:';
  static const String air144 = 'City not found. Please check the name.';
  static const String air145 = 'Failed to fetch geography data. Error code:';
  static const String air146 = 'An error occurred:';
  static const String air147 = 'Air Quality Monitoring';
  static const String air148 = 'Enter city name';
  static const String air149 = 'In continent';
  static const String air150 = 'Located in';
  static const String air151 = 'Air Quality Index (AQI): ';
  static const String air152 = 'Components';
  static const String air153 = 'Good: Air is clean and suitable for most people.';
  static const String air154 = 'Moderate: Some people may feel slight sensitivity.';
  static const String air155 = 'Unhealthy for Sensitive Groups: May affect people with respiratory diseases or sensitivities.';
  static const String air156 = 'Unhealthy: Affects everyone, especially sensitive individuals.';
  static const String air157 = 'Very Unhealthy: Poses a significant risk to public health.';
  static const String air158 = 'Insufficient information.';
  static const String air159 = 'Failed to fetch data for some cities';
  static const String air160 = 'Pollutants and their concentrations based on the Air Quality Index:';
  static const String air161 = 'How do pollutants affect our health?';
  static const String air162 = 'Table explanation:';
  static const String air163 = 'Air quality table based on concentrations: ';
  static const String air164 = 'Low';
  static const String air165 = 'Moderate';
  static const String air166 = 'High';
  static const String air167 = 'Very High';
  static const String air168 = 'Air pollutants such as PM2.5, PM10, NO2, SO2 can cause various health problems, such as difficulty breathing, allergies, and heart diseases. The danger increases when people are exposed to higher concentrations of these pollutants. For example, high concentrations of PM2.5 can lead to deteriorated lung function and increased risk of lung cancer. High ozone (O3) concentrations cause respiratory irritation and increase the chances of respiratory diseases like asthma. Here are detailed explanations of each pollutant and its effects on health: \n\n1. **SO2 (Sulfur Dioxide):** This pollutant causes irritation in the eyes, nose, and throat and can exacerbate respiratory diseases such as bronchitis and asthma. Long-term exposure can lead to chronic heart diseases and lung function disorders. High concentrations of SO2 are extremely dangerous for individuals with chronic respiratory diseases.\n\n2. **NO2 (Nitrogen Oxide):** This pollutant causes irritation in the lungs and can worsen breathing problems such as asthma and bronchitis. Long-term exposure to NO2 increases the risk of heart diseases and strokes, and also increases the body\'s susceptibility to lung infections.\n\n3. **PM2.5 (Fine Particles):** Particles with a size of 2.5 microns or less can enter deep into the respiratory tract and reach the lungs. These particles cause severe health problems including increased asthma cases, chronic bronchitis, deteriorated lung function, and increased risk of lung cancer and heart diseases.\n\n4. **PM10 (Larger Particles):** These particles are larger than PM2.5 but can still cause similar health problems, especially in people with asthma or heart diseases.\n\n5. **O3 (Ozone):** Ozone can cause irritation in the respiratory system, leading to shortness of breath and bronchitis. It also increases the risk of chronic respiratory diseases like asthma. Continuous exposure to high ozone levels can also reduce the lungs\' ability to absorb oxygen.\n\nWe must be cautious of air pollution, especially in busy urban areas where pollution levels are higher. It is important to use air pollution measurement devices indoors, and avoid polluted areas during peak times. Environmental awareness and monitoring air quality contribute to improving public health and protecting the environment.';
  static const String air169 = 'The previous table displays the concentrations of various pollutants in the air based on the Air Quality Index, classifying pollution levels from low to very high. Pollutant concentrations such as SO2, NO2, PM2.5, PM10, and O3 are displayed at different quality levels: \n\n1. **First Column (SO2):** Represents the concentration of sulfur dioxide in the air in micrograms per cubic meter. It is considered high when values exceed 1065.\n\n2. **Second Column (NO2):** Represents the concentration of nitrogen oxide in the air. It is considered moderate when it ranges between 89-177 micrograms per cubic meter.\n\n3. **Third Column (PM2.5):** Represents the concentration of fine particles (less than 2.5 microns). Pollution is severe when the concentration exceeds 71 micrograms per cubic meter.\n\n4. **Fourth Column (PM10):** Shows the concentration of particles larger than 2.5 microns and less than 10 microns in the air. High pollution levels are indicated by concentrations exceeding 101 micrograms per cubic meter.\n\n5. **Fifth Column (O3):** Represents the concentration of ozone in the air. High values of this pollutant cause respiratory health issues, especially for individuals with asthma.\n\nThese indicators reflect the importance of taking preventive measures when pollution levels are high and emphasize paying attention to environmental indicators for living in a healthier environment.';
  static const String air170 = 'companion';
  static const String air171 = 'You';


  static const String air200 = 'Placeholder text for air200';
  static const String quickReply1 = "How can we all contribute to environmental conservation?";
  static const String quickReply2 = "What is the importance of reducing plastic use in protecting oceans?";
  static const String quickReply3 = "How does recycling help reduce waste and stimulate the circular economy?";
  static const String quickReply4 = "What is the role of tree planting in absorbing carbon dioxide?";
  static const String quickReply5 = "How does the use of renewable energy sources reduce harmful emissions?";
  static const String quickReply6 = "Why is water conservation important for preserving natural resources?";
  static const String quickReply7 = "How does environmental awareness promote sustainable behaviors?";
  static const String quickReply8 = "What is the benefit of public transportation in reducing air pollution?";
  static const String quickReply9 = "Why is reducing electricity consumption a contribution to environmental protection?";
  static const String quickReply10 = "What is the importance of proper disposal of electronic waste?";
  static const String quickReply11 = "How does the use of reusable materials reduce waste?";
  static const String quickReply12 = "Why is maintaining biodiversity important to ensure ecosystem sustainability?";
  static const String quickReply13 = "How can reducing carbon emissions contribute to combating climate change?";
  static const String quickReply14 = "What is the impact of urban afforestation on air quality?";
  static const String quickReply15 = "How does organic farming preserve soil and water?";
  static const String quickReply16 = "Why should the use of chemicals be reduced to protect living organisms?";
  static const String quickReply17 = "What is the role of encouraging walking and cycling in reducing pollution?";
  static const String quickReply18 = "How does wildlife conservation contribute to ecosystem balance?";
  static const String quickReply19 = "What is the relationship between reducing meat consumption and the carbon footprint?";
  static const String quickReply20 = "How can solar energy be a clean alternative to energy?";
  static const String quickReply21 = "Why is preserving green spaces important for improving quality of life?";
  static const String quickReply22 = "What is the impact of reducing plastic bag use on protecting marine life?";
  static const String quickReply23 = "How does effective waste management protect the environment and public health?";
  static const String quickReply24 = "What is the benefit of encouraging reuse in reducing waste?";
  static const String quickReply25 = "Why is preserving rivers and lakes essential for protecting water resources?";
  static const String quickReply26 = "How does clean technology promote sustainable development?";
  static const String quickReply27 = "Why is reducing paper use important for forest conservation?";
  static const String quickReply28 = "How does raising environmental awareness enhance community participation?";
  static const String quickReply29 = "Why is encouraging green innovation important for providing effective environmental solutions?";
  static const String quickReply30 = "How does maintaining clean air contribute to improving public health?";
  static const String quickReply31 = "Why is reducing noise important in creating a quiet and healthy environment?";
  static const String quickReply32 = "How do environmental materials protect nature and reduce pollution?";
  static const String quickReply33 = "Why should natural resources be preserved to ensure the future of coming generations?";
  static const String quickReply34 = "What is the importance of promoting eco-tourism in preserving natural sites?";
  static const String quickReply35 = "How does reducing fossil fuel consumption protect the environment?";
  static const String quickReply36 = "What is the role of maintaining soil quality in ensuring sustainable crop production?";
  static const String quickReply37 = "How do electric cars reduce emissions?";
  static const String quickReply38 = "Why is preserving coral reefs important for marine biodiversity?";
  static const String quickReply39 = "Why is reducing pesticide use beneficial for the health of living organisms?";
  static const String quickReply40 = "What is the impact of encouraging sustainable agricultural practices on the environment?";
  static const String quickReply41 = "How does clean air contribute to improving public health?";
  static const String quickReply42 = "What is the benefit of reducing energy consumption in enhancing resource efficiency?";
  static const String quickReply43 = "How does clean energy protect the environment?";
  static const String quickReply44 = "Why is preserving marine life essential for ecosystem balance?";
  static const String quickReply45 = "What is the importance of reducing plastic use in protecting marine organisms?";
  static const String quickReply46 = "How does recycling contribute to preserving natural resources?";
  static const String quickReply47 = "Why is environmental conservation important for improving the quality of life for everyone?";
  static const String quickReply48 = "How can reducing emissions contribute to combating global warming?";
  static const String quickReply49 = "Why is promoting sustainability essential for preserving resources for future generations?";


// تحديث خريطة EN لتشمل جميع الثوابت
  static const Map<String, dynamic> EN = {
    airs40: "Excellent",

    airs36: "Water Quality Index:",

    airs1: "Please enter the name of a location or country to search",
    airs37: "Descriptive grade:",
    airs38: "No water quality data to display.",
    air1: 'Loading...',
    air2: 'Loading site...',
    air3: 'Sweden',
    air4: 'Finland',
    air5: 'New Zealand',
    air6: 'India',
    air7: 'China',
    air8: 'Pakistan',
    air9: 'Copenhagen',
    air10: 'Helsinki',
    air11: 'Oslo',
    air12: 'Delhi',
    air13: 'Beijing',
    air14: 'Kaol Walmor',
    air15: 'Air quality data not found.',
    air16: 'An error occurred while fetching data.',
    air17: 'Internet connection error.',
    air18: 'Location services are disabled.',
    air19: 'Location permission denied.',
    air20: 'Location permission permanently denied.',
    air21: 'Your current location',
    air23: 'An error occurred while fetching air quality data.',
    air24: 'Internet connection error or obtaining location.:',
    air25: 'Location:',
    air26: 'Location not found.',
    air28: 'Good',
    air29: 'Acceptable',
    air30: 'Moderate',
    air31: 'Poor',
    air32: 'Very Poor',
    air33: 'Unknown',
    air34: 'Air Quality Index',
    air35: 'Enter city name',
    air36: 'Air Quality Index:',
    air37: 'Tips for dealing with current air quality',
    air38: 'Pollutants and their concentrations',
    air39: 'Best and worst countries',
    air40: 'Map',
    air41: 'About the app',
    air42: 'Learn more',
    air43: 'Low',
    air45: 'High',
    air46: 'Unable to open link',
    air48: 'App description',
    air49: 'This app helps users monitor real-time air quality based on live API data. The app allows users to know the air quality status at their current locations or manually.\n\nThe app provides data on pollutants such as PM2.5 and PM10 and CO, and also allows users to get tips on how to protect themselves from air pollution.',
    air50: 'Developer contact information',
    air51: 'Email:',
    air52: 'Data source:',
    air53: 'Why did you design this app?',
    air54: 'This app was designed to help individuals improve their awareness of the air quality around them and protect their health and that of their loved ones. '
        + 'Since air pollution poses an increasing threat to public health, the app aims to provide accurate and updated information about air quality '
        + 'in an easy and simplified manner.',
    air55: '- Enable users to know the air quality status in their area moment by moment.\n'
        + '- Provide practical tips to maintain their health when facing high pollution levels.\n'
        + '- Contribute to enhancing environmental awareness and encouraging healthy behaviors.',
    air56: 'Icon message',
    air57: 'We strive to make the world a healthier place by facilitating access to air quality information and supporting individuals in making informed decisions to protect their health and that of their communities.',
    air58: 'Explanation of the bird icon',
    air59: 'The bird icon was carefully chosen to convey the app\'s core message. The bird symbolizes:\n\n'
        + '1. Purity and clean air:\n'
        + 'Birds are usually a symbol of a clean and healthy environment, as they do not live in polluted areas. The icon represents hope for a better environment and clean air.\n\n'
        + '2. Freedom and proper breathing:\n'
        + 'The bird\'s free flight symbolizes breathing freely without worrying about air pollution.\n\n'
        + '3. Connection to nature:\n'
        + 'The bird gently reminds us of nature and our need to preserve it through awareness of air quality and supporting environmental efforts.',
    air60: 'The icon is not just a design; it is a call to users to care about the air quality around them, protect themselves and nature, and achieve a better balance between humans and the environment.',
    air61: 'Location services are disabled',
    air62: 'Please enable location services to access the app\'s features.',
    air63: 'OK',
    air64: 'Location permissions denied',
    air65: 'Please allow permissions to access your location.',
    air66: 'Retry',
    air67: 'Location permissions permanently denied',
    air68: 'Please enable permissions from the app settings to access your location.',
    air69: 'Open settings',
    air70: 'Failed to fetch air quality data. Please try again later.',
    air71: 'An error occurred while fetching data. Please check your internet connection and try again.',
    air72: 'Error',
    air76: 'Unhealthy',
    air77: 'Very Unhealthy',
    air78: 'Hazardous',
    air81: 'Air Quality Level',
    air82: 'Air Quality',
    air83: 'Air pollution has become a critical issue directly affecting our health and environment. Air pollution results from many human activities such as industrial vehicles, emissions from factories and vehicles. It can lead to respiratory diseases and heart diseases, in addition to its impact on the environment in general.',
    air84: 'Tips for dealing with air quality:',
    air85: 'Additional tips:',
    air86: 'In the end, paying attention to air quality and protecting your health is essential. Everyone can play a role in reducing pollution and maintaining a healthy environment for all. If we all work together, we can improve air quality and ensure a better life for future generations.',
    air94: '1. Make sure to know the daily Air Quality Index in your area and follow local instructions regarding outdoor activities.',
    air95: '2. When air quality is poor, try to stay indoors as much as possible and avoid crowded places.',
    air96: '3. If you suffer from respiratory diseases, consult your doctor on how to protect yourself from the effects of pollution.',
    air97: '4. Engage with the local community and participate in efforts to reduce pollution.',
    air98: 'New Delhi',
    air99: 'Lahore',
    air100: 'Dhaka',
    air101: 'Karachi',
    air103: 'Ulaanbaatar',
    air104: 'Cairo',
    air105: 'Jakarta',
    air106: 'Baghdad',
    air107: 'Mumbai',
    air110: 'Bangladesh',
    air113: 'Mongolia',
    air114: 'Egypt',
    air115: 'Indonesia',
    air116: 'Iraq',
    air118: 'Reykjavik',
    air119: 'Zurich',
    air121: 'Vancouver',
    air122: 'Calgary',
    air123: 'Wellington',
    air124: 'Portland',
    air125: 'Stockholm',
    air128: 'Iceland',
    air129: 'Switzerland',
    air131: 'Canada',
    air134: 'USA',
    air136: 'Norway',
    air137: 'Denmark',
    air138: 'Air pollution rate',
    air139: 'All countries',
    air140: 'Most polluted',
    air141: 'Best quality',
    air143: 'Failed to fetch air pollution data. Error code:',
    air144: 'City not found. Please check the name.',
    air145: 'Failed to fetch geography data. Error code:',
    air146: 'An error occurred:',
    air147: 'Air Quality Monitoring',
    air149: 'In continent',
    air150: 'Located in',
    air151: 'Air Quality Index (AQI): ',
    air152: 'Components',
    air153: 'Good: Air is clean and suitable for most people.',
    air154: 'Moderate: Some people may feel slight sensitivity.',
    air155: 'Unhealthy for Sensitive Groups: May affect people with respiratory diseases or sensitivities.',
    air156: 'Unhealthy: Affects everyone, especially sensitive individuals.',
    air157: 'Very Unhealthy: Poses a significant risk to public health.',
    air158: 'Insufficient information.',
    air159: 'Failed to fetch data for some cities',
    air160: 'Pollutants and their concentrations based on the Air Quality Index:',
    air161: 'How do pollutants affect our health?',
    air162: 'Table explanation:',
    air163: 'Air quality table based on concentrations: ',
    air167: 'Very High',
    air168: 'Air pollutants such as PM2.5, PM10, NO2, SO2 can cause various health problems, such as difficulty breathing, allergies, and heart diseases. '
        + 'The danger increases when people are exposed to higher concentrations of these pollutants. For example, high concentrations of PM2.5 can lead to deteriorated lung function and increased risk of lung cancer. '
        + 'High ozone (O3) concentrations cause respiratory irritation and increase the chances of respiratory diseases like asthma. '
        + 'Here are detailed explanations of each pollutant and its effects on health: \n\n'
        + '1. **SO2 (Sulfur Dioxide):** This pollutant causes irritation in the eyes, nose, and throat and can exacerbate respiratory diseases such as bronchitis and asthma. '
        + 'Long-term exposure can lead to chronic heart diseases and lung function disorders. High concentrations of SO2 are extremely dangerous for individuals with chronic respiratory diseases.\n\n'
        + '2. **NO2 (Nitrogen Oxide):** This pollutant causes irritation in the lungs and can worsen breathing problems such as asthma and bronchitis. '
        + 'Long-term exposure to NO2 increases the risk of heart diseases and strokes, and also increases the body\'s susceptibility to lung infections.\n\n'
        + '3. **PM2.5 (Fine Particles):** Particles with a size of 2.5 microns or less can enter deep into the respiratory tract and reach the lungs. '
        + 'These particles cause severe health problems including increased asthma cases, chronic bronchitis, deteriorated lung function, and increased risk of lung cancer and heart diseases.\n\n'
        + '4. **PM10 (Larger Particles):** These particles are larger than PM2.5 but can still cause similar health problems, especially in people with asthma or heart diseases.\n\n'
        + '5. **O3 (Ozone):** Ozone can cause irritation in the respiratory system, leading to shortness of breath and bronchitis. It also increases the risk of chronic respiratory diseases like asthma. '
        + 'Continuous exposure to high ozone levels can also reduce the lungs\' ability to absorb oxygen.\n\n'
        + 'We must be cautious of air pollution, especially in busy urban areas where pollution levels are higher. It is important to use air pollution measurement devices indoors, and avoid polluted areas during peak times. '
        + 'Environmental awareness and monitoring air quality contribute to improving public health and protecting the environment.',
    air169: 'The previous table displays the concentrations of various pollutants in the air based on the Air Quality Index, classifying pollution levels from low to very high. '
        + 'Pollutant concentrations such as SO2, NO2, PM2.5, PM10, and O3 are displayed at different quality levels: \n\n'
        + '1. **First Column (SO2):** Represents the concentration of sulfur dioxide in the air in micrograms per cubic meter. It is considered high when values exceed 1065.\n\n'
        + '2. **Second Column (NO2):** Represents the concentration of nitrogen oxide in the air. It is considered moderate when it ranges between 89-177 micrograms per cubic meter.\n\n'
        + '3. **Third Column (PM2.5):** Represents the concentration of fine particles (less than 2.5 microns). Pollution is severe when the concentration exceeds 71 micrograms per cubic meter.\n\n'
        + '4. **Fourth Column (PM10):** Shows the concentration of particles larger than 2.5 microns and less than 10 microns in the air. High pollution levels are indicated by concentrations exceeding 101 micrograms per cubic meter.\n\n'
        + '5. **Fifth Column (O3):** Represents the concentration of ozone in the air. High values of this pollutant cause respiratory health issues, especially for individuals with asthma.\n\n'
        + 'These indicators reflect the importance of taking preventive measures when pollution levels are high and emphasize paying attention to environmental indicators for living in a healthier environment.',


    air170: 'companion',
    air171: 'You',

    air200: 'Pure Breath, welcome to the app',
    quickReply1: "How can we all contribute to environmental conservation?",
    quickReply2: "What is the importance of reducing plastic use in protecting oceans?",
    quickReply3: "How does recycling help reduce waste and stimulate the circular economy?",
    quickReply4: "What is the role of tree planting in absorbing carbon dioxide?",
    quickReply5: "How does the use of renewable energy sources reduce harmful emissions?",
    quickReply6: "Why is water conservation important for preserving natural resources?",
    quickReply7: "How does environmental awareness promote sustainable behaviors?",
    quickReply8: "What is the benefit of public transportation in reducing air pollution?",
    quickReply9: "Why is reducing electricity consumption a contribution to environmental protection?",
    quickReply10: "What is the importance of proper disposal of electronic waste?",
    quickReply11: "How does the use of reusable materials reduce waste?",
    quickReply12: "Why is maintaining biodiversity important to ensure ecosystem sustainability?",
    quickReply13: "How can reducing carbon emissions contribute to combating climate change?",
    quickReply14: "What is the impact of urban afforestation on air quality?",
    quickReply15: "How does organic farming preserve soil and water?",
    quickReply16: "Why should the use of chemicals be reduced to protect living organisms?",
    quickReply17: "What is the role of encouraging walking and cycling in reducing pollution?",
    quickReply18: "How does wildlife conservation contribute to ecosystem balance?",
    quickReply19: "What is the relationship between reducing meat consumption and the carbon footprint?",
    quickReply20: "How can solar energy be a clean alternative to energy?",
    quickReply21: "Why is preserving green spaces important for improving quality of life?",
    quickReply22: "What is the impact of reducing plastic bag use on protecting marine life?",
    quickReply23: "How does effective waste management protect the environment and public health?",
    quickReply24: "What is the benefit of encouraging reuse in reducing waste?",
    quickReply25: "Why is preserving rivers and lakes essential for protecting water resources?",
    quickReply26: "How does clean technology promote sustainable development?",
    quickReply27: "Why is reducing paper use important for forest conservation?",
    quickReply28: "How does raising environmental awareness enhance community participation?",
    quickReply29: "Why is encouraging green innovation important for providing effective environmental solutions?",
    quickReply30: "How does maintaining clean air contribute to improving public health?",
    quickReply31: "Why is reducing noise important in creating a quiet and healthy environment?",
    quickReply32: "How do environmental materials protect nature and reduce pollution?",
    quickReply33: "Why should natural resources be preserved to ensure the future of coming generations?",
    quickReply34: "What is the importance of promoting eco-tourism in preserving natural sites?",
    quickReply35: "How does reducing fossil fuel consumption protect the environment?",
    quickReply36: "What is the role of maintaining soil quality in ensuring sustainable crop production?",
    quickReply37: "How do electric cars reduce emissions?",
    quickReply38: "Why is preserving coral reefs important for marine biodiversity?",
    quickReply39: "Why is reducing pesticide use beneficial for the health of living organisms?",
    quickReply40: "What is the impact of encouraging sustainable agricultural practices on the environment?",
    quickReply41: "How does clean air contribute to improving public health?",
    quickReply42: "What is the benefit of reducing energy consumption in enhancing resource efficiency?",
    quickReply43: "How does clean energy protect the environment?",
    quickReply44: "Why is preserving marine life essential for ecosystem balance?",
    quickReply45: "What is the importance of reducing plastic use in protecting marine organisms?",
    quickReply46: "How does recycling contribute to preserving natural resources?",
    quickReply47: "Why is environmental conservation important for improving the quality of life for everyone?",
    quickReply48: "How can reducing emissions contribute to combating global warming?",
    quickReply49: "Why is promoting sustainability essential for preserving resources for future generations?",

  };
  static const Map<String, dynamic> AR = {
    airs36: 'مؤشر جودة الماء:',
    airs1: 'يرجى إدخال اسم موقع أو دولة للبحث',
    airs37: 'الدرجة الوصفية:',
    airs40: 'ممتاز',
    airs38: 'لا توجد بيانات جودة المياه لعرضها.',
    air1: 'جاري التحميل...',
    air2: 'تحميل الموقع...',
    air3: 'السويد',
    air4: 'فنلندا',
    air5: 'نيوزيلندا',
    air6: 'الهند',
    air7: 'الصين',
    air8: 'باكستان',
    air9: 'كوبنهاغن',
    air10: 'هلسنكي',
    air11: 'أوسلو',
    air12: 'دلهي',
    air13: 'بكين',
    air14: 'كاول بالمور',
    air15: 'لم يتم العثور على بيانات جودة الهواء.',
    air16: 'حدث خطأ أثناء جلب البيانات.',
    air17: 'خطأ في الاتصال بالإنترنت.',
    air18: 'خدمات الموقع غير مفعلة.',
    air19: 'تم رفض إذن الموقع.',
    air20: 'تم رفض إذن الموقع بشكل دائم.',
    air21: 'موقعك الحالي',
    air23: 'حدث خطأ أثناء جلب بيانات جودة الهواء.',
    air24: 'خطأ في الاتصال بالإنترنت أو الحصول على الموقع.:',
    air25: 'موقع:',
    air26: 'لم يتم العثور على الموقع.',
    air28: 'جيد',
    air29: 'مقبول',
    air30: 'متوسط',
    air31: 'ضعيف',
    air32: 'ضعيف جدًا',
    air33: 'غير معروف',
    air34: 'مؤشر جودة الهواء',
    air35: 'أدخل اسم المدينة',
    air36: 'مؤشر جودة الهواء:',

    air37: '''نصائح للتعامل
  مع جودة الهواء الحالية''',
    air38: 'الملوثات وتركيزاتها',
    air39: 'الدول الافضل والاسوء',
    air40: 'خريطة',
    air41: 'حول التطبيق',
    air42: 'تعلم المزيد',
    air43: 'قليل',
    air45: 'عالي',
    air46: 'تعذر فتح الرابط',
    air48: 'وصف التطبيق',
    air49: 'هذا التطبيق يساعد المستخدمين على مراقبة جودة الهواء في الوقت الفعلي بناءً على بيانات حية من واجهات برمجة التطبيقات. يتيح التطبيق للمستخدمين معرفة حالة جودة الهواء في مواقعهم الحالية أو يدويًا.\n\nيوفر التطبيق بيانات حول الملوثات مثل PM2.5 و PM10 و CO، وكذلك يتيح للمستخدمين الحصول على نصائح حول كيفية الحماية من تلوث الهواء.',
    air50: 'بيانات الاتصال بالمطور',
    air51: 'البريد الإلكتروني:',
    air52: 'مصدر البيانات:',
    air53: 'لماذا قمت بتصميم هذا التطبيق؟',
    air54: 'تم تصميم هذا التطبيق لمساعدة الأفراد على تحسين وعيهم بجودة الهواء المحيط بهم وحماية صحتهم وصحة أحبائهم. '
  'نظرًا لأن تلوث الهواء يمثل خطرًا متزايدًا على الصحة العامة، يهدف التطبيق إلى تقديم معلومات دقيقة ومحدثة عن جودة الهواء '
  'بطريقة سهلة ومبسطة.',
    air55: '- تمكين المستخدمين من معرفة حالة جودة الهواء في منطقتهم لحظة بلحظة.\n'
  '- تقديم نصائح عملية للحفاظ على صحتهم عند مواجهة مستويات عالية من التلوث.\n'
  '- المساهمة في تعزيز الوعي البيئي وتشجيع السلوكيات الصحية.',
    air56: 'رسالة الأيقونة',
    air57:    'نسعى لجعل العالم مكانًا أكثر صحة عبر تسهيل الوصول إلى معلومات جودة الهواء ودعم الأفراد لاتخاذ قرارات مستنيرة لحماية صحتهم وصحة مجتمعاتهم.',

    air58: 'شرح أيقونة العصفورة',
    air59:  'أيقونة العصفورة تم اختيارها بعناية لتعبر عن الرسالة الأساسية للتطبيق. العصفورة ترمز إلى:\n\n'
  '1. النقاء والهواء النظيف:\n'
  'العصافير عادة ما تكون رمزًا للبيئة النظيفة والصحية، حيث لا تعيش في الأماكن الملوثة. تمثل الأيقونة الأمل في بيئة أفضل وهواء نقي.\n\n'
  '2. الحرية والتنفس السليم:\n'
  'الطيران الحر للعصافير يرمز إلى التنفس بحرية دون قلق من تلوث الهواء.\n\n'
  '3. الارتباط بالطبيعة:\n'
  'العصفورة تذكير بلطف الطبيعة وحاجتنا للحفاظ عليها من خلال الوعي بجودة الهواء ودعم الجهود البيئية.',

  air60: 'الأيقونة ليست مجرد تصميم؛ إنها دعوة للمستخدمين للاهتمام بجودة الهواء من حولهم، لحماية أنفسهم وحماية الطبيعة، ولتحقيق توازن أفضل بين الإنسان والبيئة.',

  air61: 'خدمات الموقع معطلة',
    air62: 'يرجى تفعيل خدمات الموقع للوصول إلى ميزات التطبيق.',
    air63: 'حسناً',
    air64: 'أذونات الموقع مرفوضة',
    air65: 'يرجى السماح للأذونات للوصول إلى موقعك.',
    air66: 'إعادة المحاولة',
    air67: 'أذونات الموقع مرفوضة بشكل دائم',
    air68: 'يرجى تمكين الأذونات من إعدادات التطبيق للوصول إلى موقعك.',
    air69: 'افتح الإعدادات',
    air70: 'فشل في جلب بيانات جودة الهواء. حاول مرة أخرى لاحقًا.',
    air71: 'حدث خطأ أثناء جلب البيانات. تحقق من اتصالك بالإنترنت وحاول مرة أخرى.',
    air72: 'خطأ',
    air76: 'غير صحي',
    air77: 'غير صحي جدًا',
    air78: 'خطير',
    air81: 'مستوى جودة الهواء',
    air82: 'جودة الهواء',
    air83:  'التلوث الهوائي أصبح مشكلة حيوية تؤثر بشكل مباشر على صحتنا وبيئتنا. التلوث الهوائي ينتج عن العديد من الأنشطة البشرية مثل المركبات الصناعية والانبعاثات من المصانع والمركبات. يمكن أن يؤدي إلى أمراض تنفسية وأمراض قلبية، بالإضافة إلى تأثيره على البيئة بشكل عام.',
    air84: 'نصائح للتعامل مع جودة الهواء:',
    air85: 'نصائح إضافية:',
    air86: 'في النهاية، الاهتمام بجودة الهواء وحماية صحتك يعد أمرًا ضروريًا. يمكن للجميع أن يلعبوا دورًا في تقليل التلوث والحفاظ على بيئة صحية للجميع. إذا عملنا جميعًا معًا، يمكننا تحسين جودة الهواء وضمان حياة أفضل للأجيال القادمة.',

 air94: '1. احرص على معرفة مؤشر جودة الهواء اليومي في منطقتك واتبع التعليمات المحلية بشأن الأنشطة الخارجية.',
    air95: '2. عندما تكون جودة الهواء سيئة، حاول أن تظل في الأماكن المغلقة قدر الإمكان وابتعد عن الأماكن المزدحمة.',
    air96: '3. إذا كنت تعاني من أمراض تنفسية، استشر طبيبك بشأن كيفية حماية نفسك من تأثيرات التلوث.',
    air97: '4. تفاعل مع المجتمع المحلي وشارك في الجهود لتقليل التلوث.',
  air98: 'نيودلهي',
  air99: 'لاهور',
  air100: 'دكا',
  air101: 'كاراشي',
  air103: 'أولان باتر',
  air104: 'القاهرة',
  air105: 'جاكرتا',
  air106: 'بغداد',
  air107: 'مومباي',
  air110: 'بنغلاديش',
  air113: 'منغوليا',
  air114: 'مصر',
  air115: 'إندونيسيا',
  air116: 'العراق',
  air118: 'ريكيافيك',
  air119: 'زيورخ',
  air121: 'فانكوفر',
  air122: 'كالغاري',
  air123: 'ويلينغتون',
  air124: 'بورتلاند',
  air125: 'ستوكهولم',
  air128: 'آيسلندا',
  air129: 'سويسرا',
  air131: 'كندا',
  air134: 'الولايات المتحدة',
  air136: 'النرويج',
  air137: 'الدنمارك',

    air138: 'معدل تلوث الهواء',
    air139: 'جميع الدول',
    air140: 'الأكثر تلوثًا',
    air141: 'الأفضل جودة',
    air143: 'فشل في جلب بيانات تلوث الهواء. رمز الخطأ:',
    air144: 'لم يتم العثور على المدينة. يرجى التحقق من الاسم.',
    air145: 'فشل في جلب بيانات الجغرافيا. رمز الخطأ:',
    air146: 'حدث خطأ:',
    air147: 'مراقبة جودة الهواء',
    air149: 'في قارة',
    air150: 'تقع',
    air151: 'مؤشر جودة الهواء (AQI): ',
    air152: 'المكونات',
    air153: 'جيد: الهواء نظيف ومناسب لمعظم الناس.',
    air154: 'معتدل: قد يشعر بعض الأشخاص بحساسية قليلة.',
    air155: 'غير صحي للحساسين: قد تؤثر على الأشخاص الذين يعانون من أمراض تنفسية أو حساسية.',
    air156: 'غير صحي: يؤثر على الجميع، خاصة الأشخاص الحساسين.',
    air157: 'سيء جداً: يشكل خطراً كبيراً على الصحة العامة.',
    air158: 'لا توجد معلومات كافية.',
    air159: 'فشل في جلب بيانات لبعض المدن',
    air160: 'الملوثات وتركيزاتها حسب مؤشر جودة الهواء:',
    air161: 'كيف تؤثر الملوثات على صحتنا؟',
    air162: 'شرح الجدول:',
    air163: 'جدول جودة الهواء بناءً على التركيزات: ',
    air167: 'مرتفع جدًا',
    air168: 'الملوثات الهوائية مثل PM2.5 وPM10 وNO2 وSO2 يمكن أن تتسبب في مشاكل صحية مختلفة، مثل صعوبة التنفس، الحساسية، وأمراض القلب. '
  'تزداد الخطورة عند تعرض الأشخاص لأعلى تركيزات من هذه الملوثات. على سبيل المثال، التركيزات العالية من PM2.5 يمكن أن تؤدي إلى تدهور وظيفة الرئة وزيادة خطر الإصابة بسرطان الرئة. '
  'أما تركيزات الأوزون العالية (O3)، فتسبب تهيجًا في الجهاز التنفسي وتزيد من فرص الإصابة بأمراض التنفس مثل الربو. '
  'اليك تفاصيل موسعة حول كل ملوث وتأثيراته على الصحة: \n\n'
  '1. **SO2 (ثاني أكسيد الكبريت):** هذا الملوث يسبب تهيجًا في العينين والأنف والحنجرة ويمكن أن يزيد من حدة أمراض الجهاز التنفسي مثل التهاب الشعب الهوائية والربو. '
  'التعرض الطويل له قد يؤدي إلى أمراض قلبية مزمنة واضطرابات في وظائف الرئة. التراكيز العالية من SO2 تعتبر خطيرة للغاية للأشخاص المصابين بأمراض تنفسية مزمنة.\n\n'
  '2. **NO2 (أكسيد النيتروجين):** هذا الملوث يسبب تهيجًا في الرئتين ويمكن أن يؤدي إلى تفاقم مشاكل التنفس مثل الربو والتهاب الشعب الهوائية. '
  'التعرض طويل الأمد لـ NO2 يزيد من خطر الإصابة بأمراض القلب والسكتات الدماغية، وكذلك يزيد من قابلية الجسم للإصابة بالعدوى الرئوية.\n\n'
  '3. **PM2.5 (الجسيمات الدقيقة):** الجسيمات التي يبلغ حجمها 2.5 ميكرون أو أقل قادرة على دخول المسالك التنفسية العميقة والوصول إلى الرئتين. '
  'تسبب هذه الجسيمات مشاكل صحية خطيرة بما في ذلك زيادة حالات الإصابة بالربو، التهاب الشعب الهوائية المزمن، تدهور وظائف الرئة، وزيادة خطر الإصابة بسرطان الرئة وأمراض القلب.\n\n'
  '4. **PM10 (الجسيمات الأكبر):** هذه الجسيمات أكبر من PM2.5 ولكنها لا تزال قادرة على التسبب في مشاكل صحية مشابهة، خصوصًا في الأشخاص الذين يعانون من الربو أو أمراض القلب.\n\n'
  '5. **O3 (الأوزون):** الأوزون يمكن أن يسبب تهيجًا في الجهاز التنفسي ويؤدي إلى ضيق التنفس والتهاب الشعب الهوائية. كما يزيد من خطر الإصابة بأمراض تنفسية مزمنة مثل الربو. '
  'التعرض المستمر لتركيزات عالية من الأوزون يمكن أن يسبب أيضًا تقليل قدرة الرئة على امتصاص الأوكسجين.\n\n'
  'يجب أن نكون حذرين من التلوث الهوائي، خصوصًا في المناطق الحضرية المزدحمة، حيث تكون مستويات التلوث أعلى. من المهم استخدام أجهزة قياس التلوث الهوائي داخل المنازل، والابتعاد عن المناطق الملوثة في أوقات الذروة. '
  'يساهم الوعي البيئي ومراقبة جودة الهواء في تحسين الصحة العامة وحماية البيئة.',
    air169: 'الجدول السابق يعرض تركيزات الملوثات المختلفة في الهواء بناءً على مؤشر جودة الهواء، حيث يتم تصنيف التلوث من مستويات منخفضة إلى مرتفعة جدًا. '
  'يتم عرض تركيزات الملوثات مثل SO2 وNO2 وPM2.5 وPM10 وO3 في مختلف مستويات الجودة: \n\n'
  '1. **العمود الأول (SO2):** يمثل تركيز ثاني أكسيد الكبريت في الهواء بوحدات ميكروجرام لكل متر مكعب. يُعتبر تركيزه مرتفعًا عند قيم أعلى من 1065.\n\n'
  '2. **العمود الثاني (NO2):** يمثل تركيز أكسيد النيتروجين في الهواء. يعتبر تركيزه معتدلًا عندما يتراوح بين 89-177 ميكروجرام لكل متر مكعب.\n\n'
  '3. **العمود الثالث (PM2.5):** يمثل تركيز الجسيمات الدقيقة (أقل من 2.5 ميكرون). يكون التلوث شديدًا عندما يتجاوز التركيز 71 ميكروجرام لكل متر مكعب.\n\n'
  '4. **العمود الرابع (PM10):** يعرض تركيز الجسيمات الأكبر من 2.5 ميكرون وأقل من 10 ميكرون في الهواء. مستويات التلوث المرتفعة تظهر في التركيزات التي تتجاوز 101 ميكروجرام لكل متر مكعب.\n\n'
  '5. **العمود الخامس (O3):** يمثل تركيز الأوزون في الهواء. القيم العالية لهذا الملوث تتسبب في مشاكل صحية تنفسية، خصوصًا للأشخاص الذين يعانون من الربو.\n\n'
  'تعكس هذه المؤشرات أهمية اتخاذ التدابير الوقائية عند وجود مستويات عالية من التلوث، وتحث على الانتباه للمؤشرات البيئية للعيش في بيئة صحية أكثر.',
    air170: 'رفيق',
    air171: 'انت',

    air200: 'Pure Breath مرحبا بك في تطبيق ',
    quickReply1: "كيف يمكننا جميعًا المساهمة في الحفاظ على البيئة؟",
    quickReply2: "ما أهمية تقليل استخدام البلاستيك في حماية المحيطات؟",
    quickReply3: "كيف تسهم إعادة التدوير في تقليل النفايات وتحفيز الاقتصاد الدائري؟",
    quickReply4: "ما دور زراعة الأشجار في امتصاص ثاني أكسيد الكربون؟",
    quickReply5: "كيف يقلل استخدام مصادر الطاقة المتجددة من الانبعاثات الضارة؟",
    quickReply6: "لماذا يعتبر توفير المياه مهمًا للحفاظ على الموارد الطبيعية؟",
    quickReply7: "كيف تعزز التوعية البيئية السلوكيات المستدامة؟",
    quickReply8: "ما فائدة النقل العام في تقليل تلوث الهواء؟",
    quickReply9: "لماذا يُعتبر تقليل استهلاك الكهرباء مساهمة في حماية البيئة؟",
    quickReply10: "ما أهمية التخلص السليم من النفايات الإلكترونية؟",
    quickReply11: "كيف يقلل استخدام المواد القابلة لإعادة الاستخدام من النفايات؟",
    quickReply12: "ما أهمية الحفاظ على التنوع البيولوجي لضمان استدامة النظم البيئية؟",
    quickReply13: "كيف يمكن لتقليل انبعاثات الكربون المساهمة في مكافحة تغير المناخ؟",
    quickReply14: "ما تأثير التشجير في المناطق الحضرية على جودة الهواء؟",
    quickReply15: "كيف تحافظ الزراعة العضوية على التربة والمياه؟",
    quickReply16: "لماذا يجب تقليل استخدام المواد الكيميائية لحماية الكائنات الحية؟",
    quickReply17: "ما دور تشجيع المشي وركوب الدراجات في تقليل التلوث؟",
    quickReply18: "كيف يساهم الحفاظ على الحياة البرية في توازن النظم البيئية؟",
    quickReply19: "ما علاقة تقليل استهلاك اللحوم بالبصمة الكربونية؟",
    quickReply20: "كيف يمكن للطاقة الشمسية أن تكون بديلاً نظيفًا للطاقة؟",
    quickReply21: "لماذا يُعتبر الحفاظ على المساحات الخضراء مهمًا لتحسين جودة الحياة؟",
    quickReply22: "ما أثر تقليل استخدام الأكياس البلاستيكية على حماية الكائنات البحرية؟",
    quickReply23: "كيف تسهم إدارة النفايات الفعالة في حماية البيئة والصحة العامة؟",
    quickReply24: "ما فائدة تشجيع إعادة الاستخدام في تقليل النفايات؟",
    quickReply25: "لماذا يعتبر الحفاظ على الأنهار والبحيرات ضروريًا لحماية الموارد المائية؟",
    quickReply26: "كيف تعزز التكنولوجيا النظيفة التنمية المستدامة؟",
    quickReply27: "ما أهمية تقليل استخدام الورق للحفاظ على الغابات؟",
    quickReply28: "كيف تعزز التوعية بأهمية البيئة المشاركة المجتمعية؟",
    quickReply29: "لماذا يُعتبر تشجيع الابتكار الأخضر مهمًا لتقديم حلول بيئية فعالة؟",
    quickReply30: "كيف يساهم الحفاظ على الهواء النظيف في تحسين الصحة العامة؟",
    quickReply31: "ما أهمية تقليل الضوضاء في خلق بيئة هادئة وصحية؟",
    quickReply32: "كيف تحمي المواد البيئية الطبيعة وتقلل التلوث؟",
    quickReply33: "لماذا يجب الحفاظ على الثروات الطبيعية لضمان مستقبل الأجيال القادمة؟",
    quickReply34: "ما أهمية تشجيع السياحة البيئية في الحفاظ على المواقع الطبيعية؟",
    quickReply35: "كيف يساهم تقليل استهلاك الوقود الأحفوري في حماية البيئة؟",
    quickReply36: "ما دور الحفاظ على جودة التربة في ضمان إنتاج محاصيل مستدامة؟",
    quickReply37: "كيف تقلل السيارات الكهربائية من الانبعاثات؟",
    quickReply38: "ما أهمية الحفاظ على الشعاب المرجانية في حماية التنوع البحري؟",
    quickReply39: "لماذا يعتبر تقليل استخدام المبيدات مفيدًا لصحة الكائنات الحية؟",
    quickReply40: "ما تأثير تشجيع الممارسات الزراعية المستدامة على البيئة؟",
    quickReply41: "كيف يساهم الهواء النقي في تحسين الصحة العامة؟",
    quickReply42: "ما فائدة تقليل استهلاك الطاقة في تعزيز كفاءة الموارد؟",
    quickReply43: "كيف تحمي الطاقة النظيفة البيئة؟",
    quickReply44: "لماذا يُعتبر الحفاظ على الحياة البحرية ضروريًا لتوازن النظم البيئية؟",
    quickReply45: "ما أهمية تقليل استخدام البلاستيك في حماية الكائنات البحرية؟",
    quickReply46: "كيف تسهم إعادة التدوير في الحفاظ على الموارد الطبيعية؟",
    quickReply47: "ما أهمية الحفاظ على البيئة في تحسين جودة الحياة للجميع؟",
    quickReply48: "كيف يمكن لتقليل الانبعاثات المساهمة في مكافحة الاحتباس الحراري؟",
    quickReply49: "لماذا يُعتبر تشجيع الاستدامة ضروريًا للحفاظ على الموارد للأجيال القادمة؟",
  };
  static const Map<String, dynamic> FR = {
    airs40: "Excellent",

    airs36: "Indice de qualité de l'eau :",
    airs1: "Veuillez entrer le nom d'un lieu ou d'un pays pour rechercher",
    airs37: "Niveau descriptif :",
    airs38: "Aucune donnée sur la qualité de l'eau à afficher.",
    air1: 'Chargement...',
    air2: 'Chargement du site...',
    air3: 'Suède',
    air4: 'Finlande',
    air5: 'Nouvelle-Zélande',
    air6: 'Inde',
    air7: 'Chine',
    air8: 'Pakistan',
    air9: 'Copenhague',
    air10: 'Helsinki',
    air11: 'Oslo',
    air12: 'Delhi',
    air13: 'Pékin',
    air14: 'Kaol Walmor',
    air15: 'Données de qualité de l\'air non trouvées.',
    air16: 'Une erreur s\'est produite lors de la récupération des données.',
    air17: 'Erreur de connexion Internet.',
    air18: 'Les services de localisation sont désactivés.',
    air19: 'Permission de localisation refusée.',
    air20: 'Permission de localisation refusée de manière permanente.',
    air21: 'Votre emplacement actuel',
    air23: 'Une erreur s\'est produite lors de la récupération des données de qualité de l\'air.',
    air24: 'Erreur de connexion Internet ou obtention de l\'emplacement.:',
    air25: 'Emplacement:',
    air26: 'Emplacement non trouvé.',
    air28: 'Bon',
    air29: 'Acceptable',
    air30: 'Modéré',
    air31: 'Médiocre',
    air32: 'Très médiocre',
    air33: 'Inconnu',
    air34: 'Indice de qualité de l\'air',
    air35: 'Entrez le nom de la ville',
    air36: 'Indice de qualité de l\'air:',
    air37: '''Conseils pour gérer
la qualité actuelle de l'air''',
    air38: 'Polluants et leurs concentrations',
    air39: 'Meilleurs et pires pays',
    air40: 'Carte',
    air41: 'À propos de l\'application',
    air42: 'En savoir plus',
    air43: 'Faible',
    air45: 'Élevé',
    air46: 'Impossible d\'ouvrir le lien',
    air48: 'Description de l\'application',
    air49: 'Cette application aide les utilisateurs à surveiller la qualité de l\'air en temps réel en se basant sur des données en direct provenant des API. L\'application permet aux utilisateurs de connaître l\'état de la qualité de l\'air à leurs emplacements actuels ou manuellement.\n\nL\'application fournit des données sur les polluants tels que PM2.5, PM10 et CO, et permet également aux utilisateurs d\'obtenir des conseils sur la manière de se protéger de la pollution de l\'air.',
    air50: 'Informations de contact du développeur',
    air51: 'Email:',
    air52: 'Source des données:',
    air53: 'Pourquoi avez-vous conçu cette application?',
    air54: 'Cette application a été conçue pour aider les individus à améliorer leur sensibilisation à la qualité de l\'air qui les entoure et à protéger leur santé et celle de leurs proches. '
        'Étant donné que la pollution de l\'air représente une menace croissante pour la santé publique, l\'application vise à fournir des informations précises et à jour sur la qualité de l\'air '
        'de manière simple et simplifiée.',
    air55: '- Permettre aux utilisateurs de connaître l\'état de la qualité de l\'air dans leur région moment par moment.\n'
        '- Fournir des conseils pratiques pour maintenir leur santé face à des niveaux élevés de pollution.\n'
        '- Contribuer à renforcer la sensibilisation environnementale et encourager des comportements sains.',
    air56: 'Message de l\'icône',
    air57: 'Nous nous efforçons de rendre le monde un endroit plus sain en facilitant l\'accès aux informations sur la qualité de l\'air et en soutenant les individus dans la prise de décisions éclairées pour protéger leur santé et celle de leurs communautés.',
    air58: 'Explication de l\'icône de l\'oiseau',
    air59: 'L\'icône de l\'oiseau a été soigneusement choisie pour transmettre le message principal de l\'application. L\'oiseau symbolise:\n\n'
        '1. Pureté et air propre:\n'
        'Les oiseaux sont généralement un symbole d\'un environnement propre et sain, car ils ne vivent pas dans des zones polluées. L\'icône représente l\'espoir d\'un meilleur environnement et d\'un air pur.\n\n'
        '2. Liberté et respiration adéquate:\n'
        'Le vol libre de l\'oiseau symbolise une respiration libre sans se soucier de la pollution de l\'air.\n\n'
        '3. Connexion à la nature:\n'
        'L\'oiseau rappelle doucement la nature et notre besoin de la préserver grâce à la sensibilisation à la qualité de l\'air et au soutien des efforts environnementaux.',
    air60: 'L\'icône n\'est pas seulement un design; c\'est un appel aux utilisateurs pour qu\'ils se soucient de la qualité de l\'air autour d\'eux, protègent eux-mêmes et la nature, et réalisent un meilleur équilibre entre l\'humain et l\'environnement.',
    air61: 'Les services de localisation sont désactivés',
    air62: 'Veuillez activer les services de localisation pour accéder aux fonctionnalités de l\'application.',
    air63: 'OK',
    air64: 'Permissions de localisation refusées',
    air65: 'Veuillez autoriser les permissions pour accéder à votre emplacement.',
    air66: 'Réessayer',
    air67: 'Permissions de localisation refusées de manière permanente',
    air68: 'Veuillez activer les permissions depuis les paramètres de l\'application pour accéder à votre emplacement.',
    air69: 'Ouvrir les paramètres',
    air70: 'Échec de la récupération des données de qualité de l\'air. Veuillez réessayer plus tard.',
    air71: 'Une erreur s\'est produite lors de la récupération des données. Veuillez vérifier votre connexion Internet et réessayer.',
    air72: 'Erreur',
    air76: 'Insalubre',
    air77: 'Très Insalubre',
    air78: 'Dangereux',
    air81: 'Niveau de qualité de l\'air',
    air82: 'Qualité de l\'air',
    air83: 'La pollution de l\'air est devenue un problème crucial affectant directement notre santé et notre environnement. La pollution de l\'air résulte de nombreuses activités humaines telles que les véhicules industriels, les émissions des usines et des véhicules. Elle peut entraîner des maladies respiratoires et des maladies cardiaques, en plus de son impact général sur l\'environnement.',
    air84: 'Conseils pour gérer la qualité de l\'air:',
    air85: 'Conseils supplémentaires:',
    air86: 'En fin de compte, prêter attention à la qualité de l\'air et protéger votre santé est essentiel. Chacun peut jouer un rôle dans la réduction de la pollution et le maintien d\'un environnement sain pour tous. Si nous travaillons tous ensemble, nous pouvons améliorer la qualité de l\'air et garantir une meilleure vie pour les générations futures.',
    air94: '1. Assurez-vous de connaître l\'Indice de Qualité de l\'Air quotidien dans votre région et suivez les instructions locales concernant les activités en plein air.',
    air95: '2. Lorsque la qualité de l\'air est mauvaise, essayez de rester à l\'intérieur autant que possible et évitez les endroits bondés.',
    air96: '3. Si vous souffrez de maladies respiratoires, consultez votre médecin sur la manière de vous protéger des effets de la pollution.',
    air97: '4. Engagez-vous avec la communauté locale et participez aux efforts pour réduire la pollution.',
    air98: 'New Delhi',
    air99: 'Lahore',
    air100: 'Dacca',
    air101: 'Karachi',
    air103: 'Oulan-Bator',
    air104: 'Le Caire',
    air105: 'Jakarta',
    air106: 'Bagdad',
    air107: 'Mumbai',
    air110: 'Bangladesh',
    air113: 'Mongolie',
    air114: 'Égypte',
    air115: 'Indonésie',
    air116: 'Irak',
    air118: 'Reykjavik',
    air119: 'Zurich',
    air121: 'Vancouver',
    air122: 'Calgary',
    air123: 'Wellington',
    air124: 'Portland',
    air125: 'Stockholm',
    air128: 'Islande',
    air129: 'Suisse',
    air131: 'Canada',
    air134: 'États-Unis',
    air136: 'Norvège',
    air137: 'Danemark',
    air138: 'Taux de pollution de l\'air',
    air139: 'Tous les pays',
    air140: 'Le plus pollué',
    air141: 'Meilleure qualité',
    air143: 'Échec de la récupération des données de pollution de l\'air. Code d\'erreur:',
    air144: 'Ville non trouvée. Veuillez vérifier le nom.',
    air145: 'Échec de la récupération des données géographiques. Code d\'erreur:',
    air146: 'Une erreur s\'est produite:',
    air147: 'Surveillance de la qualité de l\'air',
    air149: 'Dans le continent',
    air150: 'Situé dans',
    air151: 'Indice de qualité de l\'air (AQI): ',
    air152: 'Composants',
    air153: 'Bon: L\'air est propre et convient à la plupart des gens.',
    air154: 'Modéré: Certaines personnes peuvent ressentir une légère sensibilité.',
    air155: 'Insalubre pour les groupes sensibles: Peut affecter les personnes atteintes de maladies respiratoires ou de sensibilités.',
    air156: 'Insalubre: Affecte tout le monde, en particulier les personnes sensibles.',
    air157: 'Très insalubre: Présente un risque significatif pour la santé publique.',
    air158: 'Informations insuffisantes.',
    air159: 'Échec de la récupération des données pour certaines villes',
    air160: 'Polluants et leurs concentrations basés sur l\'Indice de qualité de l\'air:',
    air161: 'Comment les polluants affectent-ils notre santé?',
    air162: 'Explication du tableau:',
    air163: 'Tableau de qualité de l\'air basé sur les concentrations: ',
    air167: 'Très élevé',
    air168: 'Les polluants atmosphériques tels que PM2.5, PM10, NO2, SO2 peuvent causer divers problèmes de santé, tels que des difficultés respiratoires, des allergies et des maladies cardiaques. '
        'Le danger augmente lorsque les personnes sont exposées à des concentrations plus élevées de ces polluants. Par exemple, des concentrations élevées de PM2.5 peuvent entraîner une détérioration de la fonction pulmonaire et un risque accru de cancer du poumon. '
        'Des concentrations élevées d\'ozone (O3) causent une irritation des voies respiratoires et augmentent les risques de maladies respiratoires telles que l\'asthme. '
        'Voici des explications détaillées de chaque polluant et de ses effets sur la santé: \n\n'
        '1. **SO2 (Dioxyde de soufre):** Ce polluant provoque une irritation des yeux, du nez et de la gorge et peut aggraver les maladies respiratoires telles que la bronchite et l\'asthme. '
        'Une exposition prolongée peut entraîner des maladies cardiaques chroniques et des troubles de la fonction pulmonaire. Des concentrations élevées de SO2 sont extrêmement dangereuses pour les personnes atteintes de maladies respiratoires chroniques.\n\n'
        '2. **NO2 (Oxyde d\'azote):** Ce polluant provoque une irritation des poumons et peut aggraver les problèmes respiratoires tels que l\'asthme et la bronchite. '
        'Une exposition à long terme au NO2 augmente le risque de maladies cardiaques et d\'AVC, et augmente également la susceptibilité du corps aux infections pulmonaires.\n\n'
        '3. **PM2.5 (Particules fines):** Les particules d\'une taille de 2,5 microns ou moins peuvent pénétrer profondément dans les voies respiratoires et atteindre les poumons. '
        'Ces particules causent de graves problèmes de santé, y compris une augmentation des cas d\'asthme, de bronchite chronique, une détérioration de la fonction pulmonaire et un risque accru de cancer du poumon et de maladies cardiaques.\n\n'
        '4. **PM10 (Particules plus grosses):** Ces particules sont plus grandes que PM2.5 mais peuvent encore causer des problèmes de santé similaires, en particulier chez les personnes asthmatiques ou atteintes de maladies cardiaques.\n\n'
        '5. **O3 (Ozone):** L\'ozone peut provoquer une irritation du système respiratoire, entraînant un essoufflement et une bronchite. Il augmente également le risque de maladies respiratoires chroniques telles que l\'asthme. '
        'Une exposition continue à des niveaux élevés d\'ozone peut également réduire la capacité des poumons à absorber l\'oxygène.\n\n'
        'Nous devons être prudents face à la pollution de l\'air, surtout dans les zones urbaines animées où les niveaux de pollution sont plus élevés. Il est important d\'utiliser des dispositifs de mesure de la pollution de l\'air à l\'intérieur des maisons et d\'éviter les zones polluées pendant les heures de pointe. '
        'La sensibilisation environnementale et la surveillance de la qualité de l\'air contribuent à améliorer la santé publique et à protéger l\'environnement.',
    air169: 'Le tableau précédent affiche les concentrations de divers polluants dans l\'air en fonction de l\'Indice de qualité de l\'air, classant les niveaux de pollution de bas à très élevé. '
        'Les concentrations de polluants tels que SO2, NO2, PM2.5, PM10 et O3 sont affichées à différents niveaux de qualité: \n\n'
        '1. **Première colonne (SO2):** Représente la concentration de dioxyde de soufre dans l\'air en microgrammes par mètre cube. Elle est considérée comme élevée lorsque les valeurs dépassent 1065.\n\n'
        '2. **Deuxième colonne (NO2):** Représente la concentration d\'oxyde d\'azote dans l\'air. Elle est considérée comme modérée lorsqu\'elle varie entre 89-177 microgrammes par mètre cube.\n\n'
        '3. **Troisième colonne (PM2.5):** Représente la concentration de particules fines (moins de 2,5 microns). La pollution est sévère lorsque la concentration dépasse 71 microgrammes par mètre cube.\n\n'
        '4. **Quatrième colonne (PM10):** Montre la concentration de particules de plus de 2,5 microns et moins de 10 microns dans l\'air. Des niveaux élevés de pollution sont indiqués par des concentrations dépassant 101 microgrammes par mètre cube.\n\n'
        '5. **Cinquième colonne (O3):** Représente la concentration d\'ozone dans l\'air. Des valeurs élevées de ce polluant causent des problèmes de santé respiratoire, en particulier chez les personnes asthmatiques.\n\n'
        'Ces indicateurs reflètent l\'importance de prendre des mesures préventives lorsque les niveaux de pollution sont élevés et soulignent l\'importance de prêter attention aux indicateurs environnementaux pour vivre dans un environnement plus sain.',
    air170: 'compagnon',
    air171: 'toi',

    air200: 'Pure Breath, bienvenue dans l\'application',
    quickReply1: "Comment pouvons-nous tous contribuer à la protection de l'environnement ?",
    quickReply2: "Quelle est l'importance de réduire l'utilisation du plastique pour protéger les océans ?",
    quickReply3: "Comment le recyclage contribue-t-il à la réduction des déchets et à la stimulation de l'économie circulaire ?",
    quickReply4: "Quel est le rôle de la plantation d'arbres dans l'absorption du dioxyde de carbone ?",
    quickReply5: "Comment l'utilisation des sources d'énergie renouvelables réduit-elle les émissions nocives ?",
    quickReply6: "Pourquoi la conservation de l'eau est-elle importante pour préserver les ressources naturelles ?",
    quickReply7: "Comment la sensibilisation à l'environnement améliore-t-elle les comportements durables ?",
    quickReply8: "Quel est l'avantage des transports publics dans la réduction de la pollution de l'air ?",
    quickReply9: "Pourquoi la réduction de la consommation d'électricité est-elle considérée comme une contribution à la protection de l'environnement ?",
    quickReply10: "Quelle est l'importance de l'élimination correcte des déchets électroniques ?",
    quickReply11: "Comment l'utilisation de matériaux réutilisables réduit-elle les déchets ?",
    quickReply12: "Quelle est l'importance de préserver la biodiversité pour garantir la durabilité des écosystèmes ?",
    quickReply13: "Comment la réduction des émissions de carbone contribue-t-elle à la lutte contre le changement climatique ?",
    quickReply14: "Quel est l'effet de l'afforestation urbaine sur la qualité de l'air ?",
    quickReply15: "Comment l'agriculture biologique préserve-t-elle le sol et l'eau ?",
    quickReply16: "Pourquoi faut-il réduire l'utilisation des produits chimiques pour protéger les organismes vivants ?",
    quickReply17: "Quel est le rôle de l'encouragement de la marche et du vélo dans la réduction de la pollution ?",
    quickReply18: "Comment la conservation de la faune contribue-t-elle à l'équilibre des écosystèmes ?",
    quickReply19: "Quelle est la relation entre la réduction de la consommation de viande et l'empreinte carbone ?",
    quickReply20: "Comment l'énergie solaire peut-elle être une alternative propre à l'énergie ?",
    quickReply21: "Pourquoi préserver les espaces verts est-il important pour améliorer la qualité de vie ?",
    quickReply22: "Quel est l'impact de la réduction de l'utilisation des sacs en plastique sur la protection de la vie marine ?",
    quickReply23: "Comment la gestion efficace des déchets contribue-t-elle à la protection de l'environnement et de la santé publique ?",
    quickReply24: "Quel est l'avantage de promouvoir la réutilisation dans la réduction des déchets ?",
    quickReply25: "Pourquoi préserver les rivières et les lacs est-il crucial pour protéger les ressources en eau ?",
    quickReply26: "Comment la technologie propre favorise-t-elle le développement durable ?",
    quickReply27: "Quelle est l'importance de réduire l'utilisation du papier pour préserver les forêts ?",
    quickReply28: "Comment sensibiliser à l'importance de l'environnement favorise-t-il l'engagement communautaire ?",
    quickReply29: "Pourquoi encourager l'innovation verte est-il essentiel pour fournir des solutions environnementales efficaces ?",
    quickReply30: "Comment préserver un air pur contribue-t-il à améliorer la santé publique ?",
    quickReply31: "Quelle est l'importance de réduire le bruit pour créer un environnement calme et sain ?",
    quickReply32: "Comment les matériaux écologiques protègent-ils la nature et réduisent-ils la pollution ?",
    quickReply33: "Pourquoi faut-il préserver les ressources naturelles pour garantir l'avenir des générations futures ?",
    quickReply34: "Quelle est l'importance de promouvoir l'écotourisme pour préserver les sites naturels ?",
    quickReply35: "Comment réduire la consommation de combustibles fossiles contribue-t-il à la protection de l'environnement ?",
    quickReply36: "Quel est le rôle de la préservation de la qualité du sol pour assurer une production durable des cultures ?",
    quickReply37: "Comment les voitures électriques réduisent-elles les émissions ?",
    quickReply38: "Quelle est l'importance de préserver les récifs coralliens pour protéger la biodiversité marine ?",
    quickReply39: "Pourquoi la réduction de l'utilisation des pesticides est-elle bénéfique pour la santé des organismes vivants ?",
    quickReply40: "Quel est l'effet de la promotion des pratiques agricoles durables sur l'environnement ?",
    quickReply41: "Comment un air pur contribue-t-il à améliorer la santé publique ?",
    quickReply42: "Quel est l'avantage de réduire la consommation d'énergie pour améliorer l'efficacité des ressources ?",
    quickReply43: "Comment l'énergie propre protège-t-elle l'environnement ?",
    quickReply44: "Pourquoi préserver la vie marine est-il crucial pour l'équilibre des écosystèmes ?",
    quickReply45: "Quelle est l'importance de réduire l'utilisation du plastique pour protéger la vie marine ?",
    quickReply46: "Comment le recyclage contribue-t-il à la préservation des ressources naturelles ?",
    quickReply47: "Quelle est l'importance de préserver l'environnement pour améliorer la qualité de vie pour tous ?",
    quickReply48: "Comment la réduction des émissions contribue-t-elle à lutter contre le réchauffement climatique ?",
    quickReply49: "Pourquoi encourager la durabilité est-il essentiel pour préserver les ressources pour les générations futures ?",
  };
  static const Map<String, dynamic> ES = {
    airs36: "Índice de calidad del agua:",
    airs40: "Excelente",

    airs1: "Por favor, introduzca el nombre de una ubicación o país para buscar",
    airs37: "Grado descriptivo:",
    airs38: "No hay datos de calidad del agua para mostrar.",
    air1: 'Cargando...',
    air2: 'Cargando sitio...',
    air3: 'Suecia',
    air4: 'Finlandia',
    air5: 'Nueva Zelanda',
    air6: 'India',
    air7: 'China',
    air8: 'Pakistán',
    air9: 'Copenhague',
    air10: 'Helsinki',
    air11: 'Oslo',
    air12: 'Delhi',
    air13: 'Beijing',
    air14: 'Kaol Walmor',
    air15: 'No se encontraron datos de calidad del aire.',
    air16: 'Ocurrió un error al obtener los datos.',
    air17: 'Error de conexión a Internet.',
    air18: 'Los servicios de ubicación están deshabilitados.',
    air19: 'Permiso de ubicación denegado.',
    air20: 'Permiso de ubicación denegado permanentemente.',
    air21: 'Tu ubicación actual',
    air23: 'Ocurrió un error al obtener los datos de calidad del aire.',
    air24: 'Error de conexión a Internet u obtención de ubicación.:',
    air25: 'Ubicación:',
    air26: 'Ubicación no encontrada.',
    air28: 'Bueno',
    air29: 'Aceptable',
    air30: 'Moderado',
    air31: 'Pobre',
    air32: 'Muy Pobre',
    air33: 'Desconocido',
    air34: 'Índice de Calidad del Aire',
    air35: 'Ingresa el nombre de la ciudad',
    air36: 'Índice de Calidad del Aire:',
    air37: '''Consejos para lidiar
con la calidad actual del aire''',
    air38: 'Contaminantes y sus concentraciones',
    air39: 'Mejores y peores países',
    air40: 'Mapa',
    air41: 'Acerca de la aplicación',
    air42: 'Aprende más',
    air43: 'Bajo',
    air45: 'Alto',
    air46: 'No se pudo abrir el enlace',
    air48: 'Descripción de la aplicación',
    air49: 'Esta aplicación ayuda a los usuarios a monitorear la calidad del aire en tiempo real basándose en datos en vivo de las APIs. La aplicación permite a los usuarios conocer el estado de la calidad del aire en sus ubicaciones actuales o manualmente.\n\nLa aplicación proporciona datos sobre contaminantes como PM2.5, PM10 y CO, y también permite a los usuarios obtener consejos sobre cómo protegerse de la contaminación del aire.',
    air50: 'Información de contacto del desarrollador',
    air51: 'Correo electrónico:',
    air52: 'Fuente de datos:',
    air53: '¿Por qué diseñaste esta aplicación?',
    air54: 'Esta aplicación fue diseñada para ayudar a las personas a mejorar su conciencia sobre la calidad del aire que las rodea y a proteger su salud y la de sus seres queridos. '
        'Dado que la contaminación del aire representa una amenaza creciente para la salud pública, la aplicación tiene como objetivo proporcionar información precisa y actualizada sobre la calidad del aire '
        'de manera fácil y simplificada.',
    air55: '- Permitir a los usuarios conocer el estado de la calidad del aire en su área momento a momento.\n'
        '- Proporcionar consejos prácticos para mantener su salud al enfrentar niveles altos de contaminación.\n'
        '- Contribuir a aumentar la conciencia ambiental y fomentar comportamientos saludables.',
    air56: 'Mensaje del ícono',
    air57: 'Nos esforzamos por hacer del mundo un lugar más saludable facilitando el acceso a la información sobre la calidad del aire y apoyando a las personas para que tomen decisiones informadas para proteger su salud y la de sus comunidades.',
    air58: 'Explicación del ícono del pájaro',
    air59: 'El ícono del pájaro fue elegido cuidadosamente para transmitir el mensaje principal de la aplicación. El pájaro simboliza:\n\n'
        '1. Pureza y aire limpio:\n'
        'Los pájaros suelen ser un símbolo de un ambiente limpio y saludable, ya que no viven en lugares contaminados. El ícono representa la esperanza de un mejor ambiente y aire limpio.\n\n'
        '2. Libertad y respiración adecuada:\n'
        'El vuelo libre del pájaro simboliza una respiración libre sin preocuparse por la contaminación del aire.\n\n'
        '3. Conexión con la naturaleza:\n'
        'El pájaro nos recuerda amablemente la naturaleza y nuestra necesidad de preservarla mediante la concienciación sobre la calidad del aire y el apoyo a los esfuerzos ambientales.',
    air60: 'El ícono no es solo un diseño; es un llamado a los usuarios para que se preocupen por la calidad del aire que los rodea, protejan a sí mismos y a la naturaleza, y logren un mejor equilibrio entre el ser humano y el medio ambiente.',
    air61: 'Servicios de ubicación deshabilitados',
    air62: 'Por favor, habilita los servicios de ubicación para acceder a las funciones de la aplicación.',
    air63: 'OK',
    air64: 'Permisos de ubicación denegados',
    air65: 'Por favor, permite los permisos para acceder a tu ubicación.',
    air66: 'Reintentar',
    air67: 'Permisos de ubicación denegados permanentemente',
    air68: 'Por favor, habilita los permisos desde la configuración de la aplicación para acceder a tu ubicación.',
    air69: 'Abrir configuración',
    air70: 'No se pudieron obtener los datos de calidad del aire. Por favor, inténtalo de nuevo más tarde.',
    air71: 'Ocurrió un error al obtener los datos. Por favor, verifica tu conexión a Internet e inténtalo de nuevo.',
    air72: 'Error',
    air76: 'Insalubre',
    air77: 'Muy Insalubre',
    air78: 'Peligroso',
    air81: 'Nivel de calidad del aire',
    air82: 'Calidad del aire',
    air83: 'La contaminación del aire se ha convertido en un problema crítico que afecta directamente nuestra salud y el medio ambiente. La contaminación del aire resulta de muchas actividades humanas como vehículos industriales, emisiones de fábricas y vehículos. Puede llevar a enfermedades respiratorias y cardíacas, además de su impacto general en el medio ambiente.',
    air84: 'Consejos para manejar la calidad del aire:',
    air85: 'Consejos adicionales:',
    air86: 'Al final, prestar atención a la calidad del aire y proteger tu salud es esencial. Todos pueden desempeñar un papel en la reducción de la contaminación y mantener un ambiente saludable para todos. Si todos trabajamos juntos, podemos mejorar la calidad del aire y asegurar una mejor vida para las generaciones futuras.',
    air94: '1. Asegúrate de conocer el Índice de Calidad del Aire diario en tu área y sigue las instrucciones locales sobre actividades al aire libre.',
    air95: '2. Cuando la calidad del aire sea mala, intenta quedarte en interiores tanto como sea posible y evita lugares concurridos.',
    air96: '3. Si padeces enfermedades respiratorias, consulta a tu médico sobre cómo protegerte de los efectos de la contaminación.',
    air97: '4. Interactúa con la comunidad local y participa en esfuerzos para reducir la contaminación.',
    air98: 'Nueva Delhi',
    air99: 'Lahore',
    air100: 'Dhaka',
    air101: 'Karachi',
    air103: 'Ulan Bator',
    air104: 'El Cairo',
    air105: 'Yakarta',
    air106: 'Bagdad',
    air107: 'Mumbai',
    air110: 'Bangladesh',
    air113: 'Mongolia',
    air114: 'Egipto',
    air115: 'Indonesia',
    air116: 'Irak',
    air118: 'Reikiavik',
    air119: 'Zúrich',
    air121: 'Vancouver',
    air122: 'Calgary',
    air123: 'Wellington',
    air124: 'Portland',
    air125: 'Estocolmo',
    air128: 'Islandia',
    air129: 'Suiza',
    air131: 'Canadá',
    air134: 'EE.UU.',
    air136: 'Noruega',
    air137: 'Dinamarca',
    air138: 'Tasa de contaminación del aire',
    air139: 'Todos los países',
    air140: 'Más contaminado',
    air141: 'Mejor calidad',
    air143: 'Error al obtener los datos de contaminación del aire. Código de error:',
    air144: 'Ciudad no encontrada. Por favor, verifica el nombre.',
    air145: 'Error al obtener los datos geográficos. Código de error:',
    air146: 'Ocurrió un error:',
    air147: 'Monitoreo de calidad del aire',
    air149: 'En el continente',
    air150: 'Ubicado en',
    air151: 'Índice de Calidad del Aire (AQI): ',
    air152: 'Componentes',
    air153: 'Bueno: El aire está limpio y es adecuado para la mayoría de las personas.',
    air154: 'Moderado: Algunas personas pueden sentir una ligera sensibilidad.',
    air155: 'Insalubre para grupos sensibles: Puede afectar a personas con enfermedades respiratorias o sensibilidades.',
    air156: 'Insalubre: Afecta a todos, especialmente a individuos sensibles.',
    air157: 'Muy Insalubre: Representa un riesgo significativo para la salud pública.',
    air158: 'Información insuficiente.',
    air159: 'Error al obtener datos para algunas ciudades',
    air160: 'Contaminantes y sus concentraciones según el Índice de Calidad del Aire:',
    air161: '¿Cómo afectan los contaminantes nuestra salud?',
    air162: 'Explicación de la tabla:',
    air163: 'Tabla de calidad del aire basada en las concentraciones: ',
    air167: 'Muy Alto',
    air168: 'Los contaminantes del aire como PM2.5, PM10, NO2, SO2 pueden causar diversos problemas de salud, como dificultad para respirar, alergias y enfermedades cardíacas. '
        'El peligro aumenta cuando las personas están expuestas a concentraciones más altas de estos contaminantes. Por ejemplo, las altas concentraciones de PM2.5 pueden llevar a un deterioro de la función pulmonar y un mayor riesgo de cáncer de pulmón. '
        'Las altas concentraciones de ozono (O3) causan irritación en el sistema respiratorio y aumentan las probabilidades de enfermedades respiratorias como el asma. '
        'Aquí hay explicaciones detalladas de cada contaminante y sus efectos sobre la salud: \n\n'
        '1. **SO2 (Dióxido de azufre):** Este contaminante causa irritación en los ojos, la nariz y la garganta y puede agravar enfermedades respiratorias como la bronquitis y el asma. '
        'La exposición a largo plazo puede llevar a enfermedades cardíacas crónicas y trastornos de la función pulmonar. Las altas concentraciones de SO2 son extremadamente peligrosas para las personas con enfermedades respiratorias crónicas.\n\n'
        '2. **NO2 (Óxido de nitrógeno):** Este contaminante causa irritación en los pulmones y puede empeorar problemas respiratorios como el asma y la bronquitis. '
        'La exposición a largo plazo a NO2 aumenta el riesgo de enfermedades cardíacas y derrames cerebrales, y también aumenta la susceptibilidad del cuerpo a infecciones pulmonares.\n\n'
        '3. **PM2.5 (Partículas finas):** Las partículas con un tamaño de 2.5 micrones o menos pueden entrar profundamente en las vías respiratorias y llegar a los pulmones. '
        'Estas partículas causan graves problemas de salud, incluyendo un aumento de casos de asma, bronquitis crónica, deterioro de la función pulmonar y un mayor riesgo de cáncer de pulmón y enfermedades cardíacas.\n\n'
        '4. **PM10 (Partículas más grandes):** Estas partículas son más grandes que PM2.5 pero aún pueden causar problemas de salud similares, especialmente en personas con asma o enfermedades cardíacas.\n\n'
        '5. **O3 (Ozono):** El ozono puede causar irritación en el sistema respiratorio, llevando a dificultad para respirar y bronquitis. También aumenta el riesgo de enfermedades respiratorias crónicas como el asma. '
        'La exposición continua a altos niveles de ozono también puede reducir la capacidad de los pulmones para absorber oxígeno.\n\n'
        'Debemos tener precaución con la contaminación del aire, especialmente en áreas urbanas concurridas donde los niveles de contaminación son más altos. Es importante usar dispositivos de medición de la contaminación del aire en interiores y evitar áreas contaminadas durante las horas pico. '
        'La conciencia ambiental y el monitoreo de la calidad del aire contribuyen a mejorar la salud pública y proteger el medio ambiente.',
    air169: 'La tabla anterior muestra las concentraciones de varios contaminantes en el aire basándose en el Índice de Calidad del Aire, clasificando los niveles de contaminación de bajo a muy alto. '
        'Las concentraciones de contaminantes como SO2, NO2, PM2.5, PM10 y O3 se muestran en diferentes niveles de calidad: \n\n'
        '1. **Primera columna (SO2):** Representa la concentración de dióxido de azufre en el aire en microgramos por metro cúbico. Se considera alta cuando los valores superan 1065.\n\n'
        '2. **Segunda columna (NO2):** Representa la concentración de óxido de nitrógeno en el aire. Se considera moderada cuando oscila entre 89-177 microgramos por metro cúbico.\n\n'
        '3. **Tercera columna (PM2.5):** Representa la concentración de partículas finas (menos de 2.5 micrones). La contaminación es severa cuando la concentración supera 71 microgramos por metro cúbico.\n\n'
        '4. **Cuarta columna (PM10):** Muestra la concentración de partículas de más de 2.5 micrones y menos de 10 micrones en el aire. Los niveles altos de contaminación se indican por concentraciones que superan 101 microgramos por metro cúbico.\n\n'
        '5. **Quinta columna (O3):** Representa la concentración de ozono en el aire. Los valores altos de este contaminante causan problemas de salud respiratoria, especialmente para personas con asma.\n\n'
        'Estos indicadores reflejan la importancia de tomar medidas preventivas cuando los niveles de contaminación son altos y enfatizan la atención a los indicadores ambientales para vivir en un entorno más saludable.',
    air170: 'compañero',
    air171: 'tú',

    air200: 'Pure Breath, bienvenido a la aplicación',
    quickReply1: "¿Cómo podemos todos contribuir a proteger el medio ambiente?",
    quickReply2: "¿Cuál es la importancia de reducir el uso del plástico para proteger los océanos?",
    quickReply3: "¿Cómo contribuye el reciclaje a la reducción de residuos y estimula la economía circular?",
    quickReply4: "¿Cuál es el papel de la plantación de árboles en la absorción de dióxido de carbono?",
    quickReply5: "¿Cómo el uso de fuentes de energía renovables reduce las emisiones nocivas?",
    quickReply6: "¿Por qué es importante la conservación del agua para preservar los recursos naturales?",
    quickReply7: "¿Cómo la concienciación sobre el medio ambiente mejora los comportamientos sostenibles?",
    quickReply8: "¿Cuál es el beneficio del transporte público para reducir la contaminación del aire?",
    quickReply9: "¿Por qué la reducción del consumo de electricidad se considera una contribución a la protección del medio ambiente?",
    quickReply10: "¿Cuál es la importancia de la eliminación adecuada de los residuos electrónicos?",
    quickReply11: "¿Cómo el uso de materiales reutilizables reduce los residuos?",
    quickReply12: "¿Cuál es la importancia de preservar la biodiversidad para garantizar la sostenibilidad de los ecosistemas?",
    quickReply13: "¿Cómo la reducción de las emisiones de carbono contribuye a la lucha contra el cambio climático?",
    quickReply14: "¿Cuál es el impacto de la reforestación urbana en la calidad del aire?",
    quickReply15: "¿Cómo la agricultura orgánica conserva el suelo y el agua?",
    quickReply16: "¿Por qué se debe reducir el uso de productos químicos para proteger los organismos vivos?",
    quickReply17: "¿Cuál es el papel de fomentar caminar y andar en bicicleta en la reducción de la contaminación?",
    quickReply18: "¿Cómo la conservación de la vida silvestre contribuye al equilibrio de los ecosistemas?",
    quickReply19: "¿Cuál es la relación entre la reducción del consumo de carne y la huella de carbono?",
    quickReply20: "¿Cómo puede la energía solar ser una alternativa limpia a la energía?",
    quickReply21: "¿Por qué es importante preservar los espacios verdes para mejorar la calidad de vida?",
    quickReply22: "¿Cuál es el impacto de reducir el uso de bolsas de plástico en la protección de la vida marina?",
    quickReply23: "¿Cómo una gestión eficaz de los residuos contribuye a la protección del medio ambiente y la salud pública?",
    quickReply24: "¿Cuál es el beneficio de fomentar la reutilización en la reducción de residuos?",
    quickReply25: "¿Por qué es crucial preservar los ríos y lagos para proteger los recursos hídricos?",
    quickReply26: "¿Cómo la tecnología limpia fomenta el desarrollo sostenible?",
    quickReply27: "¿Cuál es la importancia de reducir el uso de papel para preservar los bosques?",
    quickReply28: "¿Cómo la concienciación sobre la importancia del medio ambiente promueve la participación comunitaria?",
    quickReply29: "¿Por qué es esencial fomentar la innovación verde para proporcionar soluciones ambientales eficaces?",
    quickReply30: "¿Cómo contribuir a la preservación del aire limpio mejora la salud pública?",
    quickReply31: "¿Cuál es la importancia de reducir el ruido para crear un ambiente tranquilo y saludable?",
    quickReply32: "¿Cómo los materiales ecológicos protegen la naturaleza y reducen la contaminación?",
    quickReply33: "¿Por qué es necesario preservar los recursos naturales para garantizar el futuro de las generaciones venideras?",
    quickReply34: "¿Cuál es la importancia de fomentar el ecoturismo para preservar los sitios naturales?",
    quickReply35: "¿Cómo la reducción del consumo de combustibles fósiles contribuye a la protección del medio ambiente?",
    quickReply36: "¿Cuál es el papel de preservar la calidad del suelo para garantizar una producción sostenible de cultivos?",
    quickReply37: "¿Cómo los coches eléctricos reducen las emisiones?",
    quickReply38: "¿Cuál es la importancia de preservar los arrecifes de coral para proteger la biodiversidad marina?",
    quickReply39: "¿Por qué la reducción del uso de pesticidas es beneficiosa para la salud de los organismos vivos?",
    quickReply40: "¿Cuál es el impacto de promover prácticas agrícolas sostenibles en el medio ambiente?",
    quickReply41: "¿Cómo el aire limpio contribuye a mejorar la salud pública?",
    quickReply42: "¿Cuál es el beneficio de reducir el consumo de energía para mejorar la eficiencia de los recursos?",
    quickReply43: "¿Cómo la energía limpia protege el medio ambiente?",
    quickReply44: "¿Por qué preservar la vida marina es crucial para el equilibrio de los ecosistemas?",
    quickReply45: "¿Cuál es la importancia de reducir el uso de plástico para proteger la vida marina?",
    quickReply46: "¿Cómo el reciclaje contribuye a la preservación de los recursos naturales?",
    quickReply47: "¿Cuál es la importancia de preservar el medio ambiente para mejorar la calidad de vida de todos?",
    quickReply48: "¿Cómo la reducción de emisiones contribuye a la lucha contra el calentamiento global?",
    quickReply49: "¿Por qué es esencial fomentar la sostenibilidad para preservar los recursos para las generaciones futuras?",
  };
  static const Map<String, dynamic> RU = {
    airs40: "Отлично",

    airs36: "Индекс качества воды:",
    airs1: "Пожалуйста, введите название местоположения или страны для поиска",
    airs37: "Описание уровня:",
    airs38: "Нет данных о качестве воды для отображения.",
    air1: 'Загрузка...',
    air2: 'Загрузка сайта...',
    air3: 'Швеция',
    air4: 'Финляндия',
    air5: 'Новая Зеландия',
    air6: 'Индия',
    air7: 'Китай',
    air8: 'Пакистан',
    air9: 'Копенгаген',
    air10: 'Хельсинки',
    air11: 'Осло',
    air12: 'Дели',
    air13: 'Пекин',
    air14: 'Каол Уолмор',
    air15: 'Данные о качестве воздуха не найдены.',
    air16: 'Произошла ошибка при получении данных.',
    air17: 'Ошибка подключения к Интернету.',
    air18: 'Службы геолокации отключены.',
    air19: 'Разрешение на геолокацию отклонено.',
    air20: 'Разрешение на геолокацию отклонено навсегда.',
    air21: 'Ваше текущее местоположение',
    air23: 'Произошла ошибка при получении данных о качестве воздуха.',
    air24: 'Ошибка подключения к Интернету или получения местоположения.:',
    air25: 'Местоположение:',
    air26: 'Местоположение не найдено.',
    air28: 'Хорошо',
    air29: 'Приемлемо',
    air30: 'Умеренно',
    air31: 'Плохо',
    air32: 'Очень плохо',
    air33: 'Неизвестно',
    air34: 'Индекс качества воздуха',
    air35: 'Введите название города',
    air36: 'Индекс качества воздуха:',
    air37: '''Советы по
  управлению текущим качеством воздуха''',
    air38: 'Загрязнители и их концентрации',
    air39: 'Лучшие и худшие страны',
    air40: 'Карта',
    air41: 'О приложении',
    air42: 'Узнать больше',
    air43: 'Низкий',
    air45: 'Высокий',
    air46: 'Не удалось открыть ссылку',
    air48: 'Описание приложения',
    air49: 'Это приложение помогает пользователям мониторить качество воздуха в режиме реального времени на основе живых данных из API. Приложение позволяет пользователям узнавать состояние качества воздуха в их текущих местоположениях или вручную.\n\nПриложение предоставляет данные о загрязнителях, таких как PM2.5, PM10 и CO, а также позволяет пользователям получать советы о том, как защититься от загрязнения воздуха.',
    air50: 'Контактная информация разработчика',
    air51: 'Электронная почта:',
    air52: 'Источник данных:',
    air53: 'Почему вы разработали это приложение?',
    air54: 'Это приложение было разработано, чтобы помочь людям повысить осведомленность о качестве воздуха вокруг них и защитить их здоровье и здоровье их близких. '
        'Поскольку загрязнение воздуха представляет собой возрастающую угрозу для общественного здоровья, приложение направлено на предоставление точной и актуальной информации о качестве воздуха '
        'простым и упрощенным способом.',
    air55: '- Позволяет пользователям узнавать состояние качества воздуха в их районе момент за моментом.\n'
        '- Предоставляет практические советы для поддержания здоровья при высоких уровнях загрязнения.\n'
        '- Способствует повышению экологической осведомленности и поощрению здоровых поведенческих моделей.',
    air56: 'Сообщение иконки',
    air57: 'Мы стремимся сделать мир более здоровым местом, облегчая доступ к информации о качестве воздуха и поддерживая людей в принятии обоснованных решений для защиты их здоровья и здоровья их сообществ.',
    air58: 'Объяснение иконки птицы',
    air59: 'Иконка птицы была тщательно подобрана, чтобы передать основное сообщение приложения. Птица символизирует:\n\n'
        '1. Чистоту и чистый воздух:\n'
        'Птицы обычно являются символом чистой и здоровой среды, так как они не живут в загрязненных местах. Иконка представляет надежду на лучшее окружение и чистый воздух.\n\n'
        '2. Свободу и правильное дыхание:\n'
        'Свободный полет птицы символизирует свободное дыхание без беспокойства о загрязнении воздуха.\n\n'
        '3. Связь с природой:\n'
        'Птица мягко напоминает нам о природе и нашей необходимости сохранять ее через осведомленность о качестве воздуха и поддержку экологических усилий.',
    air60: 'Иконка не просто дизайн; это призыв к пользователям заботиться о качестве воздуха вокруг них, защищать себя и природу, и достигать лучшего баланса между человеком и окружающей средой.',
    air61: 'Службы геолокации отключены',
    air62: 'Пожалуйста, включите службы геолокации для доступа к функциям приложения.',
    air63: 'ОК',
    air64: 'Разрешения на геолокацию отклонены',
    air65: 'Пожалуйста, разрешите доступ к вашей геолокации.',
    air66: 'Попробовать снова',
    air67: 'Разрешения на геолокацию навсегда отклонены',
    air68: 'Пожалуйста, включите разрешения в настройках приложения для доступа к вашей геолокации.',
    air69: 'Открыть настройки',
    air70: 'Не удалось получить данные о качестве воздуха. Пожалуйста, попробуйте позже.',
    air71: 'Произошла ошибка при получении данных. Пожалуйста, проверьте ваше интернет-соединение и попробуйте снова.',
    air72: 'Ошибка',
    air76: 'Нездорово',
    air77: 'Очень нездорово',
    air78: 'Опасно',
    air81: 'Уровень качества воздуха',
    air82: 'Качество воздуха',
    air83: 'Загрязнение воздуха стало критической проблемой, напрямую влияющей на наше здоровье и окружающую среду. Загрязнение воздуха возникает из-за многих человеческих действий, таких как промышленные транспортные средства, выбросы от заводов и транспортных средств. Оно может привести к респираторным заболеваниям и сердечным болезням, а также оказывать общее воздействие на окружающую среду.',
    air84: 'Советы по управлению качеством воздуха:',
    air85: 'Дополнительные советы:',
    air86: 'В конце концов, внимание к качеству воздуха и защита вашего здоровья крайне важны. Каждый может сыграть роль в снижении загрязнения и поддержании здоровой окружающей среды для всех. Если мы все будем работать вместе, мы сможем улучшить качество воздуха и обеспечить лучшую жизнь для будущих поколений.',
    air94: '1. Обязательно узнавайте ежедневный индекс качества воздуха в вашем районе и следуйте местным инструкциям по поводу наружных активностей.',
    air95: '2. Когда качество воздуха плохое, старайтесь как можно больше находиться в помещении и избегать многолюдных мест.',
    air96: '3. Если вы страдаете от респираторных заболеваний, проконсультируйтесь с врачом о том, как защитить себя от воздействия загрязнения.',
    air97: '4. Взаимодействуйте с местным сообществом и участвуйте в усилиях по снижению загрязнения.',
    air98: 'Нью-Дели',
    air99: 'Лахор',
    air100: 'Дакка',
    air101: 'Карчи',
    air103: 'Улан-Батор',
    air104: 'Каир',
    air105: 'Джакарта',
    air106: 'Багдад',
    air107: 'Мумбаи',
    air110: 'Бангладеш',
    air113: 'Монголия',
    air114: 'Египет',
    air115: 'Индонезия',
    air116: 'Ирак',
    air118: 'Рейкьявик',
    air119: 'Цюрих',
    air121: 'Ванкувер',
    air122: 'Калгари',
    air123: 'Веллингтон',
    air124: 'Портленд',
    air125: 'Стокгольм',
    air128: 'Исландия',
    air129: 'Швейцария',
    air131: 'Канада',
    air134: 'США',
    air136: 'Норвегия',
    air137: 'Дания',
    air138: 'Уровень загрязнения воздуха',
    air139: 'Все страны',
    air140: 'Самые загрязненные',
    air141: 'Лучшее качество',
    air143: 'Не удалось получить данные о загрязнении воздуха. Код ошибки:',
    air144: 'Город не найден. Пожалуйста, проверьте название.',
    air145: 'Не удалось получить географические данные. Код ошибки:',
    air146: 'Произошла ошибка:',
    air147: 'Мониторинг качества воздуха',
    air149: 'На континенте',
    air150: 'Расположен в',
    air151: 'Индекс качества воздуха (AQI): ',
    air152: 'Компоненты',
    air153: 'Хорошо: Воздух чистый и подходит для большинства людей.',
    air154: 'Умеренно: Некоторые люди могут испытывать небольшую чувствительность.',
    air155: 'Нездорово для чувствительных групп: Может повлиять на людей с респираторными заболеваниями или чувствительностью.',
    air156: 'Нездорово: Влияет на всех, особенно на чувствительных людей.',
    air157: 'Очень нездорово: Представляет значительный риск для общественного здоровья.',
    air158: 'Недостаточно информации.',
    air159: 'Не удалось получить данные для некоторых городов',
    air160: 'Загрязнители и их концентрации на основе Индекса качества воздуха:',
    air161: 'Как загрязнители влияют на наше здоровье?',
    air162: 'Объяснение таблицы:',
    air163: 'Таблица качества воздуха на основе концентраций: ',
    air167: 'Очень высокий',
    air168: 'Воздушные загрязнители, такие как PM2.5, PM10, NO2, SO2, могут вызывать различные проблемы со здоровьем, такие как затрудненное дыхание, аллергии и сердечные заболевания. '
        'Опасность возрастает, когда люди подвергаются воздействию более высоких концентраций этих загрязнителей. Например, высокие концентрации PM2.5 могут привести к ухудшению функции легких и увеличению риска рака легких. '
        'Высокие концентрации озона (O3) вызывают раздражение дыхательной системы и увеличивают вероятность развития респираторных заболеваний, таких как астма. '
        'Вот подробные объяснения каждого загрязнителя и его влияния на здоровье: \n\n'
        '1. **SO2 (Диоксид серы):** Этот загрязнитель вызывает раздражение глаз, носа и горла и может усугублять респираторные заболевания, такие как бронхит и астма. '
        'Длительное воздействие может привести к хроническим сердечным заболеваниям и нарушениям функции легких. Высокие концентрации SO2 чрезвычайно опасны для людей с хроническими респираторными заболеваниями.\n\n'
        '2. **NO2 (Оксид азота):** Этот загрязнитель вызывает раздражение легких и может ухудшать проблемы с дыханием, такие как астма и бронхит. '
        'Длительное воздействие NO2 увеличивает риск сердечных заболеваний и инсультов, а также повышает восприимчивость организма к легочным инфекциям.\n\n'
        '3. **PM2.5 (Мелкие частицы):** Частицы размером 2.5 микрона или меньше могут проникать глубоко в дыхательные пути и достигать легких. '
        'Эти частицы вызывают серьезные проблемы со здоровьем, включая увеличение случаев астмы, хронический бронхит, ухудшение функции легких и повышение риска рака легких и сердечных заболеваний.\n\n'
        '4. **PM10 (Более крупные частицы):** Эти частицы больше, чем PM2.5, но все еще могут вызывать аналогичные проблемы со здоровьем, особенно у людей с астмой или сердечными заболеваниями.\n\n'
        '5. **O3 (Озон):** Озон может вызывать раздражение дыхательной системы, приводя к отдышке и бронхиту. Он также увеличивает риск хронических респираторных заболеваний, таких как астма. '
        'Постоянное воздействие высоких уровней озона также может снижать способность легких поглощать кислород.\n\n'
        'Мы должны быть осторожны с загрязнением воздуха, особенно в густонаселенных городских районах, где уровни загрязнения выше. Важно использовать устройства для измерения загрязнения воздуха в помещениях и избегать загрязненных районов в часы пик. '
        'Экологическая осведомленность и мониторинг качества воздуха способствуют улучшению общественного здоровья и защите окружающей среды.',
    air169: 'Предыдущая таблица отображает концентрации различных загрязнителей в воздухе на основе Индекса качества воздуха, классифицируя уровни загрязнения от низких до очень высоких. '
        'Концентрации загрязнителей, таких как SO2, NO2, PM2.5, PM10 и O3, отображаются на разных уровнях качества: \n\n'
        '1. **Первый столбец (SO2):** Представляет концентрацию диоксида серы в воздухе в микрограммах на кубический метр. Считается высокой, когда значения превышают 1065.\n\n'
        '2. **Второй столбец (NO2):** Представляет концентрацию оксида азота в воздухе. Считается умеренной, когда она находится в диапазоне от 89 до 177 микрограммов на кубический метр.\n\n'
        '3. **Третий столбец (PM2.5):** Представляет концентрацию мелких частиц (менее 2.5 микрон). Загрязнение считается серьезным, когда концентрация превышает 71 микрограмм на кубический метр.\n\n'
        '4. **Четвертый столбец (PM10):** Показывает концентрацию частиц размером более 2.5 микрон и менее 10 микрон в воздухе. Высокие уровни загрязнения указываются концентрациями, превышающими 101 микрограмм на кубический метр.\n\n'
        '5. **Пятый столбец (O3):** Представляет концентрацию озона в воздухе. Высокие значения этого загрязнителя вызывают проблемы со здоровьем дыхательной системы, особенно у людей с астмой.\n\n'
        'Эти показатели отражают важность принятия профилактических мер при высоких уровнях загрязнения и подчеркивают необходимость внимания к экологическим индикаторам для жизни в более здоровой среде.',
    air170: 'спутник',
    air171: 'ты',

    air200: 'Pure Breath, добро пожаловать в приложение',
    quickReply1: "Как мы все можем способствовать охране окружающей среды?",
    quickReply2: "Какова важность сокращения использования пластика для защиты океанов?",
    quickReply3: "Как переработка помогает снижать количество отходов и стимулирует круговую экономику?",
    quickReply4: "Какова роль посадки деревьев в поглощении углекислого газа?",
    quickReply5: "Как использование возобновляемых источников энергии снижает вредные выбросы?",
    quickReply6: "Почему сохранение воды важно для сохранения природных ресурсов?",
    quickReply7: "Как экологическое сознание способствует устойчивому поведению?",
    quickReply8: "Какое значение для снижения загрязнения воздуха имеет общественный транспорт?",
    quickReply9: "Почему сокращение потребления электроэнергии считается вкладом в охрану окружающей среды?",
    quickReply10: "Какова важность правильной утилизации электронных отходов?",
    quickReply11: "Как использование материалов, которые можно повторно использовать, помогает сокращать отходы?",
    quickReply12: "Какова важность сохранения биоразнообразия для обеспечения устойчивости экосистем?",
    quickReply13: "Как сокращение выбросов углерода помогает бороться с изменением климата?",
    quickReply14: "Какое влияние оказывает озеленение городов на качество воздуха?",
    quickReply15: "Как органическое земледелие помогает сохранять почву и воду?",
    quickReply16: "Почему необходимо сократить использование химических веществ для защиты живых существ?",
    quickReply17: "Как поддержка ходьбы и велоспорта способствует снижению загрязнения?",
    quickReply18: "Как охрана дикой природы помогает поддерживать баланс экосистем?",
    quickReply19: "Как сокращение потребления мяса связано с углеродным следом?",
    quickReply20: "Как солнечная энергия может стать чистой альтернативой энергетическим источникам?",
    quickReply21: "Почему сохранение зеленых зон важно для улучшения качества жизни?",
    quickReply22: "Как сокращение использования пластиковых пакетов помогает защитить морскую фауну?",
    quickReply23: "Как эффективное управление отходами способствует охране окружающей среды и общественного здоровья?",
    quickReply24: "Какое значение для сокращения отходов имеет стимулирование повторного использования?",
    quickReply25: "Почему сохранение рек и озер важно для защиты водных ресурсов?",
    quickReply26: "Как чистые технологии способствуют устойчивому развитию?",
    quickReply27: "Какова важность сокращения использования бумаги для сохранения лесов?",
    quickReply28: "Как осведомленность о значении охраны окружающей среды способствует общественному участию?",
    quickReply29: "Почему поддержка зеленых инноваций важна для предоставления эффективных экологических решений?",
    quickReply30: "Как сохранение чистого воздуха способствует улучшению общественного здоровья?",
    quickReply31: "Почему сокращение шума важно для создания спокойной и здоровой среды?",
    quickReply32: "Как экологичные материалы защищают природу и уменьшают загрязнение?",
    quickReply33: "Почему необходимо сохранять природные ресурсы для обеспечения будущего поколений?",
    quickReply34: "Какова важность продвижения экологического туризма для сохранения природных объектов?",
    quickReply35: "Как сокращение потребления ископаемых видов топлива помогает охране окружающей среды?",
    quickReply36: "Как сохранение качества почвы помогает обеспечивать устойчивое производство сельскохозяйственных культур?",
    quickReply37: "Как электрические автомобили снижают выбросы?",
    quickReply38: "Какова важность сохранения коралловых рифов для защиты морского биоразнообразия?",
    quickReply39: "Почему сокращение использования пестицидов полезно для здоровья живых существ?",
    quickReply40: "Как поддержка устойчивого сельского хозяйства влияет на окружающую среду?",
    quickReply41: "Как чистый воздух способствует улучшению общественного здоровья?",
    quickReply42: "Как сокращение потребления энергии способствует улучшению эффективности использования ресурсов?",
    quickReply43: "Как чистая энергия защищает окружающую среду?",
    quickReply44: "Почему сохранение морской жизни важно для баланса экосистем?",
    quickReply45: "Какова важность сокращения использования пластика для защиты морской жизни?",
    quickReply46: "Как переработка помогает сохранить природные ресурсы?",
    quickReply47: "Почему сохранение окружающей среды важно для улучшения качества жизни для всех?",
    quickReply48: "Как сокращение выбросов помогает бороться с глобальным потеплением?",
    quickReply49: "Почему поддержка устойчивости необходима для сохранения ресурсов для будущих поколений?"
  };
  static const Map<String, dynamic> TR = {
    airs40: "Mükemmel",

    airs36: "Su Kalitesi Endeksi:",
    airs1: "Lütfen bir yer veya ülke adı girin",
    airs37: "Tanımlayıcı derece:",
    airs38: "Gösterilecek su kalitesi verisi yok.",
    air1: 'Yükleniyor...',
    air2: 'Site yükleniyor...',
    air3: 'İsveç',
    air4: 'Finlandiya',
    air5: 'Yeni Zelanda',
    air6: 'Hindistan',
    air7: 'Çin',
    air8: 'Pakistan',
    air9: 'Kopenhag',
    air10: 'Helsinki',
    air11: 'Oslo',
    air12: 'Delhi',
    air13: 'Pekin',
    air14: 'Kaol Walmor',
    air15: 'Hava kalitesi verileri bulunamadı.',
    air16: 'Veri alınırken bir hata oluştu.',
    air17: 'İnternet bağlantı hatası.',
    air18: 'Konum servisleri devre dışı.',
    air19: 'Konum izni reddedildi.',
    air20: 'Konum izni kalıcı olarak reddedildi.',
    air21: 'Mevcut konumunuz',
    air23: 'Hava kalitesi verileri alınırken bir hata oluştu.',
    air24: 'İnternet bağlantı hatası veya konum alınamıyor.:',
    air25: 'Konum:',
    air26: 'Konum bulunamadı.',
    air28: 'İyi',
    air29: 'Kabul Edilebilir',
    air30: 'Orta',
    air31: 'Zayıf',
    air32: 'Çok Zayıf',
    air33: 'Bilinmiyor',
    air34: 'Hava Kalitesi İndeksi',
    air35: 'Şehir adını girin',
    air36: 'Hava Kalitesi İndeksi:',
    air37: '''Mevcut hava kalitesi ile başa çıkma
    için ipuçları''',
    air38: 'Kirleticiler ve konsantrasyonları',
    air39: 'En iyi ve en kötü ülkeler',
    air40: 'Harita',
    air41: 'Uygulama hakkında',
    air42: 'Daha fazla bilgi edin',
    air43: 'Düşük',
    air45: 'Yüksek',
    air46: 'Bağlantı açılamıyor',
    air48: 'Uygulama açıklaması',
    air49: 'Bu uygulama, kullanıcıların canlı API verilerine dayalı olarak gerçek zamanlı hava kalitesini izlemelerine yardımcı olur. Uygulama, kullanıcıların mevcut konumlarındaki veya manuel olarak hava kalitesi durumunu bilmelerini sağlar.\n\nUygulama, PM2.5, PM10 ve CO gibi kirleticiler hakkında veri sağlar ve ayrıca kullanıcıların hava kirliliğinden nasıl korunacakları konusunda ipuçları almalarına olanak tanır.',
    air50: 'Geliştirici iletişim bilgileri',
    air51: 'E-posta:',
    air52: 'Veri kaynağı:',
    air53: 'Bu uygulamayı neden tasarladınız?',
    air54: 'Bu uygulama, bireylerin çevrelerindeki hava kalitesi bilincini artırmalarına ve kendi sağlıklarını ve sevdiklerinin sağlığını korumalarına yardımcı olmak için tasarlandı. '
        'Hava kirliliği, halk sağlığı için artan bir tehdit oluşturduğu için uygulamanın amacı, hava kalitesi hakkında doğru ve güncel bilgileri kolay ve basitleştirilmiş bir şekilde sunmaktır.',
    air55: '- Kullanıcıların bölgesindeki hava kalitesi durumunu anlık olarak bilmelerini sağlamak.\n'
        '- Yüksek kirlilik seviyeleriyle karşılaştıklarında sağlıklarını korumak için pratik ipuçları sunmak.\n'
        '- Çevresel bilincin artırılmasına ve sağlıklı davranışların teşvik edilmesine katkıda bulunmak.',
    air56: 'İkon mesajı',
    air57: 'Dünyayı daha sağlıklı bir yer haline getirmek için hava kalitesi bilgisine erişimi kolaylaştırıyor ve bireylerin sağlıklarını ve toplumlarının sağlığını korumak için bilinçli kararlar almalarını destekliyoruz.',
    air58: 'Kuş ikonu açıklaması',
    air59: 'Kuş ikonu, uygulamanın temel mesajını iletmek için özenle seçildi. Kuş, şu anlamları taşır:\n\n'
        '1. Saflık ve temiz hava:\n'
        'Kuşlar genellikle temiz ve sağlıklı bir çevrenin sembolüdür, çünkü kirli yerlerde yaşamazlar. İkon, daha iyi bir çevre ve temiz hava için umut temsil eder.\n\n'
        '2. Özgürlük ve düzgün nefes alma:\n'
        'Kuşun serbest uçuşu, hava kirliliği endişesi olmadan özgürce nefes almayı simgeler.\n\n'
        '3. Doğayla bağlantı:\n'
        'Kuş, doğayı nazikçe hatırlatır ve hava kalitesi bilinci ve çevresel çabaları destekleyerek onu koruma ihtiyacımızı hatırlatır.',
    air60: 'İkon sadece bir tasarım değil; kullanıcıları çevrelerindeki hava kalitesine dikkat etmeye, kendilerini ve doğayı korumaya ve insan ile çevre arasında daha iyi bir denge sağlamaya çağırır.',
    air61: 'Konum servisleri devre dışı',
    air62: 'Uygulamanın özelliklerine erişmek için lütfen konum servislerini etkinleştirin.',
    air63: 'Tamam',
    air64: 'Konum izinleri reddedildi',
    air65: 'Lütfen konumunuza erişmek için izinleri verin.',
    air66: 'Tekrar dene',
    air67: 'Konum izinleri kalıcı olarak reddedildi',
    air68: 'Konumunuza erişmek için lütfen uygulama ayarlarından izinleri etkinleştirin.',
    air69: 'Ayarları aç',
    air70: 'Hava kalitesi verileri alınamadı. Lütfen daha sonra tekrar deneyin.',
    air71: 'Veri alınırken bir hata oluştu. İnternet bağlantınızı kontrol edin ve tekrar deneyin.',
    air72: 'Hata',
    air76: 'Sağlıksız',
    air77: 'Çok sağlıksız',
    air78: 'Tehlikeli',
    air81: 'Hava Kalitesi Seviyesi',
    air82: 'Hava Kalitesi',
    air83: 'Hava kirliliği, sağlığımızı ve çevremizi doğrudan etkileyen kritik bir sorun haline geldi. Hava kirliliği, endüstriyel araçlar, fabrikalardan ve araçlardan çıkan emisyonlar gibi birçok insan etkinliğinden kaynaklanır. Solunum hastalıklarına ve kalp hastalıklarına yol açabilir, ayrıca genel olarak çevre üzerinde etkisi vardır.',
    air84: 'Hava kalitesi ile başa çıkma ipuçları:',
    air85: 'Ek ipuçları:',
    air86: 'Sonuç olarak, hava kalitesine dikkat etmek ve sağlığınızı korumak önemlidir. Herkes kirliliği azaltmada ve herkes için sağlıklı bir çevreyi korumada rol oynayabilir. Hep birlikte çalışırsak, hava kalitesini iyileştirebilir ve gelecek nesiller için daha iyi bir yaşam sağlayabiliriz.',
 air94: '1. Bölgenizdeki günlük Hava Kalitesi İndeksini bilmeye özen gösterin ve dış mekan aktiviteleri ile ilgili yerel talimatlara uyun.',
    air95: '2. Hava kalitesi kötü olduğunda, mümkün olduğunca iç mekanda kalmaya çalışın ve kalabalık yerlerden uzak durun.',
    air96: '3. Solunum hastalıklarınız varsa, kirliliğin etkilerinden korunmak için doktorunuza danışın.',
    air97: '4. Yerel toplulukla etkileşime geçin ve kirliliği azaltmaya yönelik çabalara katılın.',
    air98: 'New Delhi',
    air99: 'Lahore',
    air100: 'Dhaka',
    air101: 'Karachi',
    air103: 'Ulaanbaatar',
    air104: 'Kahire',
    air105: 'Jakarta',
    air106: 'Bağdat',
    air107: 'Mumbai',
    air110: 'Bangladeş',
    air113: 'Moğolistan',
    air114: 'Mısır',
    air115: 'Endonezya',
    air116: 'Irak',
    air118: 'Reykjavik',
    air119: 'Zürih',
    air121: 'Vancouver',
    air122: 'Calgary',
    air123: 'Wellington',
    air124: 'Portland',
    air125: 'Stockholm',
    air128: 'İzlanda',
    air129: 'İsviçre',
    air131: 'Kanada',
    air134: 'ABD',
    air136: 'Norveç',
    air137: 'Danimarka',
    air138: 'Hava kirliliği oranı',
    air139: 'Tüm ülkeler',
    air140: 'En kirli',
    air141: 'En iyi kalite',
    air143: 'Hava kirliliği verileri alınamadı. Hata kodu:',
    air144: 'Şehir bulunamadı. Lütfen adı kontrol edin.',
    air145: 'Coğrafi veriler alınamadı. Hata kodu:',
    air146: 'Bir hata oluştu:',
    air147: 'Hava Kalitesi İzleme',
    air149: 'Kıtada',
    air150: 'Yerleşik',
    air151: 'Hava Kalitesi İndeksi (AQI): ',
    air152: 'Bileşenler',
    air153: 'İyi: Hava temiz ve çoğu insan için uygundur.',
    air154: 'Orta: Bazı insanlar hafif hassasiyet hissedebilir.',
    air155: 'Hassas gruplar için sağlıksız: Solunum hastalıkları veya hassasiyetleri olan insanları etkileyebilir.',
    air156: 'Sağlıksız: Herkesi etkiler, özellikle hassas bireyleri.',
    air157: 'Çok Sağlıksız: Halk sağlığı için önemli bir risk oluşturur.',
    air158: 'Yeterli bilgi yok.',
    air159: 'Bazı şehirler için veriler alınamadı',
    air160: 'Hava Kalitesi İndeks\'ne dayalı olarak Kirleticiler ve konsantrasyonları:',
    air161: 'Kirleticiler sağlığımızı nasıl etkiliyor?',
    air162: 'Tablo açıklaması:',
    air163: 'Konsantrasyonlara dayalı hava kalitesi tablosu: ',
    air167: 'Çok Yüksek',
    air168: 'PM2.5, PM10, NO2, SO2 gibi hava kirliliği kirleticileri, solunum güçlüğü, alerjiler ve kalp hastalıkları gibi çeşitli sağlık sorunlarına neden olabilir. '
        'Bu kirleticilere daha yüksek konsantrasyonlara maruz kalındıkça tehlike artar. Örneğin, PM2.5 konsantrasyonları yüksek olduğunda, akciğer fonksiyonlarının bozulmasına ve akciğer kanseri riskinin artmasına yol açabilir. '
        'Yüksek ozon (O3) konsantrasyonları solunum yollarında tahrişe neden olur ve astım gibi solunum hastalıklarının gelişme olasılığını artırır. '
        'İşte her bir kirletici ve sağlığa etkileri hakkında ayrıntılı açıklamalar: \n\n'
        '1. **SO2 (Kükürt Dioksit):** Bu kirletici, gözlerde, burunda ve boğazda tahrişe neden olur ve bronşit ve astım gibi solunum hastalıklarının şiddetini artırabilir. '
        'Uzun süreli maruz kalma, kronik kalp hastalıklarına ve akciğer fonksiyon bozukluklarına yol açabilir. SO2’nin yüksek konsantrasyonları kronik solunum hastalıkları olan bireyler için son derece tehlikelidir.\n\n'
        '2. **NO2 (Azot Oksit):** Bu kirletici, akciğerlerde tahrişe neden olur ve astım ve bronşit gibi solunum sorunlarını kötüleştirebilir. '
        'NO2’ye uzun süreli maruz kalma, kalp hastalıkları ve felç riskini artırır ve aynı zamanda vücudun akciğer enfeksiyonlarına karşı duyarlılığını artırır.\n\n'
        '3. **PM2.5 (İnce Partiküller):** 2.5 mikron veya daha küçük boyuttaki partiküller, solunum yollarına derinlemesine girebilir ve akciğerlere ulaşabilir. '
        'Bu partiküller, astım vakalarının artması, kronik bronşit, akciğer fonksiyonlarının bozulması ve akciğer kanseri ve kalp hastalıkları riskinin artması gibi ciddi sağlık sorunlarına neden olur.\n\n'
        '4. **PM10 (Daha Büyük Partiküller):** Bu partiküller PM2.5’ten daha büyüktür ancak yine de benzer sağlık sorunlarına neden olabilirler, özellikle astım veya kalp hastalıkları olan kişilerde.\n\n'
        '5. **O3 (Ozon):** Ozon, solunum sistemi tahrişine neden olabilir, nefes darlığına ve bronşite yol açabilir. Ayrıca astım gibi kronik solunum hastalıkları riskini artırır. '
        'Yüksek ozon seviyelerine sürekli maruz kalma, akciğerlerin oksijen emme kapasitesini de azaltabilir.\n\n'
        'Hava kirliliğine, özellikle kirlilik seviyelerinin daha yüksek olduğu yoğun kentsel alanlarda dikkatli olmalıyız. Evlerde hava kirliliği ölçüm cihazları kullanmak ve yoğun saatlerde kirli bölgelerden kaçınmak önemlidir. '
        'Çevresel farkındalık ve hava kalitesinin izlenmesi, halk sağlığını iyileştirmeye ve çevreyi korumaya katkıda bulunur.',
    air169: 'Önceki tablo, Hava Kalitesi İndeksine göre havadaki çeşitli kirleticilerin konsantrasyonlarını göstermekte olup, kirlilik seviyeleri düşükten çok yükseğe doğru sınıflandırılmaktadır. '
        'SO2, NO2, PM2.5, PM10 ve O3 gibi kirleticilerin konsantrasyonları farklı kalite seviyelerinde gösterilmektedir: \n\n'
        '1. **Birinci sütun (SO2):** Havada sülfür dioksit konsantrasyonunu mikrogram/m³ cinsinden temsil eder. Değerler 1065’i aştığında yüksek kabul edilir.\n\n'
        '2. **İkinci sütun (NO2):** Havada azot oksit konsantrasyonunu temsil eder. Mikrogram/m³ başına 89-177 arasında değiştiğinde orta kabul edilir.\n\n'
        '3. **Üçüncü sütun (PM2.5):** İnce partiküllerin (2.5 mikron altı) konsantrasyonunu temsil eder. Konsantrasyon 71 mikrogram/m³’ü aştığında kirlilik şiddetlidir.\n\n'
        '4. **Dördüncü sütun (PM10):** Havada 2.5 mikron üzerinde ve 10 mikron altında olan partiküllerin konsantrasyonunu gösterir. Yüksek kirlilik seviyeleri, konsantrasyonların 101 mikrogram/m³’ü aşmasıyla belirtilir.\n\n'
        '5. **Beşinci sütun (O3):** Havada ozon konsantrasyonunu temsil eder. Bu kirleticinin yüksek değerleri, özellikle astım hastaları için solunum sağlığı sorunlarına neden olur.\n\n'
        'Bu göstergeler, kirlilik seviyeleri yüksek olduğunda önleyici önlemler almanın önemini yansıtmakta ve daha sağlıklı bir çevrede yaşamak için çevresel göstergelere dikkat etmeyi teşvik etmektedir.',
    air170: 'arkadaş',
    air171: 'sen',

    air200: 'Pure Breath, uygulamaya hoş geldiniz',
    quickReply1: "Hepimiz çevrenin korunmasına nasıl katkıda bulunabiliriz?",
    quickReply2: "Okyanusları korumada plastik kullanımını azaltmanın önemi nedir?",
    quickReply3: "Geri dönüşüm, atıkları azaltmaya ve döngüsel ekonomiyi teşvik etmeye nasıl yardımcı olur?",
    quickReply4: "Ağaç dikmenin karbondioksiti emme konusunda ne gibi bir rolü vardır?",
    quickReply5: "Yenilenebilir enerji kaynaklarının kullanılması zararlı emisyonları nasıl azaltır?",
    quickReply6: "Su tasarrufunun doğal kaynakları koruma açısından önemi nedir?",
    quickReply7: "Çevre bilinci, sürdürülebilir davranışları nasıl teşvik eder?",
    quickReply8: "Toplu taşımanın hava kirliliğini azaltmadaki önemi nedir?",
    quickReply9: "Elektrik tüketimini azaltmak çevreyi korumada neden önemlidir?",
    quickReply10: "Elektronik atıkların doğru şekilde atılmasının önemi nedir?",
    quickReply11: "Yeniden kullanılabilir malzemelerin kullanılması atıkları nasıl azaltır?",
    quickReply12: "Biyolojik çeşitliliğin korunmasının ekosistemlerin sürdürülebilirliği açısından önemi nedir?",
    quickReply13: "Karbon emisyonlarını azaltmak iklim değişikliğiyle mücadelede nasıl yardımcı olur?",
    quickReply14: "Şehirlerde ağaçlandırmanın hava kalitesi üzerindeki etkisi nedir?",
    quickReply15: "Organik tarım, toprak ve suyu nasıl korur?",
    quickReply16: "Kimyasal maddelerin kullanımını azaltmak neden canlıları korumak için önemlidir?",
    quickReply17: "Yürüyüş ve bisiklet kullanımının kirliliği azaltmadaki rolü nedir?",
    quickReply18: "Yaban hayatını korumanın ekosistem dengesine nasıl katkı sağladığını anlatınız?",
    quickReply19: "Et tüketimini azaltmak karbon ayak izini nasıl etkiler?",
    quickReply20: "Güneş enerjisi temiz bir enerji alternatifi olarak nasıl kullanılabilir?",
    quickReply21: "Yeşil alanları korumanın yaşam kalitesini iyileştirmedeki önemi nedir?",
    quickReply22: "Plastik poşet kullanımını azaltmak deniz yaşamını nasıl korur?",
    quickReply23: "Etkili atık yönetimi çevreyi ve halk sağlığını nasıl korur?",
    quickReply24: "Yeniden kullanımın teşvik edilmesi atıkları nasıl azaltır?",
    quickReply25: "Nehirleri ve gölleri korumanın su kaynaklarını koruma açısından önemi nedir?",
    quickReply26: "Temiz teknoloji, sürdürülebilir kalkınmaya nasıl katkıda bulunur?",
    quickReply27: "Kağıt kullanımını azaltmanın ormanların korunması açısından önemi nedir?",
    quickReply28: "Çevre bilincinin artırılması toplumsal katılımı nasıl teşvik eder?",
    quickReply29: "Yeşil yeniliği desteklemenin çevresel çözüm sağlama açısından önemi nedir?",
    quickReply30: "Temiz hava sağlığı nasıl iyileştirir?",
    quickReply31: "Gürültü kirliliğinin azaltılması sağlıklı bir çevre oluşturma açısından neden önemlidir?",
    quickReply32: "Çevre dostu materyaller doğayı korur ve kirliliği azaltır nasıl?",
    quickReply33: "Doğal kaynakları korumak neden gelecek nesillerin yaşamı için önemlidir?",
    quickReply34: "Ekoturizmi teşvik etmek doğal alanları korumanın neden önemlidir?",
    quickReply35: "Fosil yakıt tüketiminin azaltılması çevreyi nasıl korur?",
    quickReply36: "Toprağın kalitesini korumak sürdürülebilir tarım üretimi için neden önemlidir?",
    quickReply37: "Elektrikli araçlar emisyonları nasıl azaltır?",
    quickReply38: "Resiflerin korunması deniz biyolojik çeşitliliğinin korunması açısından neden önemlidir?",
    quickReply39: "Pestisit kullanımını azaltmak canlıların sağlığı için neden önemlidir?",
    quickReply40: "Sürdürülebilir tarım uygulamalarını teşvik etmenin çevreye etkisi nedir?",
    quickReply41: "Temiz hava sağlığı nasıl iyileştirir?",
    quickReply42: "Enerji tüketimini azaltmak kaynak verimliliğini nasıl artırır?",
    quickReply43: "Temiz enerji çevreyi nasıl korur?",
    quickReply44: "Deniz yaşamının korunması ekosistem dengesini sağlamak için neden önemlidir?",
    quickReply45: "Plastik kullanımını azaltmak deniz yaşamını korumada nasıl yardımcı olur?",
    quickReply46: "Geri dönüşüm doğal kaynakların korunmasına nasıl katkı sağlar?",
    quickReply47: "Çevreyi korumak tüm yaşam kalitesini nasıl artırır?",
    quickReply48: "Emisyonları azaltmak küresel ısınmaya karşı nasıl mücadeleye yardımcı olur?",
    quickReply49: "Sürdürülebilirliği teşvik etmek gelecekteki nesiller için kaynakları korumanın neden önemlidir?"
  };
  static const Map<String, dynamic> DE = {
    airs40: "Ausgezeichnet",

    airs36: "Wasserqualitätsindex:",
    airs1: "Bitte geben Sie den Namen eines Ortes oder Landes ein, um zu suchen",
    airs37: "Beschreibende Note:",
    airs38: "Keine Wasserqualitätsdaten zum Anzeigen.",
    air1: 'Wird geladen...',
    air2: 'Lade Webseite...',
    air3: 'Schweden',
    air4: 'Finnland',
    air5: 'Neuseeland',
    air6: 'Indien',
    air7: 'China',
    air8: 'Pakistan',
    air9: 'Kopenhagen',
    air10: 'Helsinki',
    air11: 'Oslo',
    air12: 'Delhi',
    air13: 'Peking',
    air14: 'Kaol Walmor',
    air15: 'Luftqualitätsdaten nicht gefunden.',
    air16: 'Beim Abrufen der Daten ist ein Fehler aufgetreten.',
    air17: 'Internetverbindungsfehler.',
    air18: 'Standortdienste sind deaktiviert.',
    air19: 'Standorterlaubnis abgelehnt.',
    air20: 'Standorterlaubnis dauerhaft abgelehnt.',
    air21: 'Ihr aktueller Standort',
    air23: 'Beim Abrufen der Luftqualitätsdaten ist ein Fehler aufgetreten.',
    air24: 'Internetverbindungsfehler oder Standortabfrage.:',
    air25: 'Standort:',
    air26: 'Standort nicht gefunden.',
    air28: 'Gut',
    air29: 'Akzeptabel',
    air30: 'Mäßig',
    air31: 'Schlecht',
    air32: 'Sehr Schlecht',
    air33: 'Unbekannt',
    air34: 'Luftqualitätsindex',
    air35: 'Stadtname eingeben',
    air36: 'Luftqualitätsindex:',
    air37: '''Tipps zur
Bewältigung der aktuellen Luftqualität''',
    air38: 'Schadstoffe und ihre Konzentrationen',
    air39: 'Beste und schlechteste Länder',
    air40: 'Karte',
    air41: 'Über die App',
    air42: 'Mehr erfahren',
    air43: 'Niedrig',
    air45: 'Hoch',
    air46: 'Link kann nicht geöffnet werden',
    air48: 'App-Beschreibung',
    air49: 'Diese App hilft Benutzern, die Luftqualität in Echtzeit basierend auf Live-API-Daten zu überwachen. Die App ermöglicht es den Benutzern, den Zustand der Luftqualität an ihren aktuellen Standorten oder manuell zu kennen.\n\nDie App bietet Daten zu Schadstoffen wie PM2.5, PM10 und CO und ermöglicht es den Benutzern auch, Tipps zum Schutz vor Luftverschmutzung zu erhalten.',
    air50: 'Entwicklerkontaktinformationen',
    air51: 'E-Mail:',
    air52: 'Datenquelle:',
    air53: 'Warum haben Sie diese App entwickelt?',
    air54: 'Diese App wurde entwickelt, um Einzelpersonen zu helfen, ihr Bewusstsein für die umliegende Luftqualität zu verbessern und ihre Gesundheit sowie die ihrer Angehörigen zu schützen. '
        'Da Luftverschmutzung eine zunehmende Bedrohung für die öffentliche Gesundheit darstellt, zielt die App darauf ab, genaue und aktuelle Informationen über die Luftqualität auf einfache und vereinfachte Weise bereitzustellen.',
    air55: '- Ermöglichen Sie den Benutzern, den Luftqualitätsstatus in ihrer Region moment für Moment zu kennen.\n'
        '- Bieten Sie praktische Tipps zur Erhaltung ihrer Gesundheit bei hohen Verschmutzungsniveaus.\n'
        '- Tragen Sie zur Förderung des Umweltbewusstseins und zur Förderung gesunder Verhaltensweisen bei.',
    air56: 'Icon-Nachricht',
    air57: 'Wir streben danach, die Welt zu einem gesünderen Ort zu machen, indem wir den Zugang zu Informationen über die Luftqualität erleichtern und Einzelpersonen unterstützen, informierte Entscheidungen zum Schutz ihrer Gesundheit und der Gesundheit ihrer Gemeinschaften zu treffen.',
    air58: 'Erklärung des Vogel-Icons',
    air59: 'Das Vogel-Icon wurde sorgfältig ausgewählt, um die Kernbotschaft der App zu vermitteln. Der Vogel symbolisiert:\n\n'
        '1. Reinheit und saubere Luft:\n'
        'Vögel sind normalerweise ein Symbol für eine saubere und gesunde Umwelt, da sie nicht in verschmutzten Gebieten leben. Das Icon repräsentiert die Hoffnung auf eine bessere Umwelt und saubere Luft.\n\n'
        '2. Freiheit und ordentliches Atmen:\n'
        'Der freie Flug des Vogels symbolisiert das freie Atmen ohne Sorge um Luftverschmutzung.\n\n'
        '3. Verbindung zur Natur:\n'
        'Der Vogel erinnert sanft an die Natur und unsere Notwendigkeit, sie durch Bewusstsein über die Luftqualität und Unterstützung umweltfreundlicher Bemühungen zu bewahren.',
    air60: 'Das Icon ist nicht nur ein Design; es ist ein Aufruf an die Benutzer, sich um die Luftqualität in ihrer Umgebung zu kümmern, sich selbst und die Natur zu schützen und ein besseres Gleichgewicht zwischen Mensch und Umwelt zu erreichen.',
    air61: 'Standortdienste sind deaktiviert',
    air62: 'Bitte aktivieren Sie Standortdienste, um auf die Funktionen der App zugreifen zu können.',
    air63: 'OK',
    air64: 'Standortberechtigungen abgelehnt',
    air65: 'Bitte erlauben Sie Berechtigungen, um auf Ihren Standort zuzugreifen.',
    air66: 'Erneut versuchen',
    air67: 'Standortberechtigungen dauerhaft abgelehnt',
    air68: 'Bitte aktivieren Sie Berechtigungen in den App-Einstellungen, um auf Ihren Standort zugreifen zu können.',
    air69: 'Einstellungen öffnen',
    air70: 'Abrufen der Luftqualitätsdaten fehlgeschlagen. Bitte versuchen Sie es später erneut.',
    air71: 'Beim Abrufen der Daten ist ein Fehler aufgetreten. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.',
    air72: 'Fehler',
    air76: 'Ungesund',
    air77: 'Sehr ungesund',
    air78: 'Gefährlich',
    air81: 'Luftqualitätsniveau',
    air82: 'Luftqualität',
    air83: 'Die Luftverschmutzung ist zu einem kritischen Problem geworden, das unsere Gesundheit und Umwelt direkt beeinflusst. Luftverschmutzung entsteht durch viele menschliche Aktivitäten wie industrielle Fahrzeuge, Emissionen aus Fabriken und Fahrzeugen. Sie kann zu Atemwegserkrankungen und Herzkrankheiten führen, zusätzlich zu ihren allgemeinen Auswirkungen auf die Umwelt.',
    air84: 'Tipps zum Umgang mit der Luftqualität:',
    air85: 'Zusätzliche Tipps:',
    air86: 'Am Ende ist es unerlässlich, auf die Luftqualität zu achten und Ihre Gesundheit zu schützen. Jeder kann eine Rolle bei der Verringerung der Verschmutzung und der Aufrechterhaltung einer gesunden Umwelt für alle spielen. Wenn wir alle zusammenarbeiten, können wir die Luftqualität verbessern und ein besseres Leben für zukünftige Generationen gewährleisten.',
    air94: '1. Stellen Sie sicher, dass Sie den täglichen Luftqualitätsindex in Ihrer Region kennen und befolgen Sie lokale Anweisungen bezüglich Aktivitäten im Freien.',
    air95: '2. Wenn die Luftqualität schlecht ist, versuchen Sie so weit wie möglich drinnen zu bleiben und meiden Sie überfüllte Orte.',
    air96: '3. Wenn Sie an Atemwegserkrankungen leiden, konsultieren Sie Ihren Arzt, wie Sie sich vor den Auswirkungen der Verschmutzung schützen können.',
    air97: '4. Interagieren Sie mit der lokalen Gemeinschaft und beteiligen Sie sich an Bemühungen zur Reduzierung der Verschmutzung.',
    air98: 'Neu Delhi',
    air99: 'Lahore',
    air100: 'Dhaka',
    air101: 'Karachi',
    air103: 'Ulaanbaatar',
    air104: 'Kairo',
    air105: 'Jakarta',
    air106: 'Bagdad',
    air107: 'Mumbai',
    air110: 'Bangladesch',
    air113: 'Mongolei',
    air114: 'Ägypten',
    air115: 'Indonesien',
    air116: 'Irak',
    air118: 'Reykjavik',
    air119: 'Zürich',
    air121: 'Vancouver',
    air122: 'Calgary',
    air123: 'Wellington',
    air124: 'Portland',
    air125: 'Stockholm',
    air128: 'Island',
    air129: 'Schweiz',
    air131: 'Kanada',
    air134: 'USA',
    air136: 'Norwegen',
    air137: 'Dänemark',

    air138: 'Luftverschmutzungsrate',
    air139: 'Alle Länder',
    air140: 'Am stärksten verschmutzt',
    air141: 'Beste Qualität',
    air143: 'Abrufen der Luftverschmutzungsdaten fehlgeschlagen. Fehlercode:',
    air144: 'Stadt nicht gefunden. Bitte überprüfen Sie den Namen.',
    air145: 'Abrufen der geografischen Daten fehlgeschlagen. Fehlercode:',
    air146: 'Ein Fehler ist aufgetreten:',
    air147: 'Luftqualitätsüberwachung',
    air149: 'Auf dem Kontinent',
    air150: 'Befindet sich in',
    air151: 'Luftqualitätsindex (AQI): ',
    air152: 'Komponenten',
    air153: 'Gut: Die Luft ist sauber und für die meisten Menschen geeignet.',
    air154: 'Mäßig: Einige Personen können eine leichte Empfindlichkeit verspüren.',
    air155: 'Ungesund für empfindliche Gruppen: Kann Personen mit Atemwegserkrankungen oder Empfindlichkeiten beeinträchtigen.',
    air156: 'Ungesund: Beeinträchtigt alle, insbesondere empfindliche Personen.',
    air157: 'Sehr ungesund: Stellt ein erhebliches Risiko für die öffentliche Gesundheit dar.',
    air158: 'Unzureichende Informationen.',
    air159: 'Daten für einige Städte konnten nicht abgerufen werden',
    air160: 'Schadstoffe und ihre Konzentrationen basierend auf dem Luftqualitätsindex:',
    air161: 'Wie wirken sich Schadstoffe auf unsere Gesundheit aus?',
    air162: 'Tabellenerklärung:',
    air163: 'Luftqualitätstabelle basierend auf Konzentrationen: ',
    air167: 'Sehr Hoch',
    air168: 'Luftschadstoffe wie PM2.5, PM10, NO2, SO2 können verschiedene Gesundheitsprobleme verursachen, wie Atembeschwerden, Allergien und Herzkrankheiten. '
        'Die Gefahr steigt, wenn Menschen höheren Konzentrationen dieser Schadstoffe ausgesetzt sind. Zum Beispiel können hohe Konzentrationen von PM2.5 zu einer Verschlechterung der Lungenfunktion und einem erhöhten Risiko für Lungenkrebs führen. '
        'Hohe Ozonkonzentrationen (O3) verursachen Reizungen im Atmungssystem und erhöhen die Wahrscheinlichkeit von Atemwegserkrankungen wie Asthma. '
        'Hier sind detaillierte Erklärungen zu jedem Schadstoff und seinen Auswirkungen auf die Gesundheit: \n\n'
        '1. **SO2 (Schwefeldioxid):** Dieser Schadstoff verursacht Reizungen in den Augen, der Nase und dem Hals und kann Atemwegserkrankungen wie Bronchitis und Asthma verschlimmern. '
        'Langfristige Exposition kann zu chronischen Herzkrankheiten und Störungen der Lungenfunktion führen. Hohe Konzentrationen von SO2 sind extrem gefährlich für Personen mit chronischen Atemwegserkrankungen.\n\n'
        '2. **NO2 (Stickstoffoxid):** Dieser Schadstoff verursacht Reizungen in den Lungen und kann Atemprobleme wie Asthma und Bronchitis verschlimmern. '
        'Langfristige Exposition gegenüber NO2 erhöht das Risiko für Herzkrankheiten und Schlaganfälle und erhöht auch die Anfälligkeit des Körpers für Lungeninfektionen.\n\n'
        '3. **PM2.5 (Feine Partikel):** Partikel mit einer Größe von 2,5 Mikron oder weniger können tief in die Atemwege eindringen und die Lungen erreichen. '
        'Diese Partikel verursachen schwere Gesundheitsprobleme, einschließlich erhöhter Asthmafälle, chronischer Bronchitis, Verschlechterung der Lungenfunktion und erhöhtem Risiko für Lungenkrebs und Herzkrankheiten.\n\n'
        '4. **PM10 (Größere Partikel):** Diese Partikel sind größer als PM2.5, können aber dennoch ähnliche Gesundheitsprobleme verursachen, insbesondere bei Menschen mit Asthma oder Herzkrankheiten.\n\n'
        '5. **O3 (Ozon):** Ozon kann Reizungen im Atmungssystem verursachen, was zu Atemnot und Bronchitis führt. Es erhöht auch das Risiko für chronische Atemwegserkrankungen wie Asthma. '
        'Ständige Exposition gegenüber hohen Ozonkonzentrationen kann auch die Fähigkeit der Lungen zur Sauerstoffaufnahme reduzieren.\n\n'
        'Wir müssen vorsichtig mit der Luftverschmutzung umgehen, insbesondere in stark bewohnten städtischen Gebieten, in denen die Verschmutzungsniveaus höher sind. Es ist wichtig, Luftverschmutzungsmessgeräte in Innenräumen zu verwenden und verschmutzte Gebiete während der Stoßzeiten zu meiden. '
        'Umweltbewusstsein und die Überwachung der Luftqualität tragen zur Verbesserung der öffentlichen Gesundheit und zum Schutz der Umwelt bei.',
    air169: 'Die vorherige Tabelle zeigt die Konzentrationen verschiedener Schadstoffe in der Luft basierend auf dem Luftqualitätsindex, wobei die Verschmutzungsniveaus von niedrig bis sehr hoch klassifiziert werden. '
        'Schadstoffkonzentrationen wie SO2, NO2, PM2.5, PM10 und O3 werden auf verschiedenen Qualitätsstufen angezeigt: \n\n'
        '1. **Erste Spalte (SO2):** Repräsentiert die Konzentration von Schwefeldioxid in der Luft in Mikrogramm pro Kubikmeter. Es gilt als hoch, wenn die Werte 1065 überschreiten.\n\n'
        '2. **Zweite Spalte (NO2):** Repräsentiert die Konzentration von Stickstoffoxid in der Luft. Es gilt als mäßig, wenn es zwischen 89-177 Mikrogramm pro Kubikmeter liegt.\n\n'
        '3. **Dritte Spalte (PM2.5):** Repräsentiert die Konzentration von feinen Partikeln (weniger als 2,5 Mikron). Die Verschmutzung ist schwerwiegend, wenn die Konzentration 71 Mikrogramm pro Kubikmeter überschreitet.\n\n'
        '4. **Vierte Spalte (PM10):** Zeigt die Konzentration von Partikeln größer als 2,5 Mikron und weniger als 10 Mikron in der Luft. Hohe Verschmutzungsniveaus werden durch Konzentrationen angezeigt, die 101 Mikrogramm pro Kubikmeter überschreiten.\n\n'
        '5. **Fünfte Spalte (O3):** Repräsentiert die Konzentration von Ozon in der Luft. Hohe Werte dieses Schadstoffs verursachen Atemwegsprobleme, insbesondere bei Menschen mit Asthma.\n\n'
        'Diese Indikatoren unterstreichen die Bedeutung präventiver Maßnahmen bei hohen Verschmutzungsniveaus und betonen die Notwendigkeit, auf Umweltindikatoren zu achten, um in einer gesünderen Umgebung zu leben.',
    air170: 'arkadaş',
    air171: 'du',

    air200: 'Pure Breath, willkommen in der App',
    quickReply1: "Wie können wir alle zum Umweltschutz beitragen?",
    quickReply2: "Warum ist die Reduzierung des Plastikverbrauchs wichtig, um die Ozeane zu schützen?",
    quickReply3: "Wie trägt Recycling zur Abfallreduzierung und zur Förderung der Kreislaufwirtschaft bei?",
    quickReply4: "Welche Rolle spielt das Pflanzen von Bäumen bei der Aufnahme von Kohlendioxid?",
    quickReply5: "Wie reduziert die Nutzung erneuerbarer Energien schädliche Emissionen?",
    quickReply6: "Warum ist Wassersparen wichtig, um natürliche Ressourcen zu erhalten?",
    quickReply7: "Wie fördert Umweltbewusstsein nachhaltiges Verhalten?",
    quickReply8: "Welche Vorteile hat der öffentliche Nahverkehr zur Reduzierung der Luftverschmutzung?",
    quickReply9: "Warum ist die Reduzierung des Stromverbrauchs wichtig für den Umweltschutz?",
    quickReply10: "Warum ist die richtige Entsorgung von Elektroschrott wichtig?",
    quickReply11: "Wie trägt die Nutzung wiederverwendbarer Materialien zur Abfallreduzierung bei?",
    quickReply12: "Warum ist der Erhalt der biologischen Vielfalt für die Nachhaltigkeit von Ökosystemen wichtig?",
    quickReply13: "Wie hilft die Reduzierung von Kohlenstoffemissionen im Kampf gegen den Klimawandel?",
    quickReply14: "Welche Auswirkungen hat das Aufforsten in städtischen Gebieten auf die Luftqualität?",
    quickReply15: "Wie trägt organische Landwirtschaft zum Schutz von Boden und Wasser bei?",
    quickReply16: "Warum ist die Reduzierung des Einsatzes von Chemikalien wichtig, um Lebewesen zu schützen?",
    quickReply17: "Welche Rolle spielt die Förderung von Gehen und Radfahren zur Verringerung der Verschmutzung?",
    quickReply18: "Wie trägt der Schutz der Wildtiere zum Gleichgewicht der Ökosysteme bei?",
    quickReply19: "Wie beeinflusst die Reduzierung des Fleischkonsums den CO2-Fußabdruck?",
    quickReply20: "Wie kann Solarenergie eine saubere Alternative zur Energieversorgung sein?",
    quickReply21: "Warum ist der Erhalt von Grünflächen wichtig für die Verbesserung der Lebensqualität?",
    quickReply22: "Wie schützt die Reduzierung von Plastiktüten die Meereslebewesen?",
    quickReply23: "Wie trägt effizientes Abfallmanagement zum Umweltschutz und zur öffentlichen Gesundheit bei?",
    quickReply24: "Wie trägt die Förderung der Wiederverwendung zur Abfallreduzierung bei?",
    quickReply25: "Warum ist der Schutz von Flüssen und Seen wichtig, um Wasserressourcen zu erhalten?",
    quickReply26: "Wie trägt saubere Technologie zur nachhaltigen Entwicklung bei?",
    quickReply27: "Warum ist die Reduzierung des Papierverbrauchs wichtig, um Wälder zu erhalten?",
    quickReply28: "Wie fördert Umweltbewusstsein die gesellschaftliche Beteiligung?",
    quickReply29: "Warum ist die Förderung von grüner Innovation wichtig, um wirksame Umweltlösungen zu bieten?",
    quickReply30: "Wie trägt saubere Luft zur Verbesserung der öffentlichen Gesundheit bei?",
    quickReply31: "Warum ist die Reduzierung des Lärms wichtig, um eine ruhige und gesunde Umgebung zu schaffen?",
    quickReply32: "Wie schützen umweltfreundliche Materialien die Natur und reduzieren die Verschmutzung?",
    quickReply33: "Warum ist der Erhalt von natürlichen Ressourcen wichtig, um die Zukunft der kommenden Generationen zu sichern?",
    quickReply34: "Warum ist die Förderung des Ökotourismus zum Schutz natürlicher Gebiete wichtig?",
    quickReply35: "Wie trägt die Reduzierung des Verbrauchs fossiler Brennstoffe zum Umweltschutz bei?",
    quickReply36: "Warum ist der Erhalt der Bodenqualität wichtig, um nachhaltige Ernten zu gewährleisten?",
    quickReply37: "Wie reduzieren Elektroautos Emissionen?",
    quickReply38: "Warum ist der Schutz von Korallenriffen für den Schutz der marinen Biodiversität wichtig?",
    quickReply39: "Warum ist die Reduzierung des Pestizideinsatzes wichtig für die Gesundheit der Lebewesen?",
    quickReply40: "Wie trägt die Förderung nachhaltiger Landwirtschaft zur Verbesserung der Umwelt bei?",
    quickReply41: "Wie trägt saubere Luft zur Verbesserung der öffentlichen Gesundheit bei?",
    quickReply42: "Warum ist die Reduzierung des Energieverbrauchs wichtig, um die Ressourceneffizienz zu steigern?",
    quickReply43: "Wie schützt saubere Energie die Umwelt?",
    quickReply44: "Warum ist der Erhalt des marinen Lebens für das ökologische Gleichgewicht wichtig?",
    quickReply45: "Warum ist die Reduzierung des Plastikverbrauchs wichtig, um die Meereslebewesen zu schützen?",
    quickReply46: "Wie trägt Recycling zum Schutz natürlicher Ressourcen bei?",
    quickReply47: "Warum ist der Umweltschutz wichtig, um die Lebensqualität für alle zu verbessern?",
    quickReply48: "Wie trägt die Reduzierung von Emissionen zur Bekämpfung der globalen Erwärmung bei?",
    quickReply49: "Warum ist die Förderung von Nachhaltigkeit wichtig, um Ressourcen für zukünftige Generationen zu erhalten?"
  };


}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  void initState() {
    _loadSavedLanguagePreference();
    _localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.EN,
        ),
        const MapLocale(
          'ar',
          AppLocale.AR,
        ),
        const MapLocale(
          'fr',
          AppLocale.FR,
        ),
        const MapLocale(
          'es',
          AppLocale.ES,
        ),
        const MapLocale(
          'ru',
          AppLocale.RU,
        ),
      ],
      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  void _loadSavedLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    if (savedLanguageCode != null) {
      _localization.translate(savedLanguageCode);
    }
  }

  void _saveLanguagePreference(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      home: const SettingsScreen(),
      theme: ThemeData(fontFamily: _localization.fontFamily),
    );
  }
}


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static String id = 'SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    super.initState();
    // تجنب الوصول إلى الويدجتات الموروثة هنا
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // إذا كنت بحاجة إلى تهيئة تعتمد على الويدجتات الموروثة، قم بها هنا
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على اتجاه النص الحالي
    TextDirection textDirection = Directionality.of(context);

    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      body: SafeArea(
        child: Column(
          children: [
            // شريط التطبيق المخصص
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      AppLocale.air200.getString(context),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // قائمة أزرار اللغات
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _languageButton('عربي', 'ar', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('English', 'en', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Français', 'fr', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Español', 'es', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Русский', 'ru', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Türkçe', 'tr', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Deutsch', 'de', Icons.language),
                      SizedBox(height: 16.h),
                      IconButton(
                        icon: Icon(Icons.home_filled),
                        onPressed: () {
                          Navigator.pop(context);
                          // التعامل مع الضغط على الإعدادات
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageButton(String languageName, String languageCode, IconData icon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.deepPurple[500],
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.5),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          languageName,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: () {
          _updateAppLanguage(languageCode);
        },
      ),
    );
  }

  void _updateAppLanguage(String languageCode) {
    setState(() {
      _localization.translate(languageCode);
    });

    // إذا كنت تستخدم إدارة حالة أخرى، تأكد من تحديثها هنا
    // مثال باستخدام Navigator:
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => const SettingsScreen()),
    // );
  }
}

class SettingsScreen2 extends StatefulWidget {
  const SettingsScreen2({super.key});
  static String id = 'SettingsScreen';

  @override
  State<SettingsScreen2> createState() => _SettingsScreen2State();
}

class _SettingsScreen2State extends State<SettingsScreen2> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // تهيئة اللغة الحالية إذا لزم الأمر
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على اتجاه النص الحالي
    TextDirection textDirection = Directionality.of(context);

    return Scaffold(
      // خلفية ثابتة بلون deepPurple[700]
      backgroundColor: Colors.deepPurple[700],
      body: SafeArea(
        child: Column(
          children: [
            // شريط التطبيق المخصص
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start, // ضبط محاذاة العناصر عموديًا
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      AppLocale.air200.getString(context),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      maxLines: 2, // السماح بسطرين
                      overflow: TextOverflow.ellipsis, // إظهار النقاط عند تجاوز النص
                    ),
                  ),
                ],
              ),
            ),
            // قائمة أزرار اللغات
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _languageButton('عربي', 'ar', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('English', 'en', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Français', 'fr', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Español', 'es', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Русский', 'ru', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Türkçe', 'tr', Icons.language),
                      SizedBox(height: 16.h),
                      _languageButton('Deutsch', 'de', Icons.language),
                      SizedBox(height: 16.h),
                      IconButton(
                        icon: Icon(Icons.home_filled),
                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CombinedQualityScreen()),
                          );                          // التعامل مع الضغط على الإعدادات
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageButton(String languageName, String languageCode, IconData icon) {
    return GestureDetector(
      onTap: () {
        _updateAppLanguage(languageCode);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurple[500],
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.5),
              blurRadius: 10.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20.sp,
          ),
          label: Text(
            languageName,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: () {
            _updateAppLanguage(languageCode);
          },
        ),
      ),
    );
  }

  void _updateAppLanguage(String languageCode) {
    // تحديث اللغة
    _localization.translate(languageCode);

    // إعادة بناء التطبيق مع التحديث الجديد
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );

    // تحديث الصفحات الأخرى إذا لزم الأمر
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
    secondPageKey.currentState?.updateLanguage();
    additionalPageKey.currentState?.updateLanguage();
  }
}