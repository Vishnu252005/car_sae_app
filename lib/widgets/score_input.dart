import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/team.dart';

class ScoreInput extends StatefulWidget {
  final TeamWithId team;
  final int numJudges;
  final int maxScore;

  const ScoreInput({
    Key? key,
    required this.team,
    required this.numJudges,
    this.maxScore = 100,
  }) : super(key: key);

  @override
  _ScoreInputState createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing scores or empty controllers
    _controllers = List.generate(
      widget.numJudges,
      (index) => TextEditingController(
        text: index < widget.team.scores.length 
            ? widget.team.scores[index].toString() 
            : '',
      ),
    );
  }

  void _updateScores() {
    widget.team.scores = _controllers
        .map((controller) => 
            double.tryParse(controller.text) ?? 0.0)
        .toList();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Judge Scores',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.numJudges,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllers[index],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Judge ${index + 1}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
                  ),
                  onChanged: (value) {
                    // Validate input and ensure it does not exceed maxScore
                    double? score = double.tryParse(value);
                    if (score != null) {
                      if (score > widget.maxScore) {
                        // Reset the score to maxScore
                        score = widget.maxScore.toDouble();
                        _controllers[index].text = score.toString();
                        // Show a message indicating the reset
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Score reset to ${widget.maxScore}')),
                        );
                      }
                    }
                    _updateScores();
                  },
                ),
              );
            },
          ),
          if (widget.team.scores.isNotEmpty) ...[
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Score:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
                Text(
                  widget.team.totalScore.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
