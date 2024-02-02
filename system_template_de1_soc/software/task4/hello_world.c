/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdlib.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h> // required for cos function

// test case 1
//#define step 5
//#define N 52

// test case 2
//#define step 1/8.0
//#define N 2041

// test case 3
#define step 1/1024.0
#define N 261121

void generateVector(float x[N]) {
  int i;
  x[0] = 0;
  for (i = 1; i < N; i++) {
    x[i] = x[i-1] + step; // step through, generates 0, step, 2*step, 3*step, ..., N-1*step
  }
}


float sumVector(float x[], int M) {
  size_t i = 0;
  float total = 0;
  for (i = 0; i < M; i++) {
    total += 0.5*(x[i]) + (x[i]*x[i]*cos((x[i]-128.0)/128.0));
  }
  return total;
}


int main()
{
	printf("----------------------\n");
	printf("Task 4\n");
	printf("Params: N = %d, ", N);
	printf("s = %f\n", step);

	float x[N]; ///< input vector
	float y; ///< output of sumVector function
	clock_t exec_t1;
	clock_t exec_t2;

	generateVector(x); // generate input vector

	/*********************************************/
	exec_t1 = times(NULL);

	y = sumVector(x, N);

	exec_t2 = times(NULL);
	/*********************************************/

	clock_t res = (exec_t2 - exec_t1);

	printf("Ticks elapsed (1 run): %lu \n", res);
	printf("Answer: %f\n", y);

	return 0;
}
