pragma SPARK_Mode (On);
with Engine, Console, Sensors;

package ECU is

   pragma Elaborate_Body;
   -- Constants for safety and access thresholds
   Safety_Threshold: constant Integer := 130;
   Access_Threshold: constant Integer := 30;
   -- Global state variables (e.g., last temperature reading)
   Last_Temp: Integer := 0;  -- To store the last temperature reading for SC-1 check
   -- Controller procedure (manages engine state and access)
   procedure Controller with
       Global => (
                  In_Out => (Last_Temp, Engine.StateEnabled, Console.AlarmCnt,
                             Engine.AccessOpened, Console.AlarmON, Console.SafeModeON),
                  Input  => (Console.PowerModeON, Sensors.SensorState)
                 ),
       Depends => (
        Last_Temp => Sensors.SensorState,
        Engine.StateEnabled => (Engine.StateEnabled, Sensors.SensorState, Console.PowerModeON, Last_Temp),
        Console.AlarmCnt => (Console.AlarmCnt, Sensors.SensorState, Last_Temp, Console.AlarmON),
        Console.AlarmON => (Console.AlarmON, Last_Temp, Sensors.SensorState, Console.AlarmCnt),
        Console.SafeModeON => (Console.SafeModeON, Sensors.SensorState),
        Engine.AccessOpened => (Engine.AccessOpened, Sensors.SensorState)
       ),
              Pre => 
         -- Ensure sensor readings are within valid range
         (for all I in Sensors.Sensor_Index_Type => 
            Sensors.SensorState(I) in Sensors.Undef_Value .. 200) and
         -- Ensure AlarmCnt is non-negative
         --Console.AlarmCnt >= 0,
         Console.AlarmCnt <= Integer'Last - 1,
       Post =>
         -- Temperature condition
         (Last_Temp in Sensors.Undef_Value .. 200) and then
         -- Engine safety condition
         (if Last_Temp > Safety_Threshold and Last_Temp'Old > Safety_Threshold and Last_Temp > Last_Temp'Old then
            not Engine.StateEnabled) and then
         -- Access control
         (if Last_Temp >= Access_Threshold then not Engine.AccessOpened) and then
         -- Alarm condition (updated)
         (if Last_Temp > Safety_Threshold and Last_Temp'Old > Safety_Threshold and Last_Temp > Last_Temp'Old then
            Console.AlarmON) and then
         -- Safe mode condition
         (Engine.AccessOpened = Console.SafeModeON) and then
         -- Alarm count condition
         (if Console.AlarmON and not Console.AlarmON'Old then 
            Console.AlarmCnt = Console.AlarmCnt'Old + 1
          else 
            Console.AlarmCnt = Console.AlarmCnt'Old);
end ECU;
