pragma SPARK_Mode (On);

package body Engine is

   -- Procedure to enable the engine
   procedure Enable is
   begin
      if not StateEnabled then
         StateEnabled := True;
      end if;
   end Enable;

   -- Procedure to disable the engine
   procedure Disable is
   begin
      if StateEnabled then
         StateEnabled := False;
      end if;
   end Disable;

   -- Function to check if the engine is enabled
   function isEnabled return Boolean is
   begin
      return StateEnabled;
   end isEnabled;

   -- Procedure to open access to the engine
   procedure OpenAccess is
   begin
      if not AccessOpened then
         AccessOpened := True;
      end if;
   end OpenAccess;

   -- Procedure to close access to the engine
   procedure CloseAccess is
   begin
      if AccessOpened then
         AccessOpened := False;
      end if;
   end CloseAccess;

   -- Function to check if access to the engine is open
   function isAccessible return Boolean is
   begin
      return AccessOpened;
   end isAccessible;

end Engine;
