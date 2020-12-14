### OPENCL CONTEXT
- context is an abstract environment within which coordination and memory management for kernel execution is valid and well defined. A context coordinates the mechanisms for host-device interaction, manages the memory objects available to the devices, and keeps track of the programs and kernels that are created for each device. The API function to create a context is clCreateContext().

```
 clCreateContext (
   const cl_context_properties *properties,
   cl_uint num_devices,
   const cl_device:id *devices,
   void (CL_CALLBACK *pfn_notify)(
      const char *errinfo,
      const void *private_info,
      size_t cb,
      void *user_data),
   void *user_data,
   cl_int *errcode_ret)
```
 - A command-queue is the communication mechanism that the host uses to request action by a device. Once the host has decided which devices to work with and a context has been created, one command-queue needs to be created per device.
 
 ```
  cl_command_queue
   clCreateCommandQueueWithProperties(
   cl_context context,
   cl_device:id device,
   cl_command_queue_properties properties,
   cl_int* errcode_ret)
```












