pragma SPARK_Mode (On);

package body ECU is
   -- Procedure to manage engine control and access based on sensor readings
   procedure Controller is
      Current_Temp: Integer := Sensors.Read_Sensor_Majority;  -- Read the majority sensor value
   begin
      -- SC-1: Check if the engine overheats and disable it
      if Current_Temp > Safety_Threshold and Last_Temp > Safety_Threshold then
         if Current_Temp > Last_Temp then
            Engine.Disable;
            if Console.AlarmCnt < Integer'Last then
               Console.EnableAlarm;
            end if;
         end if;
      else
         Console.DisableAlarm;
      end if;

      -- SC-2: Close access if the temperature is not less than the access-threshold
      if Current_Temp >= Access_Threshold then
         Engine.CloseAccess;
         Console.DisableSafeMode;
      else
         Engine.OpenAccess;
         Console.EnableSafeMode;
      end if;

      -- Power switch logic should be separate from access control
      if Console.PowerModeON and Current_Temp < Safety_Threshold then
         if not Engine.StateEnabled then
            Engine.Enable;
         end if;
      else
         if Engine.StateEnabled then
            Engine.Disable;
         end if;
      end if;

      -- Update the last temperature reading for future comparisons
      Last_Temp := Current_Temp;
   end Controller;
end ECU;
