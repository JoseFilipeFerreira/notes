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
    // TRIANGLE_STRIPS
}

void renderScene(void) {
    float pos[4] = {-1.0, 1.0, 1.0, 0.0};

    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);


    glLoadIdentity();
    gluLookAt(camX, camY, camZ, 0.0, 0.0, 0.0, 0.0f, 1.0f, 0.0f);

    glColor3f(1.0f, 0, 0);
    drawTerrain();

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
    unsigned int t, tw, th;

    unsigned char* imageData;
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
    tw = ilGetInteger(IL_IMAGE_WIDTH);
    th = ilGetInteger(IL_IMAGE_HEIGHT);
    // imageData is a LINEAR array with the pixel values
    imageData = ilGetData();

    std::cout << tw << " " << th << std::endl;

    // 	Build the vertex arrays
    std::vector<float> vec;
    for (size_t h = 0; h < th; h++) {
        for (size_t w = 0; w < tw; w++) {
            vec.push_back(w - (tw / 2.0));                               // x1
            vec.push_back(imageData[th * h + w] * (60.0 / 255.0));       // y1
            vec.push_back(h - (th / 2.0));                               // z1
            vec.push_back(w - (tw / 2.0));                               // x2
            vec.push_back(imageData[th * (h + 1) + w] * (60.0 / 255.0)); // y2
            vec.push_back(h + 1.0 - (th / 2.0));                         // z2
        }
    }

    ih = th;
    iw = tw;
    glGenBuffers(1, buffers);
    glBindBuffer(GL_ARRAY_BUFFER, buffers[0]);
    glBufferData(
        GL_ARRAY_BUFFER,
        sizeof(float) * vec.size(),
        vec.data(),
        GL_STATIC_DRAW);

    // 	OpenGL settings
    glEnable(GL_DEPTH_TEST);
    // glEnable(GL_CULL_FACE);
}

int main(int argc, char** argv) {
    // init GLUT and the window
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);
    glutInitWindowPosition(100, 100);
    glutInitWindowSize(320, 320);
    glutCreateWindow("CG@DI-UM");

    glEnableClientState(GL_VERTEX_ARRAY);
    glPolygonMode(GL_FRONT, GL_LINE);

    // Required callback registry
    glutDisplayFunc(renderScene);
    glutIdleFunc(renderScene);
    glutReshapeFunc(changeSize);

    glutMouseFunc(processMouseButtons);
    glutMotionFunc(processMouseMotion);

    // Callback registration for keyboard processing
    glutKeyboardFunc(processKeys);

    glewInit();
    ilInit();
    init();

    // enter GLUT's main cycle
    glutMainLoop();

    return 0;
}
