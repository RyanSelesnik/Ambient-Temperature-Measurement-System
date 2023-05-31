# Simple Temperature Measurement Solution

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A simple solution for measuring the ambient temperature using an analogue-to-digital conversion approach. This project provides a temperature sensor system that accurately measures the temperature of the surrounding environment and displays it on two seven-segment displays.

## Features

- Utilizes the MCP9700-series temperature sensor and the ATMega328p microcontroller (MCU)
- Converts analogue temperature signal to a digital value using the ADC
- Displays temperature on two seven-segment displays
- Temperature range: 0°C to 74°C with ±1°C accuracy

## Hardware Setup

<img src="images/circuit.png" alt="Circuit Diagram" width="500"/>

<img src="images/schematic.png" alt="Schematic" width="500"/>
The system comprises the following components:

- MCP9700-series temperature sensor
- ATMega328p microcontroller
- Two seven-segment displays

## Conversion Algorithm

The assembly code implements a conversion algorithm based on the following flow diagram:

<img src="images/FlowDiag.png" alt="Flow Diagram" width="400"/>

- ADC interrupts are used to read the ADC value when a conversion is complete
- The ADC value is converted to a temperature using fixed-point arithmetic
- The temperature is separated into tens and units to display on the seven-segment displays

## Power Saving

The system incorporates power-saving techniques to optimize energy consumption:

- Utilizes idle mode to disable the ADC and save power
- Implements display multiplexing to switch between units and tens at a frequency of 120Hz

## Results and Future Recommendations

The resulting temperature measurement system provides accurate readings within the specified range. Future recommendations include:

- Enhancing the system to handle negative temperatures using signed arithmetic
- Adding an additional display for displaying the fractional component of the temperature

## Contributions

Contributions to this project are welcome! If you find any issues or have suggestions for improvements, feel free to submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

- Microchip MCP9700-series Temperature Sensor Datasheet
- Atmel ATMega328p Microcontroller Datasheet
- Subero, A. (2018). Programming Pic Microcontrollers with Xc8.
