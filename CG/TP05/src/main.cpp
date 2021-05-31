#include <stdio.h>

#include "point.hpp"
#include "uniformrealdist.hpp"

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>

float alfa = 0.0f, beta = 0.5f, radius = 100.0f;
float camX, camY, camZ;

void spherical2Cartesian() {

  camX = radius * cos(beta) * sin(alfa);
  camY = radius * sin(beta);
  camZ = radius * cos(beta) * cos(alfa);
}

void changeSize(int w, int h) {

  // Prevent a divide by zero, when window is too short
  // (you cant make a window with zero width).
  if (h == 0)
    h = 1;

  // compute window's aspect ratio
  float ratio = w * 1.0 / h;

  // Set the projection matrix as current
  glMatrixMode(GL_PROJECTION);
  // Load Identity Matrix
  glLoadIdentity();

  // Set the viewport to be the entire window
  glViewport(0, 0, w, h);

  // Set perspective
  gluPerspective(45.0f, ratio, 1.0f, 1000.0f);

  // return to the model view matrix mode
  glMatrixMode(GL_MODELVIEW);
}

std::vector<Point> generate_trees(int number, float min_dist,
                                  float plane_size) {
  std::vector<Point> points;
  auto static const rng =
      UniformRealDist<float>(-plane_size / 2, plane_size / 2);
  for (int i = 0; i < number; i++) {
    float x, z;
    do {
      x = rng();
      z = rng();
    } while (std::sqrt(x * x + z * z) < min_dist);

    points.emplace_back(x, 0, z);
  }
  return points;
}

void draw_tree(Point p) {
  glPushMatrix();
  glTranslatef(p.x(), 0, p.z());
  glColor3f(0.41f, 0.21f, 0.07f);
  glRotatef(-90, 1, 0, 0);
  glutSolidCone(0.25, 4, 10, 10);
  glColor3f(0.04, 0.398, 0.137);
  glTranslatef(0, 0, 1);
  glutSolidCone(1.5, 3, 10, 10);
  glPopMatrix();
}

void draw_cowboys(int n_cowboys, float radius) {
  static float _alpha = 0.0;
  const float delta = (2 * M_PI) / n_cowboys;
  float alpha = _alpha;
  glColor3f(0, 0, 1);
  for (int i = 0; i < n_cowboys; i++) {
    float x = radius * sin(alpha);
    float z = radius * cos(alpha);
    glPushMatrix();
    glTranslatef(x, 0.8, z);
    glRotatef((alpha / M_PI) * 180 - 90, 0, 1, 0);
    glutSolidTeapot(1);
    glPopMatrix();
    alpha += delta;
    if (alpha > (2 * M_PI))
      alpha -= (2 * M_PI);
  }
  _alpha -= 0.01;
  if (_alpha > (2 * M_PI))
    _alpha -= (2 * M_PI);
}

void draw_indians(int n_indians, float radius) {
  static float _alpha = 0.0;
  const float delta = (2 * M_PI) / n_indians;
  float alpha = _alpha;
  glColor3f(1, 0, 0);
  for (int i = 0; i < n_indians; i++) {
    float x = radius * sin(alpha);
    float z = radius * cos(alpha);
    glPushMatrix();
    glTranslatef(x, 0.8, z);
    glRotatef((alpha / M_PI) * 180, 0, 1, 0);
    glutSolidTeapot(1);
    glPopMatrix();
    alpha += delta;
    if (alpha > (2 * M_PI))
      alpha -= (2 * M_PI);
  }
  _alpha += 0.01;
  if (_alpha > (2 * M_PI))
    _alpha -= (2 * M_PI);
}

void renderScene(void) {

  // clear buffers
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  // set the camera
  glLoadIdentity();
  gluLookAt(camX, camY, camZ, 0.0, 0.0, 0.0, 0.0f, 1.0f, 0.0f);

  glColor3f(0.2f, 0.8f, 0.2f);
  glBegin(GL_TRIANGLES);
  glVertex3f(100.0f, 0, -100.0f);
  glVertex3f(-100.0f, 0, -100.0f);
  glVertex3f(-100.0f, 0, 100.0f);

  glVertex3f(100.0f, 0, -100.0f);
  glVertex3f(-100.0f, 0, 100.0f);
  glVertex3f(100.0f, 0, 100.0f);
  glEnd();

  static auto tree_pos = generate_trees(1000, 50, 200);
  for (auto const &p : tree_pos)
    draw_tree(p);
  draw_indians(16, 35);
  draw_cowboys(8, 15);

  glColor3f(1, 0, .498);
  glutSolidTorus(0.5, 1.6, 10, 10);

  glutSwapBuffers();
}

void processKeys(unsigned char c, int xx, int yy) {

  // put code to process regular keys in here
}

void processSpecialKeys(int key, int xx, int yy) {

  switch (key) {

  case GLUT_KEY_RIGHT:
    alfa -= 0.1;
    break;

  case GLUT_KEY_LEFT:
    alfa += 0.1;
    break;

  case GLUT_KEY_UP:
    beta += 0.1f;
    if (beta > 1.5f)
      beta = 1.5f;
    break;

  case GLUT_KEY_DOWN:
    beta -= 0.1f;
    if (beta < -1.5f)
      beta = -1.5f;
    break;

  case GLUT_KEY_PAGE_DOWN:
    radius -= 1.0f;
    if (radius < 1.0f)
      radius = 1.0f;
    break;

  case GLUT_KEY_PAGE_UP:
    radius += 1.0f;
    break;
  }
  spherical2Cartesian();
  glutPostRedisplay();
}

void printInfo() {

  printf("Vendor: %s\n", glGetString(GL_VENDOR));
  printf("Renderer: %s\n", glGetString(GL_RENDERER));
  printf("Version: %s\n", glGetString(GL_VERSION));

  printf("\nUse Arrows to move the camera up/down and left/right\n");
  printf("Home and End control the distance from the camera to the origin");
}

int main(int argc, char **argv) {

  // init GLUT and the window
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);
  glutInitWindowPosition(100, 100);
  glutInitWindowSize(800, 800);
  glutCreateWindow("CG@DI-UM");

  // Required callback registry
  glutDisplayFunc(renderScene);
  glutReshapeFunc(changeSize);

  // Callback registration for keyboard processing
  glutKeyboardFunc(processKeys);
  glutSpecialFunc(processSpecialKeys);
  glutIdleFunc(renderScene);

  //  OpenGL settings
  glEnable(GL_DEPTH_TEST);
  // glEnable(GL_CULL_FACE);

  spherical2Cartesian();

  printInfo();

  // enter GLUT's main cycle
  glutMainLoop();

  return 1;
}
