`timescale 1ns/1ps

module attendance_system_tb;

    reg        clk;
    reg        reset;
    reg        recognized;
    reg [2:0]  student_id;

    wire       attendance_marked;
    wire       already_present;
    wire       invalid_student;
    wire [2:0] attendance_count;

    // Instantiate DUT
    attendance_system DUT (
        .clk(clk),
        .reset(reset),
        .recognized(recognized),
        .student_id(student_id),

        .attendance_marked(attendance_marked),
        .already_present(already_present),
        .invalid_student(invalid_student),
        .attendance_count(attendance_count)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task for student recognition
    task recognize_student;
        input [2:0] id;
        begin
            @(negedge clk);

            student_id = id;
            recognized = 1'b1;

            @(negedge clk);

            recognized = 1'b0;

            #2;

            $display(
                "Time=%0t | ID=%0d | Marked=%b | Already=%b | Invalid=%b | Count=%0d",
                $time,
                id,
                attendance_marked,
                already_present,
                invalid_student,
                attendance_count
            );
        end
    endtask

    initial begin

        // Create waveform file
        $dumpfile("attendance.vcd");
        $dumpvars(0, attendance_system_tb);

        // Initial values
        clk        = 1'b0;
        reset      = 1'b1;
        recognized = 1'b0;
        student_id = 3'b000;

        // Reset system
        #12;
        reset = 1'b0;

        // --------------------------------
        // Test 1: Student 1
        // --------------------------------
        recognize_student(3'd1);

        // --------------------------------
        // Test 2: Student 2
        // --------------------------------
        recognize_student(3'd2);

        // --------------------------------
        // Test 3: Student 1 again
        // Should be rejected as duplicate
        // --------------------------------
        recognize_student(3'd1);

        // --------------------------------
        // Test 4: Student 3
        // --------------------------------
        recognize_student(3'd3);

        // --------------------------------
        // Test 5: Student 4
        // --------------------------------
        recognize_student(3'd4);

        // --------------------------------
        // Test 6: Invalid Student 5
        // --------------------------------
        recognize_student(3'd5);

        // --------------------------------
        // Test 7: Student 2 again
        // Should be rejected as duplicate
        // --------------------------------
        recognize_student(3'd2);

        // Final result
        #10;

        $display("----------------------------------------");
        $display("FINAL ATTENDANCE COUNT = %0d", attendance_count);
        $display("----------------------------------------");

        // Check expected result
        if (attendance_count == 3'd4)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        #10;

        $finish;
    end

endmodule
