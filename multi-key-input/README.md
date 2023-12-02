# <h1 style="text-align: center">Reading Multiple Key Input</h1>  
In game development, the basic idea of reading multiple inputs is using event listeners.  
For assembly, you can listen to the borts which the hardware is connected to.

## Listening to keyboard events
The keyboard is connected to port 60H, and every key press or release is send to the port as a key scan code; every key has a scan code for pressing it and another one for releasing the key.

For Example, the scan code for **pressing** the **up key** is **48H** and the **release** scan code is **C8H**.
```python
release_scan_code = press_scan_code + 80H
C8H = 48H + 80H
```
Code Example
```assembly
in al, 60H
cmp al, 48H
jz do_action1

cmp al, 0C8H
jz do_action2
```
 - read input from port 60H
 - check for the pressing of **up key**, and do action one
 - check for releasing of the **up key**, and do action two