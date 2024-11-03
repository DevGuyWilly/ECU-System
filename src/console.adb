pragma SPARK_Mode (On);
package body Console is
   -- Procedure to enable the alarm
   procedure EnableAlarm is
   begin
      if not AlarmON then
         AlarmCnt := AlarmCnt + 1;
      end if;
      AlarmON := True;
   end EnableAlarm;
   -- Procedure to disable the alarm
   procedure DisableAlarm is
   begin
      if AlarmON then
         AlarmON := False;
      end if;
   end DisableAlarm;

   -- Function to check if the alarm is enabled
   function isEnabledAlarm return Boolean is
   begin
      return AlarmON;
   end isEnabledAlarm;

   -- Procedure to enable safe mode
   procedure EnableSafeMode is
   begin
      if not SafeModeON then
         SafeModeON := True;
      end if;
   end EnableSafeMode;
   -- Procedure to disable safe mode
   procedure DisableSafeMode is
   begin
      if SafeModeON then
         SafeModeON := False;
      end if;
   end DisableSafeMode;
   -- Function to check if safe mode is enabled
   function isEnabledSafeMode return Boolean is
   begin
      return SafeModeON;
   end isEnabledSafeMode;
   -- Procedure to turn on the power
   procedure PowerON is
   begin
      if not PowerModeON then
         PowerModeON := True;
      end if;
   end PowerON;
   -- Procedure to turn off the power
   procedure PowerOFF is
   begin
      if PowerModeON then
         PowerModeON := False;
      end if;
   end PowerOFF;
   -- Function to check if the power switch is on
   function isPowerSwitchON return Boolean is
   begin
      return PowerModeON;
   end isPowerSwitchON;
end Console;
