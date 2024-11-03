--
-- Author:              A. Ireland
-- Updateded:           25.7.2024
-- Description:         Implements the engine temperature sensors. Note that a single sensor reading is calculated using a majority vote algorithm.

pragma SPARK_Mode (On); 
package Sensors is
   
   pragma Elaborate_Body;

   -- Constants and types
   Init_Value:  constant Integer := 0;    -- Initial value for sensors
   Undef_Value: constant Integer := -1;   -- Undefined value for sensor readings
   
   subtype Sensor_Type is Integer range -1..200;
   subtype Sensor_Index_Type is Integer range 1..3;
   type Sensors_Type is array (Sensor_Index_Type) of Sensor_Type;
   
   -- Global variable to store the state of sensors
   SensorState: Sensors_Type := (others => Init_Value);  -- Initialize all sensors to Init_Value

   -- Write sensor values
   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type) with 
     Global => (In_Out => SensorState),
     Depends => (SensorState => (SensorState, Value_1, Value_2, Value_3)),
     Pre => (Value_1 >= Undef_Value and Value_1 <= 200) and
            (Value_2 >= Undef_Value and Value_2 <= 200) and
            (Value_3 >= Undef_Value and Value_3 <= 200),
     Post => (SensorState(1) = Value_1 and
              SensorState(2) = Value_2 and
              SensorState(3) = Value_3);
   
   -- Read a specific sensor's value
   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type with
     Global  => (Input => SensorState),
     Depends => (Read_Sensor'Result => (SensorState, Sensor_Index)),
     Pre => Sensor_Index in Sensor_Index_Type,
     Post => (Read_Sensor'Result = SensorState(Sensor_Index));

   -- Return the majority of the three sensor readings
   function Read_Sensor_Majority return Sensor_Type with
     Global  => (Input => SensorState),
     Depends => (Read_Sensor_Majority'Result => SensorState),
     Post => (for some I in Sensor_Index_Type => 
                Read_Sensor_Majority'Result = SensorState(I)) and then
             (for all I in Sensor_Index_Type => 
                (for some J in Sensor_Index_Type => 
                   SensorState(I) = SensorState(J) or 
                   Read_Sensor_Majority'Result = SensorState(I)));

end Sensors;

