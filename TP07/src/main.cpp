#include "point.hpp"
#include "uniformrealdist.hpp"

#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#define _USE_MATH_DEFINES
#include <IL/il.h>
#include <math.h>
#include <vector>

#ifdef __APPLE__
#    include <GLUT/glut.h>
#else
#    include <GL/glew.h>
#    include <GL/glut.h>
#endif

float camX = 00, camY = 100, camZ = 100;
int startX, startY, tracking = 0;

int alpha = 0, beta = 45, r = 50;

GLuint buffers[1];
size_t ih, iw;
unsigned char* imageData;

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

void drawTerrain() {
    // colocar aqui o código de desnho do terreno usando VBOs com
    glBindBuffer(GL_ARRAY_BUFFER, buffers[0]);
    glVertexPointer(3, GL_FLOAT, 0, 0);
    for (unsigned int i = 0; i < ih - 1; i++) {
        glDrawArrays(GL_TRIANGLE_STRIP, i * 2 * iw, iw * 2);
    }
}

float h(int x, int z) {
    return imageData[ih * z + x] * (60.0 / 255.0);
}

float hf(float px, float pz) {
    int x1 = floor(px);
    int x2 = x1 + 1;
    int z1 = floor(pz);
    int z2 = z1 + 1;

    float fz = pz - z1;
    float fx = px - x1;

    float h_x1_z = h(x1, z2) * (1 - fz) + h(x1, z2) * fz;
    float h_x2_z = h(x2, z2) * (1 - fz) + h(x2, z2) * fz;

    return h_x1_z * (1 - fx) + h_x2_z * fx;
}

std::vector<Point>
generate_trees(int number, float min_dist, float plane_size) {
    std::vector<Point> points;
    auto static const rng =
        UniformRealDist<float>(-plane_size / 2, plane_size / 2);
    for (int i = 0; i < number; i++) {
        float x, z;
        do {
            x = rng();
            z = rng();
        } while (std::sqrt(x * x + z * z) < min_dist);

        points.emplace_back(x, hf(x - plane_size / 2, z - plane_size / 2), z);
    }
    return points;
}

void draw_tree(Point p) {
    glPushMatrix();
    glTranslatef(p.x(), p.y(), p.z());
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
        if (alpha > (2 * M_PI)) alpha -= (2 * M_PI);
    }
    _alpha -= 0.01;
    if (_alpha > (2 * M_PI)) _alpha -= (2 * M_PI);
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
        if (alpha > (2 * M_PI)) alpha -= (2 * M_PI);
    }
    _alpha += 0.01;
    if (_alpha > (2 * M_PI)) _alpha -= (2 * M_PI);
}

void renderScene(void) {
    float pos[4] = {-1.0, 1.0, 1.0, 0.0};

    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glLoadIdentity();
    gluLookAt(camX, camY, camZ, 0.0, 0.0, 0.0, 0.0f, 1.0f, 0.0f);

    glColor3f(0.2f, 0.8f, 0.2f);
    glEnableClientState(GL_VERTEX_ARRAY);
    drawTerrain();
    glDisableClientState(GL_VERTEX_ARRAY);

    static auto tree_pos = generate_trees(1000, 50, 256);
    for (auto const& p : tree_pos) draw_tree(p);
    draw_indians(16, 35);
    draw_cowboys(8, 15);

    glColor3f(1, 0, .498);
    glutSolidTorus(0.5, 1.6, 10, 10);

    // End of frame
    glutSwapBuffers();
}

void processKeys(unsigned char key, int xx, int yy) {
    // put code to process regular keys in here
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

void init() {
    // 	Load the height map "terreno.jpg"
    unsigned int t;

    ilGenImages(1, &t);
    ilBindImage(t);
    // terreno.jpg is the image containing our height map
    ilLoadImage((ILstring) "terreno.jpg");
    // convert the image to single channel per pixel
    // with values ranging between 0 and 255
    ilConvertImage(IL_LUMINANCE, IL_UNSIGNED_BYTE);
    // important: check tw and th values
    // both should be equal to 256
    // if not there was an error loading the image
    // most likely the image could not be found
    iw = ilGetInteger(IL_IMAGE_WIDTH);
    ih = ilGetInteger(IL_IMAGE_HEIGHT);
    // imageData is a LINEAR array with the pixel values
    imageData = ilGetData();

    std::cout << iw << " " << ih << std::endl;

    // 	Build the vertex arrays
    std::vector<float> vec;
    for (size_t h = 0; h < ih; h++) {
        for (size_t w = 0; w < iw; w++) {
            vec.push_back(w - (iw / 2.0));                               // x1
            vec.push_back(imageData[ih * h + w] * (60.0 / 255.0));       // y1
            vec.push_back(h - (ih / 2.0));                               // z1
            vec.push_back(w - (iw / 2.0));                               // x2
            vec.push_back(imageData[ih * (h + 1) + w] * (60.0 / 255.0)); // y2
            vec.push_back(h + 1.0 - (ih / 2.0));                         // z2
        }
    }

    glGenBuffers(1, buffers);
    glBindBuffer(GL_ARRAY_BUFFER, buffers[0]);
    glBufferData(
        GL_ARRAY_BUFFER,
        sizeof(float) * vec.size(),
        vec.data(),
        GL_STATIC_DRAW);
}

int main(int argc, char** argv) {
    // init GLUT and the window
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);
    glutInitWindowPosition(100, 100);
    glutInitWindowSize(320, 320);
    glutCreateWindow("CG@DI-UM");
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    //  OpenGL settings
    glEnable(GL_BLEND);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_NORMALIZE);

    glPolygonMode(GL_FRONT, GL_LINE);

    glewInit();
    ilInit();
    init();

    // Required callback registry
    glutDisplayFunc(renderScene);
    glutIdleFunc(renderScene);
    glutReshapeFunc(changeSize);

    glutMouseFunc(processMouseButtons);
    glutMotionFunc(processMouseMotion);

    // Callback registration for keyboard processing
    glutKeyboardFunc(processKeys);

    // enter GLUT's main cycle
    glutMainLoop();

    return 0;
}
