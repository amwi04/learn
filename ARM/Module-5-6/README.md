

- When added to the 16 exception numbers reserved for system exceptions, the 496 general interrupts make up a total of 512 exception numbers, a convenient power of 2.
- Nested vectored interupt controller (NVIC)
- 
>
>When an exception causes pre-emption, the ReturnAddress might be set to:

>The currently executing instruction

>Correct. The ReturnAddress is the address of the current instruction if that instruction needs to be replayed or completed, or the address of the next instruction in sequence if the current instruction is able to complete before the exception is recognized.

>The next instruction to be executed

>Correct. The ReturnAddress is the address of the current instruction if that instruction needs to be replayed or completed, or the address of the next instruction in sequence if the current instruction is able to complete before the exception is recognized.