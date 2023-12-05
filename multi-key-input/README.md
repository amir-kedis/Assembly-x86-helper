# <h1 style="text-align: center">Reading Multiple Key Inputs</h1>  
In game development, the basic idea of reading multiple inputs is using event listeners.  
For assembly, you can listen to the ports to which the hardware is connected.

## Listening to keyboard events
The keyboard is connected to port 60H, and every key press or release is sent to the port as a key scan code; every key has a scan code for pressing it and another one for releasing the key.

For Example, the scan code for **pressing** the **up key** is **48H** and the **release** scan code is **C8H**.
``` python
release_scan_code = press_scan_code + 80H
C8H = 48H + 80H
```

Code Example
``` assembly
in al, 60H
cmp al, 48H
jz do_action1

cmp al, 0C8H
jz do_action2
```
 - read input from port 60H
 - check for the pressing of **up key**, and do action one
 - check for releasing of the **up key**, and do action two

<p style="color: red">But to listen to port 60H correctly, you need to override int 9H.</p>

## Overriding int 9H

To listen to port 60H only when a key is pressed or released, we need to override int 9H.  

Int 9H is a hardware int that gets called automatically when a key is pressed or released.  

Overriding the int is done by changing the offset of the proc that gets called when the int is called, and by doing so, we change the interrupt vector table.

But, remember to retrieve the original int 9H procedure before exiting your program. 

## Code Demo
You will find attached, a code demo to test pressing the **up key** and the  **w key** at the same time.

Pressing the **up key** will change the displayed _**n**_ into _**y**_ and releasing the key will do the opposite.

Pressing the **w key** will change the displayed _**0**_ into _**1**_ and releasing the key will do the opposite.  

The code demo includes the process of overriding int 9H.
