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

#define _SVID_SOURCE

#include <stdlib.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <stdio.h>
#include <unistd.h>


// test case 1
//#define step 5
//#define N 52

// test case 2
#define step 1/8.0
#define N 2041

// test case 3
//#define step 1/1024.0
//#define N 261121

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
    total += x[i] + (x[i]*x[i]);
  }
  return total;
}

int main()
{
	printf("----------------------\n");
  printf("Task 2\n");
  printf("Params: N = %d, ", N);
  // makeshift float printer
  printf("s = %d.%d%d%d%d\n",
		  (int)(step),
		  (int)(step*10)%10,
		  (int)(step*100)%10,
		  (int)(step*1000)%10,
		  (int)(step*10000)%10);

  float x[N]; ///< input vector
  float y; ///< output of sumVector function
  clock_t exec_t1;
  clock_t exec_t2;

  // init timer

  generateVector(x); // generate input vector

  /*********************************************/
  exec_t1 = times(NULL);
  for (int i = 0; i < 1000; i++) {
	  y = sumVector(x, N);
  }

  exec_t2 = times(NULL);

  /*********************************************/

  int i;
  for (i = 0; i < 10; i++) {
    y = (y / 2.0);
  }

  clock_t res = (exec_t2 - exec_t1);

  printf("Number of ticks per second: %lu\n", alt_ticks_per_second());
  printf("Ticks elapsed (1000 runs): %lu \n", res);
  printf("Answer: %d\n", (int)y);

  return 0;
}
