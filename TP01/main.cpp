#include <GL/gl.h>
#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>

float size = 1.0f;
float angle = 0;
float tx = 0;
float ty = 0;
float tz = 0;

void changeSize(int w, int h) {

	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if(h == 0)
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
	gluPerspective(45.0f ,ratio, 1.0f ,1000.0f);

	// return to the model view matrix mode
	glMatrixMode(GL_MODELVIEW);
}

void renderScene(void) {
	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(0.0,0.0,5.0, 
		      0.0,0.0,-1.0,
			  0.0f,1.0f,0.0f);

        // put drawing instructions here
        glColor3f(0, 1.0, 0);
        glTranslated(tx, ty, tz);
        glRotated(angle, 0, 1, 0);
        glutWireTeapot(size);

	// End of frame
	glutSwapBuffers();
}

void reactKey(unsigned char key, int x, int y){
    switch (key){
        case '+':
            size += 0.1;
            break;
        case '-':
            size -= 0.1;
            break;
        case 'h':
            angle += 1;
            break;
        case 'l':
            angle -= 1;
            break;
        case 'w':
            tz += 0.1;
            break;
        case 's':
            tz -=0.1;
            break;
        case 'a':
            tx += 0.1;
            break;
        case 'd':
            tx -=0.1;
            break;
        case 'k':
            ty += 0.1;
            break;
        case 'j':
            ty -=0.1;
            break;
    }

}


int main(int argc, char **argv) {

// put GLUT init here
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);
    glutCreateWindow("CG@DI");
    glutFullScreen();

// put callback registration here
    glutDisplayFunc(renderScene);
    glutReshapeFunc(changeSize);
    glutIdleFunc(renderScene);

    glutKeyboardFunc(reactKey);


// OpenGL settings 
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glClearColor(0.0f,0.0f,0.0f,0.0f);

// enter GLUT's main loop
	glutMainLoop();
	
	return 1;
}

