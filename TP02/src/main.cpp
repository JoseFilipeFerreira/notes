#include <GL/gl.h>
#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <math.h>

float size = 1.0f;
float angle = 0;
float tx = 0;
float ty = 0;
float tz = 0;
GLenum drawType = GL_FILL;


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
	gluLookAt(5.0,5.0,5.0, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

    // put the geometric transformations here


    // put drawing instructions here
        glBegin(drawType);
            // X axis in red
            glColor3f(1.0f, 0.0f, 0.0f);
            glVertex3f(-100.0f, 0.0f, 0.0f);
            glVertex3f( 100.0f, 0.0f, 0.0f);
            // Y Axis in Green
            glColor3f(0.0f, 1.0f, 0.0f);
            glVertex3f(0.0f, -100.0f, 0.0f);
            glVertex3f(0.0f, 100.0f, 0.0f);
            // Z Axis in Blue
            glColor3f(0.0f, 0.0f, 1.0f);
            glVertex3f(0.0f, 0.0f, -100.0f);
            glVertex3f(0.0f, 0.0f,  100.0f);
        glEnd();

        glBegin(GL_TRIANGLES);
            //base
            glColor3f(1.0f, 0.0f, 1.0f);
            glVertex3f(-1.0f, 0.0f, -1.0f);
            glVertex3f(1.0f , 0.0f, -1.0f);
            glVertex3f(1.0f , 0.0f,  1.0f);
            glVertex3f(-1.0f, 0.0f, -1.0f);
            glVertex3f(1.0f , 0.0f,  1.0f);
            glVertex3f(-1.0f, 0.0f, -1.0f);
            //side
            glColor3f(1.0f, 0.0f, 0.0f);
            glVertex3f(1.0f, 0.0f, -1.0f);
            glVertex3f(0.0f , 1.0f,  0.0f);
            glVertex3f(1.0f, 0.0f, 1.0f);

            glColor3f(0.0f, 1.0f, 0.0f);
            glVertex3f(-1.0f, 0.0f, 1.0f);
            glVertex3f(1.0f , 0.0f,  1.0f);
            glVertex3f(0.0f, 1.0f, 0.0f);

            glColor3f(0.0f, 0.0f, 1.0f);
            glVertex3f(-1.0f, 0.0f, -1.0f);
            glVertex3f(-1.0f , 0.0f,  1.0f);
            glVertex3f(0.0f, 1.0f, 0.0f);

            glColor3f(1.0f, 1.0f, 0.0f);
            glVertex3f(1.0f, 0.0f, -1.0f);
            glVertex3f(-1.0f, 0.0f,  -1.0f);
            glVertex3f(0.0f, 1.0f, 0.0f);
        glEnd();

	// End of frame
	glutSwapBuffers();
}



// write function to process keyboard events
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
        case '1':
            drawType = GL_FILL;
            break;
        case '2':
            drawType = GL_LINE;
            break;
        case '3':
            drawType = GL_POINT;
            break;
    }

}

int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
		
// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);

	
// put here the registration of the keyboard callbacks
        glutKeyboardFunc(reactKey);


//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
