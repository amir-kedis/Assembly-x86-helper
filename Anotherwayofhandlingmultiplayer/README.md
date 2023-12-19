# Here is an illustration about what is happening in the multiplayer games
## Actually you can define your own interrupt but how do they really work ?

### The interrupts actually are more like pre-defined functions pointed to its location by a place in memory
### which is called the interrupt vector 
The code actually has a snippet extracting the segment and offset adresses of the original interrupt and saving it. It is so important to save these adresses to be able to return it at the end of your program.
```
            mov ax, 3509h ; Get Interrupt Vector
            int  21h ; -> ES:BX 
            mov old_int_offset, bx
            mov old_int_seg, es
```
here the above interrupt takes in the segment of the original interrupt and place it in es and takes its offset and place it in bx
You save both in memory to be able to return it again.
### Something like hash table
You will find in the code this array ``` KeyList db 128 dup (0) ``` which is like a look up table where you access it by the key pressed 
or release as illustrated in [multi-key-input](https://github.com/amir-kedis/Assembly-x86-helper/tree/main/multi-key-input)
for example if the up arrow is pressed ``` [KeyList + 48h] ``` will be set to 1 and when released the same place will be set to 0
### But how actually to set the new interrupt?
To override the interrupt , you define your own procedure with the way to handle your code which is listening to port 60h
and then move to the interrupt vector the offset address - > dx and segment address -> ds of your procedures
```
            push DS 
            mov dx, offset myint ; myint is the procedure you defined
            mov ax, seg myint ; new segment
            mov ds, ax 
            mov ax, 2509h
            int 21h
            pop ds  
``` 
Complete code for the set and return and the function itself is in the files attached.