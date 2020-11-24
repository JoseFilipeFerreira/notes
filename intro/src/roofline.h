#ifndef F_ROOFLINE
#define F_ROOFLINE

#include <iostream>
#include <random>

/*******************************/
/*        Control Panel        */
/*******************************/
#define GROUP_1
#ifdef GROUP_1
    //#define G1_AOS_SCALAR
    #define G1_SOA_SCALAR
    //#define G1_SOA_VECTOR
#endif /************************/

#define GROUP_2
#ifdef GROUP_2
    //#define G2_AOS_SCALAR
    //#define G2_SOA_SCALAR
    //#define G2_AOS_VECTOR
    //#define G2_SOA_VECTOR
    #define G2_SOA_VECTOR_FMAS
#endif /************************/
#define GROUP_3
#ifdef GROUP_3
//     #define G3_SOA
    #define G3_AOSOA
#endif /************************/

int exec ();
void setupArrays();
__declspec(noinline) void g1 ();
__declspec(noinline) void g2 ();
__declspec(noinline) void g3 ();

#endif