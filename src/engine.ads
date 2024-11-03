--
-- Author:              A. Ireland
-- Updated:             25.7.2024
-- Description:         Implements the engine actuator and access control subsystem.

pragma SPARK_Mode (On);
package Engine is
   pragma Elaborate_Body;

   -- Global variables for engine state and access control
   StateEnabled:  Boolean := False;    
   AccessOpened:  Boolean := False;   

   
   -- Enable the engine (set StateEnabled to True)
   procedure Enable
   with
     Global => (In_Out => StateEnabled),
     Depends => (StateEnabled => StateEnabled),
     Post => StateEnabled = True;

   -- Disable the engine (set StateEnabled to False)
   procedure Disable
   with
     Global => (In_Out => StateEnabled),
     Depends => (StateEnabled => StateEnabled),
     Post => StateEnabled = False;

   -- Check if the engine is enabled (return StateEnabled)
   function isEnabled return Boolean
   with
     Global => (Input => StateEnabled),
     Depends => (isEnabled'Result => StateEnabled),
     Post => isEnabled'Result = StateEnabled;
	 
   -- Open access to the engine (set AccessOpened to True)
   procedure OpenAccess
   with
     Global => (In_Out => AccessOpened),
     Depends => (AccessOpened => AccessOpened),  
     Post => AccessOpened = True;

   -- Close access to the engine (set AccessOpened to False)
   procedure CloseAccess
   with
     Global => (In_Out => AccessOpened),
     Depends => (AccessOpened => AccessOpened), 
     Post => AccessOpened = False;

   -- Check if access to the engine is open (return AccessOpened)
   function isAccessible return Boolean
   with
     Global => (Input => AccessOpened),
     Depends => (isAccessible'Result => AccessOpened),
     Post => isAccessible'Result = AccessOpened;

end Engine;
