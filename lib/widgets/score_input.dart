import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/team.dart';

class ScoreInput extends StatefulWidget {
  final Team team;

  ScoreInput({required this.team});

  @override
  _ScoreInputState createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current scores
    for (int i = 0; i < 3; i++) {
      _controllers.add(TextEditingController(
        text: widget.team.scores[i] > 0 ? widget.team.scores[i].toString() : '',
      ));
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
        widget.team.scores[index] = 0;
      });
      return;
    }

    int? score = int.tryParse(value);
    if (score != null) {
      if (score > 100) {
        setState(() {
          widget.team.scores[index] = 100;
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
            backgroundColor: Colors.blue.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } else {
        setState(() {
          widget.team.scores[index] = score;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 12),
          for (int i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: Text(
                      'Judge ${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _controllers[i],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: (value) => _handleScoreChange(value, i),
                      decoration: InputDecoration(
                        hintText: '0-100',
                        errorText: null,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue.shade200,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue.shade200,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        suffixIcon: Tooltip(
                          message: 'Score must be between 0 and 100',
                          child: Icon(
                            Icons.score,
                            color: Colors.blue.shade300,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300),
        ],
      ),
    );
  }
}
