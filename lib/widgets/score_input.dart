import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/team.dart';

class ScoreInput extends StatefulWidget {
  final Team team;
  final int numJudges;

  const ScoreInput({
    Key? key,
    required this.team,
    required this.numJudges,
  }) : super(key: key);

  @override
  _ScoreInputState createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each judge
    for (int i = 0; i < widget.numJudges; i++) {
      final score = i < widget.team.scores.length ? widget.team.scores[i] : 0.0;
      _controllers.add(TextEditingController(text: score > 0 ? score.toString() : ''));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleScoreChange(String value, int index) {
    if (value.isEmpty) {
      setState(() {
        if (widget.team.scores.length <= index) {
          widget.team.scores.add(0.0);
        } else {
          widget.team.scores[index] = 0.0;
        }
      });
      return;
    }

    double? score = double.tryParse(value);
    if (score != null) {
      if (score > 100) {
        setState(() {
          if (widget.team.scores.length <= index) {
            widget.team.scores.add(100.0);
          } else {
            widget.team.scores[index] = 100.0;
          }
          _controllers[index].text = '100';
          _controllers[index].selection = TextSelection.fromPosition(
            TextPosition(offset: '100'.length),
          );
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Maximum score is 100'),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        setState(() {
          if (widget.team.scores.length <= index) {
            widget.team.scores.add(score);
          } else {
            widget.team.scores[index] = score;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Judge Scores',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ...List.generate(widget.numJudges, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: TextFormField(
                controller: _controllers[index],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: 'Judge ${index + 1} Score',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.score),
                  helperText: 'Score must be between 0 and 100',
                ),
                onChanged: (value) => _handleScoreChange(value, index),
              ),
            );
          }),
        ],
      ),
    );
  }
}
