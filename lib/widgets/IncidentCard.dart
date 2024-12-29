import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/IncidentDetailScreen.dart';

class IncidentCard extends StatelessWidget {
  final Map<String, String> report;

  const IncidentCard({required this.report, super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(report['date']!);
    final formattedDate = DateFormat('dd MMMM yyyy').format(date);
    final formattedTime = DateFormat('HH:mm').format(date);
    final displayDateTime = _getDisplayDateTime(date, formattedDate, formattedTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(formattedDate, formattedTime, displayDateTime),
          const SizedBox(height: 4),
          _buildLocationSection(),
          const SizedBox(height: 4),
          Text(report['subtitle']!, style: _subtitleStyle),
          const SizedBox(height: 10),
          _buildAttachmentSection(),
          const SizedBox(height: 10),
          _buildActionButton(context),
        ],
      ),
    );
  }

  String _getDisplayDateTime(DateTime date, String formattedDate, String formattedTime) {
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      return formattedTime;
    } else {
      return '$formattedDate, $formattedTime';
    }
  }

  Widget _buildTitleSection(String formattedDate, String formattedTime, String displayDateTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            report['title']!,
            style: _titleStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          displayDateTime,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.location_solid,
            color: Colors.black,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            report['location']!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lampiran', style: _titleStyle),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    report['file']!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.remove_red_eye, size: 20, color: Colors.grey),
                    SizedBox(width: 15),
                    Icon(Icons.download, size: 20, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IncidentDetailScreen(
                report: report,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text('Beri Tindakan', style: _buttonStyle),
      ),
    );
  }

  TextStyle get _titleStyle => const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
      );

  TextStyle get _subtitleStyle => const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      );

  TextStyle get _buttonStyle => const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
      );
}
