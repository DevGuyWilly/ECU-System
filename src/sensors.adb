pragma SPARK_Mode (On);
package body Sensors is
   -- Procedure to write sensor values
   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type) is
   begin
      -- Assign provided values to sensor state
      SensorState(1) := (if Value_1 = Init_Value then Init_Value else Value_1);
      SensorState(2) := (if Value_2 = Init_Value then Init_Value else Value_2);
      SensorState(3) := (if Value_3 = Init_Value then Init_Value else Value_3);
   end Write_Sensors;
   -- Function to read a specific sensor's value
   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type is
   begin
      return SensorState(Sensor_Index);
   end Read_Sensor;
   -- Function to calculate the majority value of the three sensors
   function Read_Sensor_Majority return Sensor_Type is
      S1 : constant Sensor_Type := SensorState(1);
      S2 : constant Sensor_Type := SensorState(2);
      S3 : constant Sensor_Type := SensorState(3);
   begin
      if S1 = S2 or S1 = S3 then
         return S1;
      elsif S2 = S3 then
         return S2;
      else
         return S1;  -- If all differ, return the first one
      end if;
   end Read_Sensor_Majority;
end Sensors;

