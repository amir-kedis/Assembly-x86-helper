# Image Processing Script

This Python script processes images based on a predefined color dictionary based on VGA AVAILABLE COLORS. It provides options to convert an image to a binary file, resize the image, or exit the program.

## Prerequisites

- Python 3.x
- PIL (Pillow) library

## Usage

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/your-username/your-repository.git
    cd your-repository
    ```

2. **Install Dependencies:**

    ```bash
    pip install pillow
    ```

3. **Run the Script:**

    ```bash
    python image_processing_script.py
    ```

4. **Follow the On-Screen Instructions:**

    - Enter the image filename when prompted.
    - Choose an option from the menu:
        - `1`: Convert the image to a binary file.
        - `2`: Resize the image.
        - `3`: Exit the program.

## Features

- **Convert to Binary File:**
  - Converts the image pixels based on a predefined color dictionary.
  - Saves the converted image as a binary file.

- **Handling Transparent Pixels:**
  - Any transparent pixel is converted to a predefined value (250) 

- **Resize the Image:**
  - Provides an option to resize the image.
  - Enter the factor by which you want to reduce the image size.


Certainly! Below is a sample README file with documentation for your assembly code:

# DOS Assembly Image Reader

This DOS assembly program reads an image file (`a.bin`), processes its pixels, and displays the image on the screen using the 320x200 VGA graphics mode.


## Prerequisites

- DOS environment or DOS emulator (e.g., DOSBox)
- Knowledge of DOS assembly language

## Usage

1. **Clone the Repository:**

2. **Run the Assembly Program:**

    Make sure to run the program in a DOS environment or emulator.

    ```bash
    a.bin
    ```

    The program reads the `a.bin` file, processes its pixels, and displays the image on the screen.

## Program Overview

The program is written in DOS assembly language and performs the following tasks:

- Opens the file `filename.bin` and reads its contents into a buffer.
- Draws the image on the screen in VGA graphics mode (320x200).
- Handles errors during file operations and displays an error message if needed.

## Constants

- `IMAGE_HEIGHT`: Height of the image 
- `IMAGE_WIDTH`: Width of the image 
- `SCREEN_WIDTH`: Width of the screen (320 pixels)
- `SCREEN_HEIGHT`: Height of the screen (200 pixels)

## File Handling

The program uses DOS interrupt 21h functions to open, read, and close the file. Errors are checked, and an error message is displayed if necessary.

## Graphics Drawing

The `drawImage` procedure is responsible for drawing the image on the screen. It sets the VGA graphics mode, clears the screen, and iterates through the image pixels to draw them on the screen.

## Error Handling

In case of errors during file operations, an error message is displayed using DOS interrupt 21h function 09h.

## Exiting the Program

The program exits when a key is pressed. The DOS interrupt 16h function 00h is used to wait for a key press.



