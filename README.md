# Ambient Temperature Measurement System

This repository contains a simple solution for measuring the ambient temperature using a temperature sensor and microcontroller. The project was developed part of the School of Electrical and Information Engineering at the University of the Witwatersrand, Johannesburg, South Africa.

# Abstract

This project presents a simple solution for measuring the ambient temperature using a temperature sensor, specifically the MCP9700-series, and an ATMega328p microcontroller. The objective is to engineer a working temperature sensor that accurately measures the temperature of the surrounding environment. The analog signal from the temperature sensor is converted to a digital temperature value, which is then displayed on two seven-segment displays. The temperature range of the sensor is from 0°C to 74°C with an accuracy of ±1°C. The hardware components used in this solution include the ATMega328p microcontroller, MCP9700 temperature sensor, ADC (Analog-to-Digital Converter), and seven-segment displays.

# I. Introduction

To accurately measure and display the temperature of the surrounding environment, a conversion from an analog signal to a digital one is necessary. This project proposes a solution using the MCP9700-series temperature sensor, the ATMega328p microcontroller, and two seven-segment displays. The firmware for this project is implemented in assembly language, and the use of additional integrated circuits is prohibited. This repository provides an overview of the design of the solution, discusses the obtained results, and suggests future recommendations.

# II. Design

## A. System Overview
The system consists of the MCP9700-series temperature sensor as the input, the ATMega328p microcontroller as the controller, and two seven-segment displays as the output. The schematic of the system and the actual circuitry on a breadboard are presented. The MCP9700 temperature sensor detects temperature changes by monitoring the voltage at its output pin. The analog signal is then converted to a digital value using the ADC of the microcontroller.

<img src="images/circuit.png" alt="Circuit Diagram" width="400"/>


![Schematic](images/schematic.png)
*Figure 1: Schematic*

## B. Inputs
The MCP9700 temperature sensor is a linear thermistor integrated circuit with three pins. The resistance of the thermistor varies with temperature, resulting in a corresponding change in voltage at the output pin. The voltage is related to temperature by a linear equation.

## C. Analog to Digital Converter
The ADC of the ATMega328p microcontroller is utilized to convert the analog voltage from the temperature sensor to a discrete digital number. A higher bit resolution is used to detect smaller temperature changes. The chosen ADC clock pre-scaler and reference voltage contribute to the precision of the measurement.

## D. The Conversion Algorithm
The conversion algorithm is based on a flowchart, which utilizes interrupts for ADC conversion and timer functions. The ADC conversion is triggered when the microcontroller enters idle sleep mode to reduce noise. The converted digital value is then processed using fixed-point arithmetic to obtain the temperature value. The temperature is separated into tens and units to be displayed on the seven-segment displays.

![Flow Diagram](images/FlowDiag.png)
*Figure 3: Flow Diagram*

## E. Outputs
The seven-segment displays are multiplexed to minimize the number of pins required. NPN transistors are used as switches to control the display of tens and units digits. The brightness of each segment is balanced by using 470-ohm resistors for each segment. Timer interrupts are employed to control the display switching frequency.

## F. Power Saving
Power saving techniques include utilizing the ADC idle mode and implementing sleep loops to save power while the ADC is disabled. The multiplexing of displays and the choice of timer interrupt frequency contribute to power optimization.

## III. Discussion
To validate the accuracy of the temperature measurement, a program was developed in the Arduino Integrated Development Environment (IDE) to convert the displayed temperature to its corresponding analog voltage value. The obtained results show a temperature range of 0°C to 74°C with an accuracy of ±1°C. The design trade-offs made, such as multiplexing displays and utilizing program memory for the lookup table, have resulted in improved temperature precision and power savings. However, the current implementation does not support negative temperatures, and the fractional component of the temperature is not displayed. These areas can be addressed in future enhancements.

## IV. Conclusion
This project successfully presents a simple solution for measuring the ambient temperature using the MCP9700-series temperature sensor and the ATMega328p microcontroller. The hardware components used, including the temperature sensor, ADC, and seven-segment displays, are integrated to provide an accurate temperature measurement range suitable for in-home applications. The implemented firmware, based on assembly language, demonstrates the efficiency and power-saving capabilities of the system. Future improvements can include handling negative temperatures and displaying the fractional component of the temperature to further enhance the system's robustness and accuracy.

# Acknowledgments
The author would like to thank the School of Electrical and Information Engineering at the University of the Witwatersrand for their support and resources during the development of this project.

#  References
[1] Datasheet: MCP9700/MCP9700A, Microchip Technology Inc., 2006.

[2] ATMega328/P Datasheet, Microchip Technology Inc., 2016.
