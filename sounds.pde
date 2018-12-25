import processing.sound.*;

PImage img;

int x = 0;
int time;
int timeDelta = 15; // milliseconds

SinOsc[] oscillators;

float logFreqStart = 2;
float logFreqEnd = 4;

void setup() {
  img = loadImage("message.png");
  img.resize(0, 400);
  img.loadPixels();
  oscillators = new SinOsc[img.height];
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i] = new SinOsc(this);
    oscillators[i].freq(pow(10, logFreqStart + i * (logFreqEnd - logFreqStart) / oscillators.length));
    oscillators[i].play();
  }
  time = millis();
}

void draw() {
  if (x >= img.width - 1) {
    exit();
  }

  if (millis() - time >= timeDelta) {
    for (int i = 0; i < oscillators.length; i++) {
      float newAmp = (255.0 - brightness(img.pixels[i * img.width + x])) / 255.0;
      if (newAmp < 0.1) {
        oscillators[i].stop();
      } else {
        oscillators[i].amp(newAmp);
        oscillators[i].play();
      }
    }
    time = millis();
    x++;
  }
}
