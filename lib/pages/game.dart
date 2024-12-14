import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomeGame extends StatelessWidget {
  const HomeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<CleanAirGame>(
      game: CleanAirGame(),
      overlayBuilderMap: {
        'GameOver': (BuildContext context, CleanAirGame game) {
          return GameOverOverlay(score: game.score, onRestart: () {
            game.reset();
          });
        },
        'Pause': (BuildContext context, CleanAirGame game) {
          return PauseOverlay(onResume: game.resume, onRestart: game.reset);
        },
      },
      initialActiveOverlays: const [],
    );
  }
}

class CleanAirGame extends FlameGame with TapDetector {
  late SpriteComponent airPurifier;
  late TextComponent scoreText;
  late TextComponent timeText;
  late TextComponent levelText;
  late ProgressBarComponent progressBar;
  int score = 0;
  double gameTime = 30.0;
  int level = 1;
  double pollutionRate = 1.0; // معدل ظهور الملوثات
  List<Pollutant> pollutants = [];
  List<PowerUp> powerUps = [];
  Random random = Random();
  bool isPaused = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final backgroundSprite = await loadSprite('p2.png');
    add(SpriteComponent()
      ..sprite = backgroundSprite
      ..size = size);

    airPurifier = SpriteComponent()
      ..sprite = await loadSprite('p3.png')
      ..size = Vector2(100, 100)
      ..position = Vector2(size.x / 2 - 50, size.y - 120);
    add(airPurifier);

    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, 10),
      textRenderer: TextPaint(style: TextStyle(color: Colors.white, fontSize: 24)),
    );
    add(scoreText);

    timeText = TextComponent(
      text: 'Time: 30.0',
      position: Vector2(size.x - 150, 10),
      textRenderer: TextPaint(style: TextStyle(color: Colors.white, fontSize: 24)),
    );
    add(timeText);

    levelText = TextComponent(
      text: 'Level: 1',
      position: Vector2(size.x / 2 - 50, 50),
      textRenderer: TextPaint(style: TextStyle(color: Colors.white, fontSize: 24)),
    );
    add(levelText);

    progressBar = ProgressBarComponent();
    add(progressBar);

    // إضافة الملوثات والأدوات المساعدة في البداية
    for (int i = 0; i < 10; i++) {
      addPollutant();
    }


  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isPaused) return;

    gameTime -= dt;
    if (gameTime <= 0) {
      gameTime = 0;
      overlays.add('GameOver');
      pauseEngine();
    }

    scoreText.text = 'Score: $score';
    timeText.text = 'Time: ${gameTime.toStringAsFixed(1)}';
    levelText.text = 'Level: $level';

    progressBar.updateProgress(score / 100);

    // تحديث الملوثات
    for (var pollutant in pollutants) {
      pollutant.update(dt);
    }

    // زيادة مستوى اللعبة بناءً على النقاط
    if (score > 100 * level) {
      level++;
      pollutionRate *= 1.2; // زيادة معدل ظهور الملوثات
      for (int i = 0; i < 5; i++) {
        addPollutant();
      }
    }

    // تحديث الأدوات المساعدة
    for (var powerUp in powerUps) {
      powerUp.update(dt);
    }

    // إضافة ملوثات جديدة بناءً على معدل الملوثات
    if (random.nextDouble() < pollutionRate * dt) {
      addPollutant();
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (isPaused) return;

    Vector2 tapPosition = info.eventPosition.global;

    // بحث عن الملوثات التي تم النقر عليها
    for (var pollutant in List<Pollutant>.from(pollutants)) {
      if (pollutant.toRect().contains(tapPosition.toOffset())) {
        pollutants.remove(pollutant);
        remove(pollutant);
        score++;
        addPollutant();
        break;
      }
    }

    // بحث عن الأدوات المساعدة التي تم النقر عليها
    for (var powerUp in List<PowerUp>.from(powerUps)) {
      if (powerUp.toRect().contains(tapPosition.toOffset())) {
        powerUps.remove(powerUp);
        remove(powerUp);
        applyPowerUp(powerUp);
        break;
      }
    }
  }

  void addPollutant() {
    double x = random.nextDouble() * (size.x - 50);
    double y = random.nextDouble() * (size.y / 2);
    Pollutant newPollutant = Pollutant(position: Vector2(x, y));
    pollutants.add(newPollutant);
    add(newPollutant);
  }

  void addPowerUp() {
    double x = random.nextDouble() * (size.x - 50);
    double y = random.nextDouble() * (size.y / 2);
    PowerUp powerUp = PowerUp(position: Vector2(x, y));
    powerUps.add(powerUp);
    add(powerUp);
  }

  void applyPowerUp(PowerUp powerUp) {
    // تأثير الأدوات المساعدة (على سبيل المثال، زيادة الوقت)
    gameTime += 5.0;
  }

  void reset() {
    score = 0;
    gameTime = 30.0;
    level = 1;
    pollutionRate = 1.0;
    pollutants.clear();
    powerUps.clear();
    for (int i = 0; i < 10; i++) {
      addPollutant();
    }
    resumeEngine();
    overlays.remove('GameOver');
  }

  void pause() {
    isPaused = true;
    overlays.add('Pause');
  }

  void resume() {
    isPaused = false;
    overlays.remove('Pause');
  }
}

class Pollutant extends SpriteComponent with HasGameRef<CleanAirGame> {
  double speed = 100.0;

  Pollutant({required Vector2 position})
      : super(position: position, size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('p1.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
  }

  void increaseSpeed(double factor) {
    speed *= factor;
  }
}

class PowerUp extends SpriteComponent with HasGameRef<CleanAirGame> {
  PowerUp({required Vector2 position})
      : super(position: position, size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('powerup.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}

class ProgressBarComponent extends PositionComponent {
  double progress = 0.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  void updateProgress(double newProgress) {
    progress = newProgress.clamp(0.0, 1.0);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.green;
    canvas.drawRect(Rect.fromLTWH(10, 70, 200, 20), paint);
    final progressPaint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(10, 70, 200 * progress, 20), progressPaint);
  }
}

class GameOverOverlay extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const GameOverOverlay({required this.score, required this.onRestart, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Game Over',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your Score: $score',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: onRestart,
              child: Text(
                'Restart',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PauseOverlay extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onRestart;

  const PauseOverlay({required this.onResume, required this.onRestart, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Game Paused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onResume,
              child: Text(
                'Resume',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              child: Text(
                'Restart',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
