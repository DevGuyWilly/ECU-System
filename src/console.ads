--
-- Author:              A. Ireland
-- Updated:             25.7.2024
-- Description:         Implements the console subsystem.

pragma SPARK_Mode (On); 
package Console is
   pragma Elaborate_Body;
   -- Global variables
   AlarmON:     Boolean := False;    -- Initialize as alarm off
   AlarmCnt:    Integer := 0;        -- Initialize counter
   PowerModeON: Boolean := False;    -- Initialize power mode off
   SafeModeON:  Boolean := False;    -- Initialize safe mode off
   -- Enable the alarm and increment the alarm count
   -- Enable the alarm and increment the alarm count
  procedure EnableAlarm with
     Global => (In_Out => (AlarmON, AlarmCnt)),
     Depends => (AlarmON => null,
                 AlarmCnt => (AlarmCnt, AlarmON)),
     Pre => AlarmCnt < Integer'Last,
     Post => ((AlarmON = True) and 
              (if (AlarmON'Old = False) then AlarmCnt = AlarmCnt'Old + 1
               else (AlarmCnt = AlarmCnt'Old)));
   -- Disable the alarm (set AlarmON to False)
   procedure DisableAlarm with
     Global => (In_Out => AlarmON),
     Depends => (AlarmON => AlarmON),
     Post => AlarmON = False;
   -- Check if the alarm is enabled
   function isEnabledAlarm return Boolean with
     Global => (Input => AlarmON),
     Depends => (isEnabledAlarm'Result => AlarmON),
     Post => isEnabledAlarm'Result = AlarmON;
   -- Enable safe mode (set SafeModeON to True)
   procedure EnableSafeMode with
     Global => (In_Out => SafeModeON),
     Depends => (SafeModeON => SafeModeON),
     Post => SafeModeON = True;
   -- Disable safe mode (set SafeModeON to False)
   procedure DisableSafeMode with
     Global => (In_Out => SafeModeON),
     Depends => (SafeModeON => SafeModeON),
     Post => SafeModeON = False;
   -- Check if safe mode is enabled
   function isEnabledSafeMode return Boolean with
     Global => (Input => SafeModeON),
     Depends => (isEnabledSafeMode'Result => SafeModeON),
     Post => isEnabledSafeMode'Result = SafeModeON;
   -- Turn on the power (set PowerModeON to True)
   procedure PowerON with
     Global => (In_Out => PowerModeON),
     Depends => (PowerModeON => PowerModeON),
     Post => PowerModeON = True;
   -- Turn off the power (set PowerModeON to False)
   procedure PowerOFF with
     Global => (In_Out => PowerModeON),
     Depends => (PowerModeON => PowerModeON),
     Post => PowerModeON = False;
   -- Check if the power switch is on
   function isPowerSwitchON return Boolean with
     Global => (Input => PowerModeON),
     Depends => (isPowerSwitchON'Result => PowerModeON),
     Post => isPowerSwitchON'Result = PowerModeON;
end Console;


