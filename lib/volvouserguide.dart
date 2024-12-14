import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class volvouserguides extends StatelessWidget {
  // Define the headings and questions with their explanations
  final Map<String, List<Map<String, String>>> headingQuestions = {
    'Lubrication': [
      {
        'question': 'What is the purpose of motor oil in your XC90?',
        'explanation':
            'Motor oil takes care of the movable pieces of your car’s engine. It reduces wear, noise and saves energy, which minimizes maintenance costs. The engine lubrication is the most important aspect you should pay attention to if you want to keep it working in optimal conditions. If your car does not have enough oil, it may get irreversibly damaged in a matter of minutes. Even if you repair it, the cost will be extremely high. It also “softens” friction between the engine components, preventing metal seizure. Good lubrication reduces wear, noise, and saves energy by diminishing friction.'
      },
      {
        'question': 'Why do I have to change motor oil?',
        'explanation':
            'Your XC90 needs oil changes based on the oil type: Mineral oil (3,000 miles), Semi-synthetic oil (5,000 to 6,000 miles), or Synthetic oil (6,000 to 9,000 miles). Even if the mileage isn’t reached, change the oil annually. Synthetic oil is the best for your car as it reduces frequency of changes and better maintains engine health. Always follow the instructions on the oil container. Also, remember to change the oil filter with each oil change to ensure clean oil.'
      },
    ],
    'Fuel': [
      {
        'question': 'What are biofuels?',
        'explanation':
            'Biodiesel is usually used as an additive to Diesel. Ethanol is only used in gasoline.\n\nThere are two types of biofuels: biodiesel and ethanol (or bioethanol).\n\nNowadays, biodiesel is used as an additive in Diesel cars because of its great properties as a lubricant and its low toxic emission rates.\n\nIts proportion in the blend varies until the blend has a 100% of biodiesel. The name of these blends includes a “B” followed by the percentage of biodiesel they contain. For example, B15 will have 15% biodiesel while B75 will have 75% biodiesel.\n\nThe same thing happens with ethanol and gasoline, but in this case, they are usually blended to reduce fuel costs by using up to 85% of ethanol. In these cases, this blend will include an “E” followed by the ethanol percentage that it has. For example, E30 or E85.\n\n⚠️ You must be very careful because the engine of your XC90 may not be made to work with this type of fuel. Engines that can take it are named Flex, as indicated in the owners manual. In Brazil, this is the most used type of fuel.\n\nBiofuels can usually be identified by their green tags in gas stations.'
      },
      {
        'question': 'What types of fuel exist?',
        'explanation':
            'Gasoline and diesel fuels are the main types of fuel, and they must never be mixed.\n\nGenerally, car fuels are divided into two big groups: gasoline (benzene) and diesel. Both are derived from petroleum and formed by hydrocarbons (hydrogen and carbon molecules).\n\n⚠️ The main rule is that you must only use diesel in Diesel engines and gasoline in spark-ignition engines (Otto cycle engines). Using the wrong fuel will damage your engine.\n\nIn a Diesel engine, diesel burns because of compression, whereas in an Otto engine, gasoline burns due to a spark from the spark plug. Diesel is more oily and burns slower, while gasoline is more volatile and burns faster.\n\nDiesel engines are more efficient but emit more harmful exhaust smoke, so they undergo additional processes to comply with pollution laws, which makes them more expensive.\n\nOther types of fuel include natural gas, which is mostly used in countries like Argentina, Brazil, and Colombia, though it reduces the car’s performance and autonomy.\n\nBiofuels, like biodiesel and ethanol, are also commonly used as additives to diesel and gasoline, respectively. Sustainable energy fuels, like hydrogen and solar power, are the least common but also the most expensive.'
      },
    ],
    'Other guides': [
      {
        'question': 'What light bulbs fit your XC90?',
        'explanation':
            'In short:\n\nIf one of your XC90‘s bulbs burned out and you want to know which one you should buy to replace it, you can remove it and take it to an auto part store, or you can check the maintenance section found in the owner\'s manual.\n\nIf you replaced the bulb but it is still not working, you should check the fuses.\n\nYour XC90 has bulbs that illuminate both the outside and the inside of the car. Since headlamps are more complex, there are many types. They are the ones that illuminate the road ahead without dazzling the other drivers. Brake lights are only there to be seen at a sensible distance by the drivers behind you, and their purpose is to light up when you press the brake pedal.\n\nGenerally, changing these bulbs is easy, and you can do it yourself. Cars have a different lighting system from that of a house since they are guaranteed to keep working despite the vehicle’s vibrations. You only have to make sure that their pigtail wire has been properly connected. You will know they have been connected properly because there is only one way they can be connected.\n\nYou should have a spare bulb in your XC90 if you are about to go on a road trip. Even if a bulb has a lifespan of several years, they are cheap and it never hurts to be careful.\n\n**LED lamps**\nThe main advantage of LED lamps is their efficiency: they produce a lot of light, and they draw less electrical energy (up to 80% less). Moreover, their lifespan is 25 times longer than the lifespan of a halogen lamp. LED lamps are instantly on and, since the component that produces light is relatively small, these lamps can be created in any shape or form. They are made of semiconductor materials enclosed in a small, plastic shell and only one lamp may produce different colors.\n\nThere are a lot of high-end brands that use LED technology for their products, but their usage of fixed LED light panels makes it almost impossible for them to be changed without having to visit an authorized car dealer.\n\n**Incandescent lamps**\nThey are the oldest ones, they consume a lot of energy and create a lot of heat. They are made up of a metallic filament which is protected by a transparent glass bulb. When the electricity goes through the filament, it turns bright red and it produces light. Nowadays, these lamps are still used to illuminate car interiors, dashboard lights, brake lights, direction-indicator lights, and front position lights, since these lights do not need to be too powerful. They have different watts, sizes, and shapes according to their usage. They may have 1 or 2 filaments (just like the brake lights).\n\n**Halogen lamps**\nThey are the enhanced version of incandescent lamps. The light they produce is stronger and whiter. They work the same way; the only difference is that the glass bulb encloses halogen gas, which improves the filament’s output and, therefore, also enhances its lifespan. For these reasons, these lamps are more efficient, and small halogen lamps may be powerful.\n\nThese lamps may have different amounts of filaments, their filaments may be placed in different positions, and the shape of their bulbs may be different. The most common ones are these:\n\n- **H1 lamps:** They are used in fog lamps and high beam lights. They only have one filament placed longitudinally and they have a compact shape. There are 55, 70 and, 100-W H1 lamps.\n- **H3 lamps:** They are usually used in fog lamps and long-range lights, and they have only one filament, which is placed transversely. They are the most compact ones. They only include a small wire to connect them. There are 55, 70 and 100-W H3 lamps.\n- **H4 lamps:** They are the most used in headlamps because they can also be used as dipped beam headlights and high beam lights, which saves space. They have two filaments, and they are bigger than the other types of lamps. There are usually 55/60, 70/75, and 90/100-W H4 lamps (for crossings/highways).\n- **H7 lamps:** They are mainly used in fog lamps. They only have one linear filament, and they are somewhat bigger than H1 and H3 lamps.\n\n**Xenon lamps**\nThey are the brightest ones, and the light they produce is whiter than the one made by halogen lamps. Their downside is that the electrical energy needed to turn these lamps on must be high (30,000 V). Their arc needs a high current, so they need auxiliary equipment called reactance, which is in charge of controlling the electrical energy of the lamp. If you are thinking of switching to Xenon’s lamps, an auto mechanic should do it for you.\n\nThese lights take one minute to reach their maximum power. The good thing is that once you turn these lights on, they consume less electricity than halogen lamps, generate less heat and their lifespan is way longer. They are more expensive than the other lamps.\n\nRegarding their structure, they do not have filaments. They have two electrodes, separated by a few millimeters protected by a glass bulb where there is high-pressure Xenon gas. An electrical arc that produces light is created between these two electrodes.'
      },
      {
        'question':
            'What do the technical specifications of your XC90’s engine mean?',
        'explanation':
            'Even though all engines are very similar when you look at them, there are many different types. We will now show you what the most usual technical specifications that you can find in the technical datasheet of your XC90 mean.\n\n**Gasoline or Diesel Engines**\nThis is the main difference between engines. Engines that need Diesel have incandescent spark plugs that only work when the car starts. Once the engine is running, the fuel ignites by itself since it is compressed inside the cylinders thanks to the high temperature it reaches.\nOn the other hand, gasoline engines work thanks to the spark constantly created by the spark plugs. This means that they work all the time the engine is running.\nAnother difference between these two engines is that Diesel engines are generally heavier, and their structure is more robust.\n\n**Number of Cylinders**\nIt is the number of cylinders inside the engine. The engine power is generated in the cylinders because that is where the pistons are. For this reason, the more cylinders the engine has, the more its power will be. This also means that the engine will be bigger and heavier. It is also important to notice that if there are a lot of cylinders, the engine will consume more fuel.\n\n**Bore/stroke ratio**\nThese are the piston’s measurements, and they can be expressed in centimeters or inches. They indicate the cylinder diameter (bore) and the longitudinal displacement (stroke) that the piston does inside the cylinder when the engine is running. These measurements allow us to measure the “displaced volume” by the piston. If the diameter is wide and the piston has a short stroke, the engine will be fit for sports cars. In other words, the revolutions per minute (RPMs) will be high.\n\n**Engine displacement**\nIt is the total available volume in the engine cylinders. It is calculated by multiplying the stroke length, the bore, and the number of cylinders.\nDepending on the country, it may be expressed in liters (1.6 L, 2.0 L, 3.6 L), or in cubic inches (98, 110, 250, 510 CI).\nGenerally, the higher the engine displacement is, the more power your car will have, but the higher its fuel consumption will be.\n\n**Cylinder arrangement**\n- **In-line arrangement:** nowadays, it is hard to find engines with more than 6 in-line cylinders because they take up too much space under the hood.\n- **V-type arrangement:** They are more compact and create fewer vibrations, but they can only be used with an even number of cylinders (V6, V8, V10, etc.).\n- **Opposed arrangement:** they are flat and not frequently used because their manufacture and maintenance are very demanding. Moreover, like the V-type arrangement, they can only be used with an even number of cylinders.\n\n**Valvetrain type: SOHC and DOHC**\n- **SOHC (single overhead camshaft):** It only has one camshaft placed in the cylinder head. Only one camshaft controls all the engine’s valves. They generally have more power if there are low RPMs. The camshaft is in charge of opening and closing the engine’s valves.\n- **DOHC (double overhead camshaft):** It has two camshafts placed in the cylinder head. One camshaft controls the admission valve while the other controls the escape valve. The performance of these engines is usually better if the RPMs are high. Moreover, its parts are usually lighter and can move faster.\n\n**Compression ratio**\nIt is the measurement of how much the volume of the air-fuel mixture can be compressed inside of the cylinder. The higher this number is, the higher the engine power will be. For example, if there is an 8:1 ratio, this means that the mixture will be reduced to one octave of its original volume.\nGenerally, compression ratios are between 8:1 and 12:1 for gasoline engines.\n\n**Naturally aspirated or turbo engines**\nA naturally aspired engine means that the engine draws air directly through an air intake. In turbocharged cars, on the other hand, the turbocharger injects air by forcing it into the engine. The advantage of using turbochargers is that, in small engines, the power increases because it is possible to inject more air and fuel into the cylinders.\n\n**Torque**\nTorque is the power generated by the engine to move the car. It is the measure of the engine’s ability to rotate and perform useful work, as opposed to horsepower, which is related to how fast the engine is rotating. For example, a diesel engine will likely produce more torque than a gasoline engine.\n\n**Power**\nPower is the ability of an engine to perform work and is measured in horsepower (HP) or kilowatts (kW). The more horsepower an engine has, the more quickly it can accelerate.\n\n**RPM (Revolutions Per Minute)**\nThis measure is the number of times the engine rotates in one minute. Higher RPMs generally correlate with greater power, which means the engine is working harder, and the car can accelerate faster.'
      }
    ],
    'Warning lights': [
      {
        'question': 'What is the immobilizer or anti-theft system on a XC90?',
        'explanation':
            'In a few words:\n\nThe immobilizer or anti-theft system verifies that the key used to turn the engine on is the correct one. If the key is not the correct one, this system blocks different actions to prevent the car from starting.\n\nWhen this system is activated on your XC90 a warning light such as the one below will turn on:\n\nWhat happens when the immobilizer is activated on a XC90?\nIf the car does not recognize the signal of the key, two things may happen:\n\n- The engine may turn on for a few seconds and then it will stop.\n- The engine will not turn on.\n\nThe car\'s computer will disable the fuel pump, the ignition coil and/or the injectors, depending on the electronic immobilizer system. Moreover, if the car has a diesel engine, this system will also block the “stop” relay, which will prevent the fuel from being injected into the engine. Sometimes, this system will also block the steering column which will lock the steering wheel.\n\nWhy is the immobilizer activated on a XC90?\nThe main reason is because the car\'s computer does not recognize or does not detect the signal sent by the chip which is inside the key. The most common reasons as to why this happens are:\n\n⚠️ Low battery of the key or the remote control: the chip will not send the signal.\n⚠️ The chip of the key is damaged or has been decoded: it may happen if the key is damaged or if it gets wet.\n⚠️ Faulty electrical wiring: it may happen both in the antenna as well as in the immobilizer unit or the engine\'s computer.\n\nLess frequent causes:\n\n- Damaged antenna: due to electrical reasons, the antenna may stop working.\n- Lack of synchronization of the immobilizer unit.\n- Electronic failure: any of the contacts or internal electronic components of the module or the computer may get damaged.\n\nHow can I fix an immobilizer problem on a XC90?\nSince this system is delicate, it is advisable to leave this process in the hands of a specialist.\n\nFirst, the technician will scan the car with the adequate diagnosis equipment to check if the problem is actually related to the immobilizer system.\n\nIf that is the case, the technician will have to identify the cause among the causes already mentioned and then see if this problem can be solved via programming or if it is necessary to replace any of the components.\n\nHow does the immobilizer or anti-theft system or your XC90 work?\nEach original key has a chip inside which sends a signal when it gets close to the ignition switch. Inside the switch there is an antenna which receives this signal and sends it to the car\'s computer. If the signal is the same as the one the car has saved, then the driver will be allowed to start the car.\n\nThe immobilizer is automatic and manual activation is never needed. Remember that you can check if your car has this system or not in your owner\'s manual.'
      },
      {
        'question': 'What does the check engine light of your XC90 mean?',
        'explanation':
            'In a few words:\n\nIt’s a warning light that alerts the driver about any type of engine problems. In some vehicles, the light comes in two colors: yellow to indicate minor problems and red to indicate serious problems.\n\nThe check engine light is part of every vehicle that has an electronic engine management system, either an integral one or only for fuel ignition. Its function is to alert the driver about any type of engine problems.\n\nWhile driving, the computer of your XC90 (ECU o PCM) monitors air/fuel supply and exhaust gases in order to verify that the engine is working properly. If any problem is detected, the check engine Light of your dashboard will turn on.\n\nDepending on the type of failure, the light may either blink or remain constantly lit. If the problem is serious, your XC90 will be in a “emergency” state that will prevent you from accelerating the engine above certain speed limit, forcing you to drive at low speed in order to avoid further damages.\n\nThe check engine light can alert you about some failures but not all of them. It will depend on how complex the electronic control unit of your XC90 is.\n\nTo properly diagnose the failure of your XC90, it is important to have a suitable scanner that is compatible with the brand and model of your car. The scanner will show the engine fault code that the computer has detected, which is related to a certain problem that is affecting the engine.\n\nThe most common check engine light causes of your XC90 and how to detect them:\n\n- Ignition cylinder problems: irregular engine running.\n- Problem with exhaust gas oxygen sensor (Lambda probe): irregular engine running, there are misfires when accelerating abruptly or driving at low revs. It may be caused by a sensor fault or a failure of the catalytic converter.\n- Problems with the engine intake (air or fuel): engine running may be rough or irregular.\n- Problems with the electrical system: sometimes it is easy to identify the cause but other times it may take days of testing to find the source of the problem.\n- Sensor malfunction: It affects engine running or stops running completely.\n- Wiring problems: contact failure, cut wires, short circuits.\n\nIndicator status and severity:\n\n- The check engine light turns on when you switch on the ignition key and then it turns off: It’s normal. It’s used to verify that the light itself is working and the bulb is not burned out.\n- The check engine light blinks and then it turns off (cyclically): This indicates that the car had a problem at one point but it is not happening at the moment.\n- The check engine light is steady: This indicates that there is a problem but is not so serious as to stop driving your vehicle.\n- The check engine light blinks continuously: This indicates that there is a critical problem. Usually, you should stop driving your vehicle.'
      }
    ],
    'Spark plugs': [
      {
        'question': 'How do I change the spark plugs of my XC90?',
        'explanation':
            'Follow these six steps to replace the spark plugs of your XC90:\n\n⚠️ Before you begin, make sure that the engine of your XC90 is off and cold.\n\nYou need a spark plug wrench like the one shown in the following picture. These tools are particularly longer than regular wrenches and, some of them are more flexible so that they can get to places that are hard to reach.\n\n1. Check where each wire goes. You should not mix the wires up, or it will be troublesome to reconnect them. The ignition process follows a specific sequence that should not be modified. You can mark the cables with a marker, some tape, etc.\n2. Disconnect the spark plug wires with your hands.\n3. Turn the spark plug wrench anti-clockwise to loosen the spark plugs and take them out. Sometimes, they are really tight. Do not let any dirt enter the cylinder holes from where you removed the spark plugs. If anything falls inside the cylinders, you will have to take it out no matter what, which will be a nuisance.\n4. Put the new spark plugs in and turn the wrench clockwise. Tighten the spark plugs until they are all the way down, but do not over-tighten them.\n5. Once they are down, you must use the wrench to secure them like this: tighten spark plugs with a flat seat (with a washer), an extra ½ of a turn, and spark plugs with a tapered seat an extra ⅛ of a turn. They must be tight but not overly tight. If they are over-tightened, the thread may break.\n6. Reconnect the wires in the same order they were connected.\n\nAnd that is it. If your engine does not start up properly, check if the wires have been connected in the correct order, since you may have mixed the spark plug wires up.'
      },
      {
        'question': 'What are spark plugs?',
        'explanation':
            'In short:\n\nSpark plugs create the spark that starts the engine of gasoline cars.\n\nTo start a gasoline car, you need a spark. This happens inside of the cylinders, and the spark plugs are the ones that create it.\n\nSpark plugs are only used in Otto cycle engines, which are usually called “gasoline” engines. This means that Diesel cars do not have spark plugs.\n\nIt is common for engines to have just one spark plug per cylinder. They are screwed into the lid, called cylinder head, and there is one part of them inside, and its connector is outside. They are connected to the ignition coil through a thick wire with a cap on its cover, as seen in the image below.\n\nThe ignition coil creates the high current necessary for the spark plug, which makes the spark that starts the fuel ignition process. In this way, the engine can start and speed up when needed.'
      }
    ],
    'Transmission fluid': [
      {
        'question': 'What is the transmission fluid on a XC90?',
        'explanation':
            'The transmission fluid is a lubricant that helps maintain the transmission of your car working properly: it makes it silent and decreases its wear.'
      },
      {
        'question':
            'When should you change the transmission fluid of your XC90?',
        'explanation':
            'Generally, if your XC90 has an automatic transmission, the transmission fluid is changed every 25,000 to 30,000 miles.\n\nIf your car has a manual transmission, you should change the transmission fluid approximately every 60,000 miles.'
      },
      {
        'question':
            'How does the transmission fluid work inside your XC90 and where does it go?',
        'explanation':
            'The transmission is next to the engine of your vehicle. In the transmission, there are smaller parts that rotate at a great speed and transmit a lot of force, which creates heat.\n\nThe transmission fluid creates a protection film between the metal pieces, which decreases the friction, cleanses their surfaces, and refrigerates them. This protection increases the lifespan of these pieces and makes your car perform better, moving around more silently and smoothly.\n\nChanging the transmission fluid periodically is also beneficial because it is always cheaper to invest in the lubrication of the transmission rather than to invest in the replacement of all the pieces because of their wear.'
      },
      {
        'question': 'How much transmission fluid does my XC90 need?',
        'explanation':
            'You should read the owner\'s manual of your XC90 to know this information.\n\nIf this information is not stated in the manual, you can discard the used oil and fill the same amount of oil that you just took out of the transmission. The downside is that you will not be able to use your car to go buy the fluid you need.\n\nIt is essential that your car is in good condition, so you can read the following guides to find out how often you need to change this fluid to ensure its good performance.'
      }
    ],
    'Air conditioner': [
      {
        'question':
            'Which refrigerant do you need for the air conditioner of your XC90?',
        'explanation':
            'Usually, the refrigerant used in automotive air conditioning systems is the R-134a refrigerant. At any rate, you should still check the owner\'s manual just to make sure.'
      },
      {
        'question': 'How do you measure the refrigerant of your XC90?',
        'explanation':
            'To check if there is enough refrigerant for your air conditioner, you will have to measure the refrigerant pressure in the air conditioning system. To do so, you will need a particular refrigeration pressure gauge. If you use the R-134a refrigerant, the pressure levels must be the ones stated in the following chart:\n\nYou will have to measure these values while the engine is running and the air conditioner is on. A professional should be the one who does this.\n\nIf the pressure levels of your XC90 are not within this range, you will have to recharge the refrigerant.'
      },
      {
        'question':
            'What amount of refrigerant do you need for the air conditioner of your XC90?',
        'explanation':
            'The air conditioning system differs from car to car. The amount of refrigerant is crucial for the correct functioning of the system, and it is usually around 1 to 1.5 pounds. If you want to know how much refrigerant you need for your car’s system, please read the owner\'s manual.'
      },
      {
        'question':
            'Why is the air conditioner of my XC90 not working properly?',
        'explanation':
            'If there is a problem with the airflow of your XC90‘s air conditioner, like it barely blows air, there may be a problem with either the cabin filter or the vents. If the air is not cold, it might be because of the following reasons:'
      },
      {
        'question':
            'Why is the air conditioner of my XC90 not cooling the air properly?',
        'explanation':
            'You can detect most of the problems related to your air conditioner by measuring the gas pressure of the system. To do so, you will need a pressure gauge. You can find a chart with the standard pressure levels in our AC’s guide.\n\nHere are the most common causes of air conditioner failures:\n\n1. **Dirty radiator:**\nThe air conditioner radiator is right next to the main engine radiator. If it gets dirty and the air does not flow through it anymore, the refrigerant will not cool, and the system will malfunction. It is not hard to notice the radiator is dirty. If that happens, you can clean it with a brush and fix the problem yourself.\n\n2. **Damaged control valve:**\nIt is the valve that regulates the fluid flow that goes into the compressor. If the fluid does not get to the compressor, the pressure will not rise even if the compressor is spinning. These valves are cheap, so if you are looking for failure causes, you should first rule out this option before spending money on fixing other failures that may be more serious.\n\n3. **Clogged filter dryer (it gets cold or becomes frozen):**\nYou will notice the filter dryer is clogged if it feels too cold to the touch. In the worst-case scenario, it will be frozen. You will also notice that if you turn the air conditioner off and keep the pressure gauge connected, the pressure will take a lot of time to stabilize. In that case, you should replace the filter.\n\n4. **The air conditioner compressor stopped working:**\nThe compressor may be damaged internally, or it may not even spin anymore. You can check if it is damaged by checking its pressure with a pressure gauge. You will quickly notice if the compressor is not spinning. This problem may happen if the electromagnetic compressor clutch is damaged. In this case, it should be replaced.\n\n5. **Low refrigerant in the air conditioner:**\nIf there is not enough refrigerant, you will see that your air conditioner lines, which are close to the engine radiator, will be freezing and become white.\n\nSince air conditioners have a closed-loop system, the pressure must not decrease when measured with a pressure gauge for an extended period. We should check the pressure for two hours. If the pressure drops and the pressure is below the standard level, there is a leak in the system.\n\n6. **Too much refrigerant in the air conditioner:**\nThe air conditioner radiator will be hotter than usual. The compressor will have trouble running, and it will consume more engine power. This may be caused by a human error when the refrigerant was filled. To solve this problem, you need to remove the excess refrigerant.\n\n7. **Clogged expansion valve:**\nIf, according to the pressure gauge, the pressure levels are high but the evaporator is lukewarm, the air in the cabin will not cool. This means that the refrigerant is not getting to the evaporator.'
      }
    ],
    'Sensors': [
      {
        'question':
            'What is the oxygen sensor (or lambda sensor) of your XC90?',
        'explanation':
            'In short:\nThe oxygen sensor, also known as the lambda sensor, is in the exhaust system and measures the oxygen level in the exhaust gases. This information is later used by the central computer of your XC90 (ECU or PCM) to control the fuel injection and allow the engine to work efficiently without wasting fuel or reducing its efficiency.\n\nThe exhaust system may have 1 or 2 oxygen sensors. The main one is in the inlet of the catalytic converter, and it monitors the gases that come out of the engine. The second one (if your car has one) is in the catalytic converter outlet, and its purpose is to monitor its performance. It is important to remember that if the catalytic converter malfunctions, extremely pollutant gases will be released into the atmosphere. The oxygen sensor usually begins to fail after the car has driven from 55,000 to 90,000 miles (90,000 to 140,000 km), and that is when you should replace it. If it is working correctly, you do not have to replace it. Take into account that this is not an essential component with set maintenance periods, even if it helps your XC90 work efficiently by reducing its emissions, and it also helps extend the engine lifespan. The oxygen sensor usually malfunctions when a lot of dirt has been accumulated due to the wrong fuel type or low-quality fuel usage. Most of the time you just need to clean it for it to go back to normal.\n\n**Signs that show that your XC90‘s oxygen sensor is faulty:**\n- Unstable idle speed\n- Increased fuel consumption\n- The check engine light comes on'
      },
      {
        'question': 'What is the Throttle Position Sensor (TPS) of your XC90?',
        'explanation':
            'In short:\nThe TPS (Throttle Position Sensor) is the sensor that monitors the position of the butterfly valve of the throttle, allowing it to communicate with the computer so that it can adjust the injection and control the mixture of air and fuel. Some vehicles also include a similar sensor in the accelerator pedal called “APP sensor”.\nThe TPS sensor is located in the throttle body. If your vehicle has an automatic transmission, the TPS sensor also influences the control of the gears.\n\n**Signs that show that your XC90‘s TPS is faulty:**\n- Unstable idle speed\n- Lack of power\n- The car stalls or jerks\n- The “check engine” light comes on\n- In automatic cars, the gears may not work properly'
      }
    ],
    'Steering fluid': [
      {
        'question': 'How to change the power steering fluid of your XC90?',
        'explanation':
            'In short:\nChanging the power steering fluid is easy. To do so, you must make sure that your car is cold and its engine is off.\nTake into account that you should replace it only if there is a problem with the power steering system: for example, if it is making weird noises or it is hard to turn your car’s wheels. As time goes on, this fluid gets deteriorated. You will be able to notice this deterioration because it will be dark and dull. If everything is working properly but its level is low, refill it until it reaches the mark; you don’t need to replace it completely.\n\nTo replace it, you will need these elements:\n- The recommended power steering fluid for your car. You can see which one you need in this guide.\n- A syringe or a pipette to remove the used fluid.\n- A container to put the used fluid.\n- A rubber cap or something you can use to cover the reservoir mouth.\n- A funnel for the new fluid.\n- Paper napkins to clean any spilt fluid.\n- A jack (it is not mandatory, but it makes this task easier to perform).\n\n**Steps to change the power steering fluid:**\n1. Lift both front wheels with the jack, so that there are a few centimeters between them and the floor. This step is not mandatory, but it makes the process easier.\n2. Remove the power steering fluid reservoir and use a syringe to take most of the old fluid out.\n3. Then, you need to extract the rest of the fluid that still remains there. Unplug the return hose (the thinner one or the one plugged sideways), and place its end in the container. The old fluid will come out of there.\n4. Use the rubber cap to cover the mouth of the return hose you just unplugged.\n5. Add new fluid to the reservoir with the help of a funnel until the reservoir is full.\n6. Turn the engine on.\n7. Turn the wheel all the way a few times. When you do this, the old fluid will discharge through the hose you just unplugged.\n8. Refill the reservoir with new fluid as the fluid level decreases.\n9. When you see that red, clean fluid is coming out the hose, that means the process is over.\n10. Turn your car off, remove the rubber cap, and plug the hose back in its place.\n11. Fill the right amount of fluid and close the reservoir.\n12. Pull the jack out.'
      },
      {
        'question': 'What power steering fluid does your XC90 need?',
        'explanation':
            'In short:\nThe power steering fluid is usually the ATF type, and we can identify it by its red color. Since a few years ago, however, manufacturers use fluids that are specific for each car.\nTo find the ideal power steering fluid for your car, consult the owner’s manual. If you cannot find that information, it is okay to use an automatic transmission fluid type ATF+4 or Mercon V provisionally.\n\n**Why does the power steering system of your XC90 need fluids?**\nSteering fluids pass on the force necessary to make the steering system turn. This force is created by the pump of the power steering system. You should always have the recommended fluid level because if the level is low, the pump may get damaged.'
      }
    ],
    'Maintenance': [
      {
        'question':
            'What filters exist in your XC90 and when should you replace them?',
        'explanation':
            'In short:\nThe filters in your XC90 catch impurities and keep them away from the system they protect. Almost all of them work in the same way: the fluid goes through one or more sheets of porous paper in which these impurities are caught.\n\n⚠️ There is one main problem with filters:\nAs time goes on, particles are accumulated in the filters and overload them, so the fluids (either fuel, air, or oil) cannot flow through them anymore. When this happens, we say that the filter is “clogged.”\n\n**When should you change the filters of your XC90?**\n\n- **Air filter**: Replace every 7,000 miles. It purifies the air that enters the cylinders and catches dirt, sand, and other impurities. It keeps cylinders and piston rings clean, minimizing wear.\n- **Fuel filter**: Replace every 10,000 miles or once a year. Diesel filters last longer (change after 30,000 miles). It catches impurities and water in the fuel to protect the injectors and fuel system.\n- **Motor oil filter**: Replace every 5,000 - 10,000 miles (when you change the oil). It catches dirt and metallic particles from engine wear to prevent damage.\n- **Transmission fluid filter**: Replace or clean it every time you change transmission fluid. Change it every 25,000 miles in automatic cars, 50,000 miles in manual cars. It prevents impurities from damaging the transmission.\n- **Cabin air filter (pollen filter)**: Replace every 6,000 - 20,000 miles, depending on dirt accumulation. It filters dust, pollen, and other impurities to improve passenger comfort.\n\n⚠️ **Warning**: Filter replacement intervals can vary depending on driving conditions. If you drive in dusty areas or use low-quality fuel, you may need to replace filters more frequently.\n\nAlways refer to your XC90’s owner’s manual for specific replacement intervals.'
      },
      {
        'question':
            'What is brake fluid and which one should you use for your XC90?',
        'explanation':
            'In short:\nBrake fluid is the fluid by which the force applied to the brake pedal is transmitted to the brake pads. It is critical to keep the brake fluid at the correct level for optimal braking performance. Only use the recommended brake fluid for your XC90.\n\nIf the brake fluid level is low, the brake warning light will appear on your dashboard. You may also feel a “spongy” brake pedal.\n\nThe recommended brake fluid type is usually engraved on the cap of the master cylinder reservoir, or you can check the owner’s manual.\n\nThere are various types of brake fluids, rated according to DOT standards. Do not mix different brake fluids, as this can affect their properties and performance:\n- **DOT-3**: Conventional brakes, hygroscopic (absorbs water).\n- **DOT-4**: For conventional brakes and ABS, less hygroscopic.\n- **DOT-5**: Non-hygroscopic, absorbs more air.\n- **DOT-5.1**: Enhanced DOT-4, hygroscopic, low viscosity.\n\n**When should you refill the brake fluid?**\n\nWhen the fluid reaches the minimum level, the brake warning light will come on, or the brake pedal will feel “squishy.” If you notice these signs, check the master cylinder reservoir, which is typically white and located near the engine.\n\nBe cautious with brake fluid, as it is corrosive and toxic. Wear gloves and avoid contact with paint or plastics. Clean any spills with water immediately. Always ensure the reservoir is tightly closed to prevent contamination.\n\nMaintain brake fluid levels between the minimum and maximum marks to ensure proper braking performance.'
      }
    ],
    'Airbags': [
      {
        'question': 'How do your airbags work?',
        'explanation':
            'Airbags inflate rapidly during a collision to protect occupants from injury by absorbing the impact.'
      },
    ],
    'Wheels': [
      {
        'question': 'What is the right tire pressure for your XC90?',
        'explanation':
            'In short:\nThe tires’ pressure is very important both for the security and performance of your car.\n\n⚠ There are 3 ways of checking the recommended pressure for your XC90:\n\n1. **General Recommendation**: For street cars, SUVs, and pickups, the recommended pressure is usually around 34 psi. If your car is heavily loaded, you can increase it to 38 psi without any problems. For sports cars with low profile tires, you may need to inflate them to 40 psi.\n2. **Owner’s Manual**: Look up the recommended pressure in your vehicle’s owner’s manual.\n3. **Car’s Tag**: Check the tag located in the internal frame of the driver’s door, fuel-charger lid, or sun shield for the recommended pressure. It will look similar to this example.\n\n**How to Interpret the Tire Pressure Chart in your XC90**\nThe tag provides the following details:\n- A: The recommended pressure for the back tires.\n- B: The recommended pressure for the front tires.\n- C: The recommended pressure varies depending on the load of the car (number of passengers and luggage).\n- D: The pressure for the temporary spare tire, which may differ from the other tires due to its smaller size.\n- E: The tire size specifications for the temporary spare tire, like T125/60 R18.\n\nDepending on your XC90’s country of origin, tire pressure may be displayed in psi (pounds), bar, or kPa. Be sure to use the unit corresponding to your measurement tool.\n\n**When Should You Check the Pressure of Your Tires?**\n⚠ Check your tire pressure every 15 days and before starting a long trip. Always check when the tires are cold to get an accurate reading. Don’t check pressure after driving for long periods, as the heat generated will give a false, higher reading.\n\n**Why is It Important to Respect the Recommended Tire Pressure in Your XC90?**\n- **Security**: Correct tire pressure improves stability, reduces braking distance, and lowers tire temperature, preventing punctures.\n- **Fuel Efficiency**: Proper tire pressure reduces rolling resistance, improving fuel efficiency.\n- **Reduced Tire Wear**: Tires with the correct pressure wear evenly, lasting longer.\n- **Comfort**: Proper pressure provides better ride stability and absorbs road irregularities.\n\n**Erosion and Tire Inflation on Your XC90**\nMaintaining the correct tire inflation ensures optimal contact with the road. Too much or too little pressure causes uneven wear, reducing adherence and increasing the risk of tire damage.\n\n**Can I Use a Different Pressure for My XC90?**\nIn certain cases, it is possible to adjust the tire pressure:\n- **When driving on sand**: Lower the pressure to 15 psi to increase the tire’s footprint and improve traction.\n- **To reduce fuel consumption**: Increase pressure by 3-4 psi in city driving, but be aware it can lead to increased road vibrations, reduced grip, and faster wear on the tire center.\n\n**Always refer to your XC90 owner’s manual for specific tire pressure guidelines.**'
      },
      {
        'question': 'How to rotate the tires of your XC90?',
        'explanation':
            'In short:\nThere are two ways of rotating the tires depending on whether you have directional tires or non-directional tires. Tire rotation should be done every 6,000 miles.\n\n**1. Directional Tires**\nDirectional tires are designed to rotate only in one direction. They have an arrow on the sidewall to indicate the correct rotation direction. It is important to respect this direction to ensure proper adherence and resistance to hydroplaning.\n\n**2. Non-Directional Tires**\nIf your XC90 tires do not have the arrow, they are non-directional. In this case, rotate the tires by switching their positions without removing the wheels from the rims. Follow the recommended tire rotation pattern outlined in your owner’s manual.\n\nIf your vehicle has dual rear wheels, or requires a specific tire rotation, always refer to the owner’s manual.\n\n**When Should You Rotate the Tires?**\nRotate the tires every 6,000 miles or as recommended by your XC90’s owner’s manual.\n\n**Why Should You Rotate the Tires of Your XC90?**\nRegular tire rotation ensures even wear and extends tire life. If you notice uneven tire wear, rotate the tires and check for alignment or balancing issues.'
      }
    ],
    'Electrical system': [
      {
        'question': 'How to test your XC90\'s battery, step by step?',
        'explanation':
            '''There are two ways to test the charging system of your XC90:
      
A. **Check the Battery Indicator (if available)**: Some batteries have a colored indicator that shows the charge level. If it is **green**, the charge level is correct. If it is **red**, the charge is low. If your battery doesn’t have this feature, proceed to testing with a multimeter.

B. **How to Use a Multimeter to Check Your XC90’s Battery**:
1. **Get the Car Ready**: Make sure the engine is off, and let it rest for 5 minutes. Turn the headlights on for 30 seconds and then off.
2. **Set the Multimeter**: Set your multimeter to the **20V DC** measurement option.
3. **Measure the Battery Voltage**: Connect the red probe to the positive terminal (+) and the black probe to the negative terminal (-). The multimeter should show a voltage between **12 and 13 volts**.
4. **Measure the Starting Voltage**: While keeping the probes connected, turn on the engine. The voltage should drop but stay above **9V**, ideally between **9 and 11V**.
5. **Check the Alternator**: With the engine on, the multimeter should read between **13.2 and 14.8 volts**. Turn on all electrical accessories. The voltage should remain within this range.
6. **Conclusion**: If the voltage exceeds the range, the voltage regulator is likely damaged. If it’s lower than the range, the alternator may be faulty.
'''
      },
      {
        'question': 'How to start your XC90 with a dead battery?',
        'explanation':
            '''There are two ways to start your XC90 with a dead battery:
      
A. **Push the Car (Manual Transmission Only)**:
1. Two or more people are needed to push the car. One person pushes while the driver sits behind the wheel.
2. Turn the ignition key to the 'on' position and put the car in second gear, fully pressing the clutch pedal.
3. The car must be pushed quickly enough to turn the engine over.
4. Once the car moves, release the clutch pedal quickly to start the engine.
5. Let the engine run for a few minutes to recharge the battery. If the engine doesn’t start again, the battery needs replacement.

B. **Start the Car with Jumper Cables**:
1. Position the working car close to the car with the dead battery, ensuring the vehicles don’t touch and the gear shift is in **Park**.
2. Attach the red jumper cable clamp to the positive terminal (+) of the dead battery and the other end to the positive terminal (+) of the working car’s battery.
3. Attach the black jumper cable clamp to the negative terminal (-) of the working car’s battery and the other end to any metal part (not the battery) of the car with the dead battery.
4. Start the working car and let the engine run for a few minutes. Then, start the car with the dead battery.
5. If the car with the dead battery starts, keep it running for a few minutes. Disconnect the cables in reverse order: black cable (-) first, then red cable (+).
'''
      }
    ],
    'OBD codes': [
      {
        'question': 'What is the error code OBD-II P0106?',
        'explanation':
            '''The error code P0106 indicates that the MAP sensor has a problem with the voltage output range, which may point to an issue with the electric circuit or a mechanical problem with the engine.

The MAP (Manifold Absolute Pressure) sensor is a critical part of the fuel injection system. It measures the pressure inside the intake manifold and tells the ECU (Engine Control Unit) the amount of engine load, helping the ECU calculate how much fuel to inject into the engine for optimal performance.

**Symptoms of Error Code P0106**:
- "Check engine" light is on.
- Unsteady engine performance, erratic acceleration, idle speed issues.
- Increased fuel consumption.

**Common Causes of Error Code P0106**:
- Loose or cracked intake hose, allowing outside air into the system.
- Manufacturing defects or sensor failure.
- Faulty wiring or dirty electrical contacts.
- Bad mechanical condition of the engine (e.g., burned-out valves).
- ECU issues (less common).
'''
      },
      {
        'question': 'What are the symptoms of your XC90’s error code P0340?',
        'explanation':
            '''The error code P0340 signals a problem with the camshaft position sensor circuit. The camshaft position sensor determines the rotational speed and position of the camshaft and sends this information to the PCM (Powertrain Control Module) for fuel injection and ignition timing synchronization.

**Symptoms of Error Code P0340**:
- Difficulty or inability to start the car.
- Loss of power while driving.
- Unstable idle speed, car may stall.
- "Check engine" light is on.

**Common Causes of Error Code P0340**:
- Faulty camshaft position sensor.
- Faulty crankshaft position sensor.
- Damaged wiring or connectors in the camshaft sensor circuit.
- Faulty PCM (Powertrain Control Module).
'''
      }
    ],

    ///
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title:
              const Text('User Guides', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: headingQuestions.keys.length,
          itemBuilder: (context, index) {
            String heading = headingQuestions.keys.elementAt(index);
            List<Map<String, String>> questions = headingQuestions[heading]!;

            return ExpansionTile(
              title: Text(
                heading,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: questions.map((question) {
                return ListTile(
                  title: Text(question['question']!),
                  onTap: () {
                    // Navigate to the explanation page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExplanationPage(
                          question: question['question']!,
                          explanation: question['explanation']!,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class ExplanationPage extends StatelessWidget {
  final String question;
  final String explanation;

  const ExplanationPage({required this.question, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Explanation for: $question'),
      //),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text('Explanation for: $question',
              style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Text(
              explanation,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
