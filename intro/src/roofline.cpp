#include "roofline.h"

using namespace std;

#define MAXVALUE 1000000
#define ARRAY_SIZE_1 1000
#define REPEAT_1 10000000
#define ARRAY_SIZE_2 1000
#define REPEAT_2 10000000
#define UNROLL_COUNT 2
#define VECTOR_LENGTH 4

/********** Data Set 1 **********/
// Array of Structures
typedef struct S1_AoS
{
    double a;
    double b;
    double pad1;
    double pad2;
} S1_AoS;
double AoS1_X[ARRAY_SIZE_1];
S1_AoS AoS1_Y[ARRAY_SIZE_1];
// Structure of Arrays
typedef struct S1_SoA
{
    double a[ARRAY_SIZE_1];
    double b[ARRAY_SIZE_1];
    double pad1[ARRAY_SIZE_1];
    double pad2[ARRAY_SIZE_1];
} S1_SoA;
double SoA1_X[ARRAY_SIZE_1];
S1_SoA SoA1_Y;
/********** Data Set 2 **********/
// Structure of Arrays
typedef struct S2_SoA
{
    double a[ARRAY_SIZE_2];
    double b[ARRAY_SIZE_2];
} S2_SoA;
double SoA2_X[ARRAY_SIZE_2];
S2_SoA SoA2_Y;

// Array of Structure of Arrays
typedef struct AoSoA
{
    double a[ARRAY_SIZE_2 / 2];
    double b[ARRAY_SIZE_2 / 2];
} AoSoA;
double AoSoA_X[ARRAY_SIZE_2];
AoSoA AoSoA_Y[2]; 


void g1 () {
    //############################## Group 1 ##############################//
    // Group 1 is a low arithmetic intensity algorithm intended to display
    // roofline behavior which may initially seem counter-intuitive.
    #ifdef GROUP_1
    cout << "####################### Group 1 #######################\n"
         << "    Algorithm: X = Ya + Yb\n    Data Set 1: " << ARRAY_SIZE_1 
         << " doubles/array.\n";
    #endif
    /******************** AOS - Unvectorized ********************/
    #ifdef G1_AOS_SCALAR
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma novector
        for (int i = 0; i < ARRAY_SIZE_1; i++)
        {
            AoS1_X[i] = AoS1_Y[i].a + AoS1_Y[i].b;
        }
    }
    cout << "Unvectorized AOS loop complete.\n";
    #endif
    /******************** SOA - Unvectorized ********************/
    #ifdef G1_SOA_SCALAR
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma novector
        for (int i = 0; i < ARRAY_SIZE_1; i++)
        {
            SoA1_X[i] = SoA1_Y.a[i] + SoA1_Y.b[i];
        }
    }
    cout << "Unvectorized SOA loop complete.\n";
    #endif
    /********************* SOA - Vectorized *********************/
    #ifdef G1_SOA_VECTOR
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma omp simd simdlen(VECTOR_LENGTH)
        for (int i = 0; i < ARRAY_SIZE_1; i++)
        {
            SoA1_X[i] = SoA1_Y.a[i] + SoA1_Y.b[i];
        }
    }
    cout << "Vectorized SOA loop complete.\n";
    #endif
}

void g2 () {
    //############################## Group 2 ##############################//
    // Group 2 is a high arithmetic intensity algorithm that is intended
    // to demonstrate compute binding and compiler-induced AI changes.
    #ifdef GROUP_2
    cout << "####################### Group 2 #######################\n"
         << "    Algorithm: X = Ya + Ya + Yb + Yb + Yb\n    Data Set 1: " << ARRAY_SIZE_1
         << " doubles/array.\n";
    #endif
    /******************** AOS - Unvectorized ********************/
    #ifdef G2_AOS_SCALAR
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma novector
        for (int i = 0; i < ARRAY_SIZE_1; i++)        {
            AoS1_X[i] = AoS1_Y[i].a + AoS1_Y[i].a + AoS1_Y[i].b + AoS1_Y[i].b + AoS1_Y[i].b;
        }
    }
    cout << "Unvectorized AOS loop complete.\n";
    #endif
    /******************** SOA - Unvectorized ********************/
    #ifdef G2_SOA_SCALAR
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma novector
        for (int i = 0; i < ARRAY_SIZE_1; i++)
        {
            SoA1_X[i] = SoA1_Y.a[i] + SoA1_Y.a[i] + SoA1_Y.b[i] + SoA1_Y.b[i] + SoA1_Y.b[i];
        }
    }
    cout << "Unvectorized SOA loop complete.\n";
    #endif
    /********************* AOS - Vectorized *********************/
    #ifdef G2_AOS_VECTOR
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma omp simd simdlen(VECTOR_LENGTH)
        for (int i = 0; i < ARRAY_SIZE_1; i++)
        {
            AoS1_X[i] = AoS1_Y[i].a + AoS1_Y[i].a + AoS1_Y[i].b + AoS1_Y[i].b + AoS1_Y[i].b;
        }
    }
    cout << "Vectorized AOS loop complete.\n";
    #endif
    /********************* SOA - Vectorized *********************/
    #ifdef G2_SOA_VECTOR
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma omp simd simdlen(VECTOR_LENGTH)
        for (int i = 0; i < ARRAY_SIZE_1; i++)
        {
            SoA1_X[i] = SoA1_Y.a[i] + SoA1_Y.a[i] + SoA1_Y.b[i] + SoA1_Y.b[i] + SoA1_Y.b[i];
        }
    }
    cout << "Vectorized SOA loop complete.\n";
    #endif
    /**************** SOA - Vectorized with FMAs ****************/
    #ifdef G2_SOA_VECTOR_FMAS
    for (int r = 0; r < REPEAT_1; r++)
    {
        #pragma unroll (UNROLL_COUNT)
        #pragma omp simd simdlen(VECTOR_LENGTH)
        for (int i = 0; i < ARRAY_SIZE_1; i++)
        {
            SoA1_X[i] = (2.0 * SoA1_Y.b[i] + SoA1_Y.b[i]) + SoA1_Y.a[i] * 2.0;
        }
    }
    cout << "Vectorized SOA with FMAs loop complete.\n";
    #endif
}

void g3 () {
    //############################## Group 3 ##############################//
    // Group 3 uses a different data set than the other Groups, and has
    // a medium AI. It is intended to demonstrate cache bandwidth binding.
    #ifdef GROUP_3
    cout << "####################### Group 3 #######################\n"
         << "    Algorithm: X = Ya + Ya + Yb + Yb\n    Data Set 2: " << ARRAY_SIZE_2
         << " doubles/array.\n";
    #endif
    /**************************** SOA ***************************/
    #ifdef G3_SOA
    for (int r = 0; r < REPEAT_2; r++)
    {
        #pragma nounroll
        #pragma omp simd simdlen(VECTOR_LENGTH)
        for (int i = 0; i < ARRAY_SIZE_2; i++)
        {
            SoA2_X[i] = SoA2_Y.a[i] + SoA2_Y.a[i] + SoA2_Y.b[i] + SoA2_Y.b[i];
        }
    }
    cout << "SOA loop complete.\n";
    #endif
    /*************************** AOSOA **************************/
    #ifdef G3_AOSOA
    for (int r = 0; r < REPEAT_2; r++)
    {
        for (int j = 0; j < 2; j++)
        {
            #pragma nounroll
            #pragma omp simd simdlen(VECTOR_LENGTH)
            for (int i = 0; i < ARRAY_SIZE_2 / 2; i++)
            {
                AoSoA_X[(j * (ARRAY_SIZE_2 / 2)) + i] = AoSoA_Y[j].a[i] + AoSoA_Y[j].a[i] 
                                                        + AoSoA_Y[j].b[i] + AoSoA_Y[j].b[i];
            }
        }
    }
    cout << "AOSOA loop complete.\n";
    #endif
}

int exec (){
    setupArrays();
    cout << "Setup complete.\n";

    g1 ();

    g2 ();

    g3 (); 

    return EXIT_SUCCESS;
}

void setupArrays() {
    for (int i = 0; i < ARRAY_SIZE_1; i++)
    {
        SoA1_Y.a[i] = ((rand() % MAXVALUE) + 1) / 3;
        SoA1_Y.b[i] = ((rand() % MAXVALUE) + 1) / 3;
        AoS1_Y[i].a = SoA1_Y.a[i];
        AoS1_Y[i].b = SoA1_Y.b[i];
    }
    for (int i = 0; i < ARRAY_SIZE_2; i++)
    {
        SoA2_Y.a[i] = ((rand() % MAXVALUE) + 1) / 3;
        SoA2_Y.b[i] = ((rand() % MAXVALUE) + 1) / 3;
    }
    for (int i = 0; i < ARRAY_SIZE_2 / 2; i++)
    {
        AoSoA_Y[0].a[i] = SoA2_Y.a[i];
        AoSoA_Y[1].a[i] = SoA2_Y.a[i + (ARRAY_SIZE_2 / 2)];
        AoSoA_Y[0].b[i] = SoA2_Y.b[i];
        AoSoA_Y[1].b[i] = SoA2_Y.b[i + (ARRAY_SIZE_2 / 2)];
    }
}
