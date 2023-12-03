# Adjusting the speed of DOSBox in VSCode

In this tutorial, we will learn how to adjust the speed of DOSBox in VSCode.
It can seem quite tricky because the provided settings doesn't seem to work. (This may be fixed in the future, but for now, this is the only way I know of.)
Increasing the speed of DOSBox can reduce the flickring significantly So try it out.
If you won't to try it temporarily, you can just use the `cycles` in dosbox by clicking
`ctrl + F12` a few times until you get the desired speed.

## Steps to adjust the settings

1. Find the setting file for DOSBox in VSCodes settings.

   - Find the vscode extention folder. (for me its `~/.vscode/extensions`)
   - Locate the `vscode-dosbox` folder.
   - navigate to `emu/dosbox/dosbox-0.74.conf`.
   - (If you can't find the file, try to run the emulator once and it should appear.)

2. Change the `cycles` value to `max`.
3. Change any other settings you want. and save the file.
4. Reload VSCode.
5. Run the emulator again and it should work.
