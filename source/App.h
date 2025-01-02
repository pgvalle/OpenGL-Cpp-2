#pragma once

#include "common.h"
#include <GLFW/glfw3.h>

struct Mouse
{
  GLFWwindow *window;                     // READ-ONLY
  i8 buttons[GLFW_MOUSE_BUTTON_LAST + 1]; // READ-ONLY
  i32 x, y, dx, dy, scroll;               // READ-ONLY
};

struct Keyboard
{
  GLFWwindow *window;         // READ-ONLY
  i8 keys[GLFW_KEY_LAST + 1]; // READ-ONLY
};

struct App
{
  GLFWwindow *window;
  Mouse mouse;       // READ-ONLY
  Keyboard keyboard; // READ-ONLY

  uint64_t ticks, frames; // READ-ONLY
  u8 target_tps, target_fps;

  App(const char *title, i32 ww, i32 wh);
  ~App();

  void setvsync(bool vsync);
};