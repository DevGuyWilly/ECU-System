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
-- Filename:            log.adb
--
-- Description:         Provides logger that records state information on the
--                      component parts of the ECU at run-time.

pragma SPARK_Mode (Off);
with Text_IO, Sensors, Console, Engine, ECU;
use type Sensors.Sensor_Type;
package body Log is

   package Sensor_INOUT is new Text_IO.Enumeration_IO(Sensors.Sensor_Type);
   -- use Sensor_INOUT;
   package Integer_INOUT is new Text_IO.Integer_IO(Integer);
   -- use Integer_INOUT;

   Log_File: Text_IO.File_Type;
   
   procedure Update is

   begin
      -- Update log file
	  Text_IO.Put(Log_File, "| ");
      Integer_INOUT.Put(Log_File, Sensors.Read_Sensor(1), 4);
      Integer_INOUT.Put(Log_File, Sensors.Read_Sensor(2), 7);
      Integer_INOUT.Put(Log_File, Sensors.Read_Sensor(3), 7);
      if Sensors.Read_Sensor_Majority = -1 then
	 Text_IO.Put(Log_File, "  UNDEF   | ");
      else
	 Integer_INOUT.Put(Log_File, Sensors.Read_Sensor_Majority, 7);
	 Text_IO.Put(Log_File, "   | ");
      end if;
      if Console.isPowerSwitchON then
         Text_IO.Put(Log_File, "ON     |");
      else
         Text_IO.Put(Log_File, "  OFF  |");
      end if;
	  if Console.isEnabledSafeMode then
	     Text_IO.Put(Log_File, " ON    |");
      else
         Text_IO.Put(Log_File, "   OFF |");
      end if;
	  if Console.isEnabledAlarm then
         Text_IO.Put(Log_File, " ON    |");
      else
         Text_IO.Put(Log_File, "   OFF |");
      end if;
	  Integer_INOUT.Put(Log_File, Console.AlarmCnt, 5);
	  Text_IO.Put(Log_File, "  | ");
      if Engine.isEnabled then
         Text_IO.Put(Log_File, "ENABLED  ");
      else
         Text_IO.Put(Log_File, "-------  ");
      end if;
      if Engine.isAccessible then
         Text_IO.Put(Log_File, "------ |");
      else
         Text_IO.Put(Log_File, "CLOSED |");
      end if;
      Text_IO.New_Line(Log_File);            
   end Update;      
      
   procedure Open_File is
   begin
      Text_IO.Create(Log_File, Text_IO.Out_File, "log.dat");
	  Text_IO.Put_Line(Log_File,
               "|------------------------------------- ECU LOG ----------------------------------|");
	  Text_IO.Put_Line(Log_File,   
               "|                             |                                |                 |");		   
	  Text_IO.Put_Line(Log_File,
               "|           SENSORS           |             CONSOLE            |      ENGINE     |");		   
      Text_IO.Put_Line(Log_File,
               "|                             | POWER  | SAFE  | ALARM | ALARM |                 |");
	  Text_IO.Put_Line(Log_File,
               "| SEN-1  SEN-2  SEN-3  MAJOR  | SWITCH | MODE  | MODE  | COUNT |  STATE   ACCESS |");
	  Text_IO.Put_Line(Log_File,
               "|--------------------------------------------------------------------------------|");
	 -- Text_IO.New_Line(Log_File);            
   end Open_File;

   procedure Close_File is
   begin
      Text_IO.Put_Line(Log_File,
		       "|--------------------------------------------------------------------------------|");
      Text_IO.Put_Line(Log_File,
		       "Note that the ENGINE STATE is implicitly DISABLED if it is not explicitly shown   ");
      Text_IO.Put_Line(Log_File,
		       "above as ENABLED. Likewise, ENGINE ACCESS is implicity OPEN if it is not explicitly");
      Text_IO.Put_Line(Log_File,
		       "shown above as CLOSED.                                                             ");
      Text_IO.Close(Log_File);
   end Close_File;

end Log;
