AI-Based Attendance System
Overview

The AI-Based Attendance System is a digital attendance controller designed to automatically record the attendance of recognized students.

The proposed system can be connected to an AI-based face-recognition module. Once a student is recognized, the AI module provides the student's ID to the attendance controller. The Verilog module then checks whether the student is valid and whether attendance has already been recorded.

The system prevents duplicate attendance and maintains an attendance count.

Features

Student identification through an AI/recognition interface

Automatic attendance marking

Duplicate attendance prevention

Invalid student rejection

Attendance counter

Reset functionality

Synthesizable Verilog design

Verilog testbench for functional verification

Simulation waveform support

System Architecture
       Camera / AI Face Recognition
                  |
                  v
          Recognized Student ID
                  |
                  v
        +----------------------+
        | Attendance Controller|
        +----------------------+
             |            |
             v            v
      Student Validation  Attendance Memory
                            |
                            v
                     Attendance Count

Working Principle

The AI/face-recognition system identifies a student.

The recognized student's ID is provided to the Verilog attendance controller.

The controller checks whether the ID belongs to a valid student.

If the student is valid and has not already been marked present, attendance is recorded.

If the same student is detected again, the controller does not increase the attendance count.

If an invalid student ID is received, attendance is rejected.

Reset clears all attendance records and returns the count to zero.

Example

Assume four registered students:

Student ID	Student
1	Student 1
2	Student 2
3	Student 3
4	Student 4

If the recognition system produces:

1 → 2 → 1 → 3 → 4 → 5


The attendance controller produces:

Student 1 → Present
Student 2 → Present
Student 1 → Already Present
Student 3 → Present
Student 4 → Present
Student 5 → Invalid


Final attendance count:

4

Inputs
Signal	Width	Description
clk	1 bit	System clock
reset	1 bit	Clears attendance
recognized	1 bit	Indicates that a student has been recognized
student_id	3 bits	ID received from AI module
Outputs
Signal	Width	Description
attendance_marked	1 bit	Indicates new attendance
already_present	1 bit	Indicates duplicate attendance
invalid_student	1 bit	Indicates invalid student ID
attendance_count	3 bits	Number of students present
Registered Students

The example design supports four students:

Student ID 1
Student ID 2
Student ID 3
Student ID 4


IDs 0, 5, 6, and 7 are treated as invalid.

Tools Required

The project can be simulated using:

Icarus Verilog

GTKWave

ModelSim/QuestaSim

Vivado Simulator

Simulation

Compile the design and testbench:

iverilog -o attendance_sim src/attendance_system.v testbench/attendance_system_tb.v


Run the simulation:

vvp attendance_sim


This generates:

attendance.vcd


Open the waveform:

gtkwave attendance.vcd

Expected Simulation

The testbench verifies:

Reset operation

Valid student recognition

Attendance marking

Duplicate student detection

Invalid student detection

Multiple students

Attendance count

Expected final attendance count:

4

Future Improvements

The project can be extended by adding:

Real-time face recognition

ESP32/Raspberry Pi camera interface

FPGA implementation

LCD/OLED attendance display

SD-card/database storage

Wi-Fi-based attendance upload

Date and time recording

Cloud attendance dashboard

More student IDs

Conclusion

This project demonstrates how an AI recognition system can be combined with a digital attendance controller. The AI module identifies the student, while the Verilog controller validates the student and records attendance without allowing duplicate entries.

Project Structure
AI-Based-Attendance-System/
│
├── README.md
│
├── src/
│   └── attendance_system.v
│
├── testbench/
│   └── attendance_system_tb.v
│
└── simulation/
    └── simulation_results.md