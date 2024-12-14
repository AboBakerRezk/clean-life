


import 'package:flutter/material.dart';

class AirPollutantsPage extends StatefulWidget {
  @override
  _AirPollutantsPageState createState() => _AirPollutantsPageState();
}

class _AirPollutantsPageState extends State<AirPollutantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Pollutants and Their Concentrations', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple[700],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Add a title for pollutants and their concentrations
          Text(
            'Pollutants and Their Concentrations According to the Air Quality Index:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          _buildAirQualityTable(),
          SizedBox(height: 20),

          // Add an explanation for the health effects of pollutants
          Text(
            'How Do Pollutants Affect Our Health?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          _buildPollutantImpactDescription(),
          SizedBox(height: 20),

          // Add a detailed explanation for the table
          Text(
            'Table Explanation:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          _buildTableExplanation(),
        ],
      ),
    );
  }

  // Build the table containing pollutants and their concentrations
  Widget _buildAirQualityTable() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Colors.purple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Air Quality Table Based on Concentrations:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 10),
            _buildTableHeader(),
            SizedBox(height: 10),
            _buildTableRow('Low', '1', '0-88', '0-67', '0-11', '0-16', '0-33'),
            _buildTableRow('Low', '2', '89-177', '68-134', '12-23', '17-33', '34-66'),
            _buildTableRow('Low', '3', '178-266', '135-200', '24-35', '34-50', '67-100'),
            _buildTableRow('Moderate', '4', '267-354', '201-267', '36-41', '52-58', '101-120'),
            _buildTableRow('Moderate', '5', '355-443', '268-334', '42-47', '59-66', '121-140'),
            _buildTableRow('Moderate', '6', '444-532', '335-400', '48-53', '67-75', '141-160'),
            _buildTableRow('High', '7', '533-710', '401-467', '54-58', '76-83', '161-187'),
            _buildTableRow('High', '8', '711-887', '468-534', '59-64', '84-91', '188-213'),
            _buildTableRow('High', '9', '888-1064', '535-600', '65-70', '92-100', '214-240'),
            _buildTableRow('Very High', '10', '⩾1065', '⩾601', '⩾71', '⩾101', '⩾241'),
          ],
        ),
      ),
    );
  }

  // Build the table header
  Widget _buildTableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTableHeaderCell('SO2'),
        _buildTableHeaderCell('NO2'),
        _buildTableHeaderCell('PM2.5'),
        _buildTableHeaderCell('PM10'),
        _buildTableHeaderCell('O3'),
      ],
    );
  }

  // Build the table header cell
  Widget _buildTableHeaderCell(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
    );
  }

  // Build a row in the table
  Widget _buildTableRow(String quality, String index, String so2, String no2, String pm25, String pm10, String o3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(quality),
        Text(index),
        Text(so2),
        Text(no2),
        Text(pm25),
        Text(pm10),
        Text(o3),
      ],
    );
  }

  // Add explanation for the impact of pollutants
  Widget _buildPollutantImpactDescription() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Colors.purple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Air pollutants such as PM2.5, PM10, NO2, and SO2 can cause various health issues, such as breathing difficulties, allergies, and heart diseases. '
              'The risk increases when people are exposed to high concentrations of these pollutants. For instance, high concentrations of PM2.5 can lead to a decline in lung function and increase the risk of lung cancer. '
              'On the other hand, high concentrations of ozone (O3) can cause respiratory irritation and increase the chances of respiratory diseases such as asthma. '
              'Here are detailed descriptions of each pollutant and its effects on health: \n\n'
              '1. **SO2 (Sulfur Dioxide):** This pollutant causes irritation in the eyes, nose, and throat and can worsen respiratory diseases such as bronchitis and asthma. '
              'Long-term exposure may lead to chronic heart diseases and lung dysfunction. High concentrations of SO2 are extremely dangerous for people with chronic respiratory diseases.\n\n'
              '2. **NO2 (Nitrogen Dioxide):** This pollutant causes irritation in the lungs and can exacerbate breathing problems like asthma and bronchitis. '
              'Long-term exposure to NO2 increases the risk of heart diseases and strokes, as well as makes the body more susceptible to respiratory infections.\n\n'
              '3. **PM2.5 (Fine Particulate Matter):** Particles that are 2.5 microns or smaller can enter the deep respiratory passages and reach the lungs. '
              'These particles cause serious health problems including increased cases of asthma, chronic bronchitis, lung function deterioration, and an increased risk of lung cancer and heart disease.\n\n'
              '4. **PM10 (Coarse Particulate Matter):** These particles are larger than PM2.5 but still capable of causing similar health issues, especially in individuals with asthma or heart diseases.\n\n'
              '5. **O3 (Ozone):** Ozone can cause irritation in the respiratory system, leading to shortness of breath and bronchitis. It also increases the risk of chronic respiratory diseases such as asthma. '
              'Continuous exposure to high ozone levels can also reduce the lungs’ ability to absorb oxygen.\n\n'
              'We need to be cautious about air pollution, especially in busy urban areas where pollution levels are higher. It is important to use air quality monitoring devices indoors and avoid polluted areas during peak hours. '
              'Environmental awareness and air quality monitoring contribute to better public health and environmental protection.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  // Add a detailed explanation for the table
  Widget _buildTableExplanation() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Colors.purple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'The table above shows the concentrations of various pollutants in the air according to the Air Quality Index, where pollution is classified from low to very high levels. '
              'The concentrations of pollutants such as SO2, NO2, PM2.5, PM10, and O3 are displayed at different quality levels: \n\n'
              '1. **Column 1 (SO2):** Represents the concentration of sulfur dioxide in the air in micrograms per cubic meter. It is considered high when the concentration exceeds 1065.\n\n'
              '2. **Column 2 (NO2):** Represents the concentration of nitrogen dioxide in the air. It is considered moderate when the concentration is between 89-177 micrograms per cubic meter.\n\n'
              '3. **Column 3 (PM2.5):** Represents the concentration of fine particulate matter (less than 2.5 microns). Pollution is considered severe when the concentration exceeds 71 micrograms per cubic meter.\n\n'
              '4. **Column 4 (PM10):** Shows the concentration of particles larger than 2.5 microns but smaller than 10 microns. High pollution levels appear when the concentration exceeds 101 micrograms per cubic meter.\n\n'
              '5. **Column 5 (O3):** Represents the concentration of ozone in the air. High values of this pollutant cause respiratory health problems, particularly for people suffering from asthma.\n\n'
              'These indicators emphasize the importance of taking preventive measures when pollution levels are high and encourage paying attention to environmental indicators for living in a healthier environment.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
