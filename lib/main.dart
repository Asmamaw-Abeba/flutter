import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SnakeGameApp());
}

class SnakeGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnakeGame(),
    );
  }
}

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> with TickerProviderStateMixin {
  List<Offset> snake = [Offset(100, 100)];
  Offset food = Offset(200, 200);
  int direction = 0; // 0: Right, 1: Left, 2: Down, 3: Up
  int score = 0;
  int highScore = 0;
  bool gameOver = false;
  bool isPaused = false;
  bool isFullScreen = false;
  double speedFactor = 1.0; // Speed multiplier (1.0 = normal, < 1 = slower)
  late FocusNode _focusNode;
  late Ticker _ticker;
  Duration _tickRate = Duration(milliseconds: 200); // Set speed to 200ms
  Duration _lastElapsed = Duration.zero;

  int speedLevel = 1; // 1: Slow, 2: Medium, 3: Fast

  double _screenWidth = 640;
  double _screenHeight = 480;
  double _gridSize = 10;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus(); // Request focus after the widget tree is built
    });
    _ticker = Ticker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    if (gameOver || isPaused) return;

    Duration adjustedTickRate = Duration(
        milliseconds: (_tickRate.inMilliseconds / speedFactor).round());

    if (elapsed - _lastElapsed >= _tickRate) {
      _lastElapsed = elapsed;

      setState(() {
        _moveSnake();
        _checkCollisions();
        _checkFoodCollision();
      });
    }
  }

  void _moveSnake() {
    List<Offset> newSnake = List.from(snake);
    for (int i = newSnake.length - 1; i > 0; i--) {
      newSnake[i] = newSnake[i - 1];
    }
    if (direction == 0) {
      // Moving Right
      newSnake[0] = Offset(newSnake[0].dx + _gridSize, newSnake[0].dy);
    } else if (direction == 1) {
      // Moving Left
      newSnake[0] = Offset(newSnake[0].dx - _gridSize, newSnake[0].dy);
    } else if (direction == 2) {
      // Moving Down
      newSnake[0] = Offset(newSnake[0].dx, newSnake[0].dy + _gridSize);
    } else if (direction == 3) {
      // Moving Up
      newSnake[0] = Offset(newSnake[0].dx, newSnake[0].dy - _gridSize);
    }

    snake = newSnake;
  }

  void _checkCollisions() {
    // Check collision with walls
    if (snake[0].dx < 0 ||
        snake[0].dy < 0 ||
        snake[0].dx >= _screenWidth * 0.8 - _gridSize ||
        snake[0].dy >= _screenHeight * 0.6 - _gridSize) {
      _gameOver();
    }

    // Check collision with itself
    for (int i = 1; i < snake.length; i++) {
      if (snake[0] == snake[i]) {
        _gameOver();
      }
    }
  }

  void _checkFoodCollision() {
    if ((snake[0].dx - food.dx).abs() < _gridSize &&
        (snake[0].dy - food.dy).abs() < _gridSize) {
      setState(() {
        score++;
        _spawnFood();
        _growSnake();
      });
    }
  }

  void _spawnFood() {
    Random random = Random();

    // Ensure food stays inside the game area grid
    double foodX = random.nextInt((_screenWidth * 0.8 / _gridSize).floor()) *
        _gridSize.toDouble();
    double foodY = random.nextInt((_screenHeight * 0.6 / _gridSize).floor()) *
        _gridSize.toDouble();

    // Ensure food is within the game area
    if (foodX >= (_screenWidth * 0.8 - _gridSize)) {
      foodX = _screenWidth * 0.8 - _gridSize;
    }
    if (foodY >= (_screenHeight * 0.6 - _gridSize)) {
      foodY = _screenHeight * 0.6 - _gridSize;
    }

    food = Offset(foodX, foodY);
  }

  void _growSnake() {
    snake.add(snake.last);
  }

  void _gameOver() {
    setState(() {
      gameOver = true;
      if (score > highScore) {
        highScore = score;
      }
    });
  }

  // Control Snake direction with arrow keys
  void _onKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft && direction != 0) {
        direction = 1;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
          direction != 1) {
        direction = 0;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
          direction != 3) {
        direction = 2;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
          direction != 2) {
        direction = 3;
      }
    }
  }

  void _toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  void _pauseGame() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void _restartGame() {
    setState(() {
      snake = [Offset(100, 100)];
      food = Offset(200, 200);
      score = 0;
      gameOver = false;
    });
  }

  void _changeSpeed() {
    setState(() {
      speedLevel =
          (speedLevel % 3) + 1; // Cycle between 1 (Slow), 2 (Medium), 3 (Fast)

      // Adjust _tickRate based on speedLevel
      if (speedLevel == 1) {
        _tickRate = Duration(milliseconds: 300); // Slow
      } else if (speedLevel == 2) {
        _tickRate = Duration(milliseconds: 200); // Medium
      } else if (speedLevel == 3) {
        _tickRate = Duration(milliseconds: 100); // Fast
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return KeyboardListener(
      focusNode: _focusNode, // Use the persistent FocusNode
      onKeyEvent: _onKey, // Listen for key events
      child: GestureDetector(
        onTap: () {
          if (gameOver) {
            _restartGame();
          }
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 19, 19, 19),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // // Add the new logo image at the top
                // Image.asset(
                //   'assets/icons/app_icon.png', // Path to your new logo
                //   width: 100, // Adjust size as needed
                //   height: 100, // Adjust size as needed
                // ),
                // Boundary above gestures
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(5),
                  child: CustomPaint(
                    size: Size(_screenWidth * 0.8, _screenHeight * 0.6),
                    painter: SnakePainter(snake, food, score, highScore),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Score: $score",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                if (gameOver) ...[
                  Text("Game Over! Tap to Restart",
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "High Score: $highScore",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Directional Controller (D-pad)
                    SizedBox(height: 20),
                    if (!gameOver)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_upward,
                                    color: Colors.white),
                                onPressed: () {
                                  if (direction != 2) direction = 3; // Up
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () {
                                  if (direction != 0) direction = 1; // Left
                                },
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                icon: Icon(Icons.arrow_forward,
                                    color: Colors.white),
                                onPressed: () {
                                  if (direction != 1) direction = 0; // Right
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_downward,
                                    color: Colors.white),
                                onPressed: () {
                                  if (direction != 3) direction = 2; // Down
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    IconButton(
                      icon: Icon(Icons.fullscreen),
                      onPressed: _toggleFullScreen,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: _pauseGame,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(Icons.speed),
                      onPressed: _changeSpeed,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Speed: ${speedLevel == 1 ? "Slow" : speedLevel == 2 ? "Medium" : "Fast"}",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  final List<Offset> snake;
  final Offset food;
  final int score;
  final int highScore;

  SnakePainter(this.snake, this.food, this.score, this.highScore);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Draw snake
    for (var segment in snake) {
      canvas.drawRect(Rect.fromLTWH(segment.dx, segment.dy, 10, 10), paint);
    }

    // Draw food
    paint.color = Colors.red;
    canvas.drawRect(Rect.fromLTWH(food.dx, food.dy, 10, 10), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
