# Large screen size in dosbox using VESA

It seems that are more supported modes under the VESA Specification than the ones that are listed in normal 8086 mode.
For List of SVGA modes see: [Wikipedia Link](https://en.wikipedia.org/wiki/VESA_BIOS_Extensions)

An image for the mode (0101h 640x480x265) is shown below:

[Large Screen Size](./large-mode.png)

## How to use

For more details on how to use check the code demo. Note: large screen sizes may not work on all systems
and are not recommended because they force you to use 32bit pointers and registers to access them and
they might cause a crash sometimes.
