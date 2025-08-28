# Defibrillator FSM
A Finite State Machine (FSM) modeling the behavior of an Automated External Defibrillator (AED).

## Overview
This FSM simulates the operational logic of a defibrillator. It monitors a patient’s heartbeat, determines whether it is irregular, and signals the user when a shock should be delivered to the patient.

## State Encoding
The FSM has four states representing the device's operation:

| State Name                     | Encoding |
|--------------------------------|---------|
| Waiting for Heartbeat           | 00      |
| Measuring Heartbeat             | 01      |
| Irregular Heartbeat Detected    | 10      |
| Shock Delivered                 | 11      |

## Input Signals
- **B**: Button Pressed  
- **H**: Heartbeat Detected  
- **R**: Regular Heartbeat Detected  

## Output Signals
- **L**: Light on the button  
- **S**: Deliver Shock to Heart  

## Operation
1. The device starts in the **Waiting for Heartbeat** state.  
2. When a heartbeat is detected, it moves to **Measuring Heartbeat**.  
3. If an irregular heartbeat is detected, the device transitions to **Irregular Heartbeat Detected**, turning on the button light to instruct the user to deliver a shock.  
4. Once the shock is delivered, the FSM moves to **Shock Delivered**, completing the cycle.  

## Simulation
This FSM was implemented in Verilog and tested using [EDA Playground](https://www.edaplayground.com/). Simulation outputs demonstrate correct state transitions and response to input signals.  

## Key Concepts Demonstrated
- Finite State Machine design  
- Hardware-level logic and control flow  
- Input/output signal handling  
- Timing and sequential logic
