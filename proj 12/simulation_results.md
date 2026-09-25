Simulation Results
Simulation Environment

The design can be simulated using:

Icarus Verilog

GTKWave

Compilation

Run:

iverilog -o attendance_sim src/attendance_system.v testbench/attendance_system_tb.v

Execute Simulation
vvp attendance_sim


The simulation generates:

attendance.vcd

View Waveform
gtkwave attendance.vcd

Test Cases
Test Case	Student ID	Expected Result
TC1	1	Attendance marked
TC2	2	Attendance marked
TC3	1	Duplicate rejected
TC4	3	Attendance marked
TC5	4	Attendance marked
TC6	5	Invalid student
TC7	2	Duplicate rejected
Expected Output
ID=1 → Attendance Marked
ID=2 → Attendance Marked
ID=1 → Already Present
ID=3 → Attendance Marked
ID=4 → Attendance Marked
ID=5 → Invalid Student
ID=2 → Already Present


Final attendance:

ATTENDANCE COUNT = 4


Therefore:

TEST PASSED

Expected Waveform

The important signals to observe in GTKWave are:

clk
reset
recognized
student_id
attendance_marked
already_present
invalid_student
attendance_count


The waveform should show:

Student 1 → count = 1
Student 2 → count = 2
Student 1 → count remains 2
Student 3 → count = 3
Student 4 → count = 4
Student 5 → count remains 4
Student 2 → count remains 4

Result

The simulation verifies that the attendance controller:

Accepts valid student IDs.

Marks attendance only once.

Rejects duplicate attendance.

Rejects invalid student IDs.

Maintains the correct attendance count.

Resets the attendance memory correctly.