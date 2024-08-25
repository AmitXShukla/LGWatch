# LG.Watch.Out

`while you're watching LG, let LG watch out for you.`

## Objective
An AI-powered live alert LG webOS app, which reads, understands with advance AI Reasoning capabilities and watch out for you.

```mermaid
---
config:
  sankey:
    showValues: false
---
sankey-beta

%% source,target,value
 News, LGWatch, 25
 Commuinity, LGWatch, 25
 Alerts, LGWatch, 25
 Recommendations, LGWatch, 25
 Temp, Weather, 25
 Flood, Weather, 25
 Air, Weather, 25
 Quake, Weather, 25
 Weather, LGWatch, 35
 Smoke, Sensors, 25
 Siren, Sensors, 25
 break-in, Sensors, 25
 moisture, Sensors, 25
 Sensors, LGWatch, 35
 Cameras, Images, 20
 Water Leaks, Images, 20
 Sprinkler, Images, 20
 Littering, Images, 20
 Images, LGWatch, 30
 LGWatch, Alarm, 20
 LGWatch, Neighbor, 20
 LGWatch, 911, 20
 LGWatch, Friends, 20
 LGWatch, Locals, 20
```

click here for a live [demo](https://amitxshukla.github.io/LGWatch/) and [video]().

## Tools
	Backend: Firebase
	UI/UX: Flutter
	AI: GROQ, BYOA (bring your own AI, Anthropic, Gemini, OpenAI ..)
	Platform: LGWebOS

## Process flow

```mermaid
stateDiagram-v2
        direction LRstateDiagram-v2
        [*] --> signup
        signup --> email
        signup --> social
        email --> login
        social --> login
        login --> Settings
        dark_Mode --> Settings
        multi_Lang --> Settings
        ph_email_loc_contacts_pswd --> Settings
        devices --> Personal
        car --> devices
        cameras --> devices
        motion --> devices
        CO --> devices
        login --> Community
        login --> Personal
        Community --> LG.Watch.AI
        Personal --> LG.Watch.AI
        LG.Watch.AI --> Alert
        Alert --> Notification
        Settings --> Notification
        
%% Define classes for coloring
    classDef red fill:#ff8,stroke:#333,stroke-width:2px;
    classDef green fill:#8fa,stroke:#333,stroke-width:2px;
    classDef blue fill:#f66,stroke:#333,stroke-width:2px;
    classDef orange fill:#f92,stroke:#333,stroke-width:2px;
    classDef danger fill:#99f,stroke:#333,stroke-width:2px;
    classDef yellow fill:#56f,stroke:#333,stroke-width:2px;
    classDef brown fill:#fe3,stroke:#333,stroke-width:2px;
    classDef neil fill:#1ff,stroke:#333,stroke-width:2px;
    classDef peil fill:#cff,stroke:#333,stroke-width:2px;

    %% Apply classes to states
    class signup green
    class email green
    class social green
    class login blue
    class Rider orange
    class Personal orange
    class Community orange
    class Gemini danger
    class Alert brown
    class dark_Mode neil
    class multi_Lang neil
    class ph_email_loc_contacts_pswd neil
    class devices neil
    class car peil
    class cameras peil
    class motion peil
    class CO peil
    class Settings brown
    class Notification green
```

## sample App images
![image_1](./assets/images/banner_1.png)
![image_1](./assets/images/banner_2.png)
![image_1](./assets/images/banner_3.png)
![image_1](./assets/images/banner_4.png)