-- Author:              A. Ireland
--
-- Address:             School Mathematical & Computer Sciences
--                      Heriot-Watt University
--                      Edinburgh, EH14 4AS
--
-- E-mail:              a.ireland@hw.ac.uk
--
-- Last modified:       25.7.2024
--
-- Filename:            test_ecu.adb
--
-- Description:         Test harness for the ECU. Note that test data and results
--                      are managed via the Env and Log packages respectively.

pragma SPARK_Mode (Off);
with Env, Log, ECU, Sensors, Console, Engine;
use type Sensors.Sensor_Type;
procedure Test_ECU is
begin
   Env.Open_File;
   Log.Open_File;
   loop
      exit when Env.At_End;
      Env.Update;
      Log.Update;
      ECU.Controller;
      Log.Update;
   end loop;
   Env.Close_File;
   Log.Close_File;
end Test_ECU;
