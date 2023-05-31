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


<img src="images/FlowDiag.png" alt="Flow Diagram" width="400"/>

The conversion algorithm involves the following steps: 

1. Set up the ADC:
   - Set the reference voltage to AVCC (5V) by setting the REFS1 and REFS0 bits in the ADMUX register.
   - Set the ADC left-adjust result bit (ADLAR) to ensure that the 8 most significant bits of the ADC result are stored in the ADCH register.
   - Set the ADC channel to ADC0 (pin A0) by setting the MUX3:0 bits in the ADMUX register.
   - Enable the ADC by setting the ADEN bit in the ADCSRA register.
   - Set the ADC prescaler to 128 by setting the ADPS2, ADPS1, and ADPS0 bits in the ADCSRA register.

2. Measure the temperature:
   - Start the ADC conversion by setting the ADSC bit in the ADCSRA register.
   - Wait for the conversion to complete by continuously checking the ADSC bit.
   - Read the ADC result from the ADCH register.

3. Convert the ADC result to temperature:
   - Multiply the ADC result by the temperature coefficient (10 mV/°C) and divide by 1024 to obtain the voltage change in millivolts.
   - Subtract the output voltage at 0°C (50°C) to obtain the voltage change from 0°C.
   - Divide the voltage change by the temperature coefficient (10 mV/°C) to obtain the temperature in °C.

4. Display the temperature:
   - Separate the temperature into two digits for the seven-segment display.
   - Convert each digit to its corresponding seven-segment representation using a lookup table.
   - Output the segments for each digit to the corresponding seven-segment display.

5. Repeat the measurement and display process continuously.

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
