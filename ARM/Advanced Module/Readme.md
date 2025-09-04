Familiarise yourself with the CMSIS-Core cache functions at: 
https://github.com/ARM-software/CMSIS_5/blob/develop/CMSIS/Core/Include/cachel1_armv7.h

If the processor has been implemented with L1 data or instruction caches, they must be invalidated before they are enabled in software, otherwise unpredictable behavior can occur.

In your working environment, create a new project as per the 
Getting started with Cortex-M using Arm DS and CMSIS
 tutorial, but this time select a Cortex-M55 Device. In the startup file. Then:

Add code to invalidate the data and instruction caches

Enable both data and instruction caches.

Also, if your working environment provides a cycle accurate simulator or  you have a real device with L1 caches, then feel free to check the performance difference with and without caches enabled. For more information, please see the 
Armv8.1-M Performance Monitor User Guide.

  