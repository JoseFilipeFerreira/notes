#include "point.hpp"

#include <stdlib.h>
#define _USE_MATH_DEFINES
#include <vector>
#include <utility>

#ifdef __APPLE__
#    include <GLUT/glut.h>
#else
#    include <GL/glut.h>
#endif

float camX = 0, camY, camZ = 5;
int startX, startY, tracking = 0;

int alpha = 0, beta = 0, r = 5;

#define POINT_COUNT 4
Point POINTS[POINT_COUNT] = {
    Point(1, -1, 0), Point(-1, 1, 0), Point(1, 1, 0), Point(0, 0, 0)};
float TIME = 10;

auto buildRotMatrix(Vector x, Vector y, Vector z) -> std::vector<float> {
    std::vector<float> v;
    v.push_back(x.x());
    v.push_back(x.y());
    v.push_back(x.z());
    v.push_back(0);
    v.push_back(y.x());
    v.push_back(y.y());
    v.push_back(y.z());
    v.push_back(0);
    v.push_back(z.x());
    v.push_back(z.y());
    v.push_back(z.z());
    v.push_back(0);
    v.push_back(0);
    v.push_back(0);
    v.push_back(0);
    v.push_back(1);
    return v;
}

auto get_catmull_rom_point(
    float t, Point const p0, Point const p1, Point const p2, Point const p3)
    -> std::pair<Point, Vector> {
    // catmull-rom matrix
    const float m[4][4] = {{-0.5f, +1.5f, -1.5f, +0.5f},
                           {+1.0f, -2.5f, +2.0f, -0.5f},
                           {-0.5f, +0.0f, +0.5f, +0.0f},
                           {+0.0f, +1.0f, +0.0f, +0.0f}};

    const float pm[4][3] = {{p0.x(), p0.y(), p0.z()},
                            {p1.x(), p1.y(), p1.z()},
                            {p2.x(), p2.y(), p2.z()},
                            {p3.x(), p3.y(), p3.z()}};

    float a[4][3] = {0};
    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 3; j++)
            for (int k = 0; k < 4; k++) a[i][j] += m[i][k] * pm[k][j];

    const float tv[4] = {t * t * t, t * t, t, 1};

    float pv[3] = {0};
    for (int j = 0; j < 3; j++)
        for (int k = 0; k < 4; k++) pv[j] += tv[k] * a[k][j];

    const float tvd[4] = {3 * t * t, 2 * t, 1, 0};

    float dv[3] = {0};
    for (int j = 0; j < 3; j++)
        for (int k = 0; k < 4; k++) dv[j] += tvd[k] * a[k][j];

    return {Point(pv[0], pv[1], pv[2]), Vector(dv[0], dv[1], dv[2])};
}

auto get_location(float elapsed) -> std::pair<Point, Vector> {
    float gt = elapsed / TIME;   // how many times has the translation occurred
    float t = gt * POINT_COUNT;   // this is the real global t
    size_t index = std::floor(t); // which segment
    t = t - index;                // where within  the segment

    size_t indices[4];
    indices[0] = (index + POINT_COUNT - 1) % POINT_COUNT;
    indices[1] = (indices[0] + 1) % POINT_COUNT;
    indices[2] = (indices[1] + 1) % POINT_COUNT;
    indices[3] = (indices[2] + 1) % POINT_COUNT;

    return get_catmull_rom_point(
        t,
        POINTS[indices[0]],
        POINTS[indices[1]],
        POINTS[indices[2]],
        POINTS[indices[3]]);
}

void changeSize(int w, int h) {
    // Prevent a divide by zero, when window is too short
    // (you cant make a window with zero width).
    if (h == 0) h = 1;

    // compute window's aspect ratio
    float ratio = w * 1.0 / h;

    // Reset the coordinate system before modifying
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    // Set the viewport to be the entire window
    glViewport(0, 0, w, h);

    // Set the correct perspective
    gluPerspective(45, ratio, 1, 1000);

    // return to the model view matrix mode
    glMatrixMode(GL_MODELVIEW);
}

void renderCatmullRomCurve() {
    // draw curve using line segments with GL_LINE_LOOP
        float gt = 0.0;
    const float NUM_STEPS = 100;
    const float gt_step = TIME / NUM_STEPS;
    glBegin(GL_LINE_LOOP);
    for (int i = 0; i < NUM_STEPS; i++) {
        auto pos_deriv = get_location(gt);
        Point pos = std::get<0>(pos_deriv);
        glVertex3f(pos.x(), pos.y(), pos.z());
        gt += gt_step;
    }
    glEnd();
}

void renderScene(void) {
    static float t = 0;

    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glLoadIdentity();
    gluLookAt(camX, camY, camZ, 0.0, 0.0, 0.0, 0.0f, 1.0f, 0.0f);

    renderCatmullRomCurve();

    auto const elapsed = glutGet(GLUT_ELAPSED_TIME) / 1000.0f;

    auto point_dir = get_location(elapsed);
    auto p = std::get<0>(point_dir);
    glTranslatef(p.x(), p.y(), p.z());

    Vector X = std::get<1>(point_dir).normalize();
    Vector Z = X.cross(Vector(0, 1, 0)).normalize();
    Vector Y = Z.cross(X).normalize();

    glMultMatrixf(buildRotMatrix(X, Y, Z).data());

    glutWireTeapot(0.1);

    glutSwapBuffers();
    t += 0.00001;
}

void processMouseButtons(int button, int state, int xx, int yy) {
    if (state == GLUT_DOWN) {
        startX = xx;
        startY = yy;
        if (button == GLUT_LEFT_BUTTON)
            tracking = 1;
        else if (button == GLUT_RIGHT_BUTTON)
            tracking = 2;
        else
            tracking = 0;
    } else if (state == GLUT_UP) {
        if (tracking == 1) {
            alpha += (xx - startX);
            beta += (yy - startY);
        } else if (tracking == 2) {
            r -= yy - startY;
            if (r < 3) r = 3.0;
        }
        tracking = 0;
    }
}

void processMouseMotion(int xx, int yy) {
    int deltaX, deltaY;
    int alphaAux, betaAux;
    int rAux;

    if (!tracking) return;

    deltaX = xx - startX;
    deltaY = yy - startY;

    if (tracking == 1) {
        alphaAux = alpha + deltaX;
        betaAux = beta + deltaY;

        if (betaAux > 85.0)
            betaAux = 85.0;
        else if (betaAux < -85.0)
            betaAux = -85.0;

        rAux = r;
    } else if (tracking == 2) {
        alphaAux = alpha;
        betaAux = beta;
        rAux = r - deltaY;
        if (rAux < 3) rAux = 3;
    }
    camX = rAux * sin(alphaAux * 3.14 / 180.0) * cos(betaAux * 3.14 / 180.0);
    camZ = rAux * cos(alphaAux * 3.14 / 180.0) * cos(betaAux * 3.14 / 180.0);
    camY = rAux * sin(betaAux * 3.14 / 180.0);
}

int main(int argc, char** argv) {
    // inicialization
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);
    glutInitWindowPosition(100, 100);
    glutInitWindowSize(320, 320);
    glutCreateWindow("CG@DI-UM");

    // callback registration
    glutDisplayFunc(renderScene);
    glutIdleFunc(renderScene);
    glutReshapeFunc(changeSize);

    // mouse callbacks
    glutMouseFunc(processMouseButtons);
    glutMotionFunc(processMouseMotion);

    // OpenGL settings
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);

    // enter GLUT's main cycle
    glutMainLoop();

    return 1;
}
