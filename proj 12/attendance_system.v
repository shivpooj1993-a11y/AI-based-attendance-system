`timescale 1ns/1ps

module attendance_system (
    input  wire       clk,
    input  wire       reset,
    input  wire       recognized,
    input  wire [2:0] student_id,

    output reg        attendance_marked,
    output reg        already_present,
    output reg        invalid_student,
    output reg [2:0]  attendance_count
);

    // Attendance memory for 8 possible IDs.
    // Only IDs 1 to 4 are valid students.
    reg [7:0] attendance_memory;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            attendance_memory <= 8'b0;
            attendance_count  <= 3'b000;

            attendance_marked <= 1'b0;
            already_present   <= 1'b0;
            invalid_student   <= 1'b0;
        end

        else begin
            // Default status outputs
            attendance_marked <= 1'b0;
            already_present   <= 1'b0;
            invalid_student   <= 1'b0;

            if (recognized) begin

                // Check whether student ID is valid
                if ((student_id >= 3'd1) &&
                    (student_id <= 3'd4)) begin

                    // Check duplicate attendance
                    if (attendance_memory[student_id] == 1'b0) begin

                        attendance_memory[student_id] <= 1'b1;
                        attendance_count <= attendance_count + 1'b1;

                        attendance_marked <= 1'b1;
                    end

                    else begin
                        already_present <= 1'b1;
                    end
                end

                else begin
                    invalid_student <= 1'b1;
                end
            end
        end
    end

endmodule
