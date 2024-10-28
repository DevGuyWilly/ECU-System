# ECU-System

```mermaid
graph TD
    subgraph ECU Controller
        EC[ECU.Controller]
    end

    subgraph Sensors Package
        SS[SensorState Array]
        RSM[Read_Sensor_Majority]
    end

    subgraph Engine Package
        ES[StateEnabled]
        EA[AccessOpened]
        EE[Enable/Disable]
        EAC[OpenAccess/CloseAccess]
    end

    subgraph Console Package
        CP[PowerModeON]
        CA[AlarmON]
        CAC[AlarmCnt]
        CS[SafeModeON]
    end

    %% Sensor Data Flow
    SS -->|Input| RSM
    RSM -->|Temperature Reading| EC

    %% Engine Data Flow
    EC -->|Control| EE
    EE -->|Updates| ES
    EC -->|Control| EAC
    EAC -->|Updates| EA

    %% Console Data Flow
    CP -->|Input| EC
    EC -->|Control| CA
    EC -->|Updates| CAC
    EC -->|Control| CS

    %% State Feedback
    ES -->|Status| EC
    EA -->|Status| EC
    CA -->|Status| EC
    CS -->|Status| EC
