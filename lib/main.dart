import 'package:flutter/material.dart';

const padding = 32.0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(padding),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;
  var position = 0.0;
  static const _duration = Duration(seconds: 1);
  bool isEnableMoveRight = true;
  bool isEnableMoveLeft = true;

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width - (padding * 2);

    return Column(
      children: [
        Container(
          height: _squareSize,
          width: mediaQueryWidth,
          child: Stack(children: [
            AnimatedPositioned(
              right:
                  !(isEnableMoveRight && isEnableMoveLeft) //isAnyButtonPressed
                      ? position
                      : (mediaQueryWidth - _squareSize) / 2,
              curve: Curves.fastOutSlowIn,
              duration: _duration,
              child: Container(
                width: _squareSize,
                height: _squareSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(),
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: isEnableMoveRight
                  ? () => setState(() {
                        position = 0.0;

                        isEnableMoveLeft = isEnableMoveRight = false;
                        Future.delayed(_duration, () {
                          setState(() {
                            isEnableMoveLeft = true;
                          });
                        });
                      })
                  : null,
              child: const Text('Right'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: isEnableMoveLeft
                  ? () => setState(() {
                        position = mediaQueryWidth - _squareSize;

                        isEnableMoveLeft = isEnableMoveRight = false;
                        Future.delayed(_duration, () {
                          setState(() {
                            isEnableMoveRight = true;
                          });
                        });
                      })
                  : null,
              child: const Text('Left'),
            ),
          ],
        ),
      ],
    );
  }
}
