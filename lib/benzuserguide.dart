import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class benzuserguides extends StatelessWidget {
  // Define the headings and questions with their explanations
  final Map<String, List<Map<String, String>>> headingQuestions = {
    'Lubrication': [
      {
        'question': 'What is the purpose of motor oil in your C class?',
        'explanation':
            'Motor oil takes care of the movable pieces of your car’s engine. It reduces wear, noise and saves energy, which minimizes maintenance costs. The engine lubrication is the most important aspect you should pay attention to if you want to keep it working in optimal conditions. If your car does not have enough oil, it may get irreversibly damaged in a matter of minutes. Even if you repair it, the cost will be extremely high. It also “softens” friction between the engine components, preventing metal seizure. Good lubrication reduces wear, noise, and saves energy by diminishing friction.'
      },
      {
        'question': 'Why do I have to change motor oil?',
        'explanation':
            'Your C class needs oil changes based on the oil type: Mineral oil (3,000 miles), Semi-synthetic oil (5,000 to 6,000 miles), or Synthetic oil (6,000 to 9,000 miles). Even if the mileage isn’t reached, change the oil annually. Synthetic oil is the best for your car as it reduces frequency of changes and better maintains engine health. Always follow the instructions on the oil container. Also, remember to change the oil filter with each oil change to ensure clean oil.'
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
        "question":
            "What is the immobilizer or anti-theft system on a C Class?",
        "answer":
            "The immobilizer or anti-theft system verifies that the key used to start the engine is correct. If the key is incorrect, the system blocks various actions to prevent the car from starting. When activated, a warning light will turn on. If the car doesn't recognize the key's signal, the engine may either turn on for a few seconds and then stop, or it may not turn on at all. The car's computer will disable components like the fuel pump, ignition coil, or injectors. In diesel engines, it may also block the stop relay, preventing fuel injection. Additionally, the system can lock the steering wheel."
      },
      {
        'question': 'What does the check engine light of your C class mean?',
        'explanation':
            'In a few words:\n\nIt’s a warning light that alerts the driver about any type of engine problems. In some vehicles, the light comes in two colors: yellow to indicate minor problems and red to indicate serious problems.\n\nThe check engine light is part of every vehicle that has an electronic engine management system, either an integral one or only for fuel ignition. Its function is to alert the driver about any type of engine problems.\n\nWhile driving, the computer of your XC90 (ECU o PCM) monitors air/fuel supply and exhaust gases in order to verify that the engine is working properly. If any problem is detected, the check engine Light of your dashboard will turn on.\n\nDepending on the type of failure, the light may either blink or remain constantly lit. If the problem is serious, your XC90 will be in a “emergency” state that will prevent you from accelerating the engine above certain speed limit, forcing you to drive at low speed in order to avoid further damages.\n\nThe check engine light can alert you about some failures but not all of them. It will depend on how complex the electronic control unit of your XC90 is.\n\nTo properly diagnose the failure of your XC90, it is important to have a suitable scanner that is compatible with the brand and model of your car. The scanner will show the engine fault code that the computer has detected, which is related to a certain problem that is affecting the engine.\n\nThe most common check engine light causes of your XC90 and how to detect them:\n\n- Ignition cylinder problems: irregular engine running.\n- Problem with exhaust gas oxygen sensor (Lambda probe): irregular engine running, there are misfires when accelerating abruptly or driving at low revs. It may be caused by a sensor fault or a failure of the catalytic converter.\n- Problems with the engine intake (air or fuel): engine running may be rough or irregular.\n- Problems with the electrical system: sometimes it is easy to identify the cause but other times it may take days of testing to find the source of the problem.\n- Sensor malfunction: It affects engine running or stops running completely.\n- Wiring problems: contact failure, cut wires, short circuits.\n\nIndicator status and severity:\n\n- The check engine light turns on when you switch on the ignition key and then it turns off: It’s normal. It’s used to verify that the light itself is working and the bulb is not burned out.\n- The check engine light blinks and then it turns off (cyclically): This indicates that the car had a problem at one point but it is not happening at the moment.\n- The check engine light is steady: This indicates that there is a problem but is not so serious as to stop driving your vehicle.\n- The check engine light blinks continuously: This indicates that there is a critical problem. Usually, you should stop driving your vehicle.'
      }
    ],
    'Spark plugs': [
      {
        'question': 'How do I change the spark plugs of my C-Class?',
        'explanation':
            'Follow these six steps to replace the spark plugs of your C-Class:\n\n⚠️ Before you begin, ensure that the engine of your C-Class is off and cold.\n\nYou will need a spark plug wrench, which is longer than regular wrenches and more flexible for hard-to-reach areas.\n\n1. Note where each wire goes to avoid mixing them up. The ignition process follows a specific sequence, and reconnecting wires incorrectly can cause problems. Mark the cables with tape or a marker if necessary.\n2. Disconnect the spark plug wires by hand.\n3. Use the spark plug wrench, turning anti-clockwise to loosen and remove the spark plugs. If they are tight, apply steady pressure. Avoid letting dirt fall into the cylinder holes where the spark plugs were removed, as this can cause serious issues.\n4. Insert the new spark plugs and turn the wrench clockwise. Tighten the spark plugs until fully seated, but do not over-tighten.\n5. Secure the spark plugs by giving an extra ½ turn for flat seat plugs (with a washer) or an extra ⅛ turn for tapered seat plugs. They must be snug but not overly tight to prevent damage.\n6. Reconnect the spark plug wires in the original order.\n\nIf the engine does not start properly, double-check the spark plug wire connections to ensure they are in the correct order.'
      },
      {
        'question': 'What are spark plugs?',
        'explanation':
            'In short:\n\nSpark plugs create the spark needed to start the engine of gasoline-powered vehicles like the C-Class.\n\nIn gasoline engines, the spark occurs inside the cylinders, and the spark plugs are responsible for generating it. These components are found in Otto cycle engines, which gasoline engines use. Diesel engines, such as those in some models of Mercedes, do not have spark plugs.\n\nTypically, each cylinder has one spark plug, which is screwed into the cylinder head. The spark plug has a portion inside the cylinder and a connector outside, which is linked to the ignition coil via a thick wire with a cap. The ignition coil provides the high voltage required for the spark plug to produce the spark that ignites the air-fuel mixture, enabling the engine to start and run smoothly.'
      }
    ],
    'Transmission fluid': [
      {
        'question': 'What is the transmission fluid on a C-Class?',
        'explanation':
            'The transmission fluid is a lubricant that helps maintain the transmission of your C-Class working properly: it reduces noise and minimizes wear on the transmission components.'
      },
      {
        'question':
            'When should you change the transmission fluid of your C-Class?',
        'explanation':
            'Generally, if your C-Class has an automatic transmission, the transmission fluid should be changed every 25,000 to 30,000 miles.\n\nFor a manual transmission, the fluid should be changed approximately every 60,000 miles.'
      },
      {
        'question':
            'How does the transmission fluid work inside your C-Class and where does it go?',
        'explanation':
            'The transmission is located near the engine of your C-Class. Inside the transmission, small parts rotate at high speed and transmit significant force, generating heat.\n\nTransmission fluid creates a protective layer between metal parts, reducing friction, cleaning surfaces, and cooling them. This protection extends the lifespan of the transmission components and improves the overall performance of the car, ensuring quieter and smoother operation.\n\nChanging the transmission fluid regularly is essential because it is more cost-effective to invest in proper lubrication than to replace worn-out components.'
      },
      {
        'question': 'How much transmission fluid does my C-Class need?',
        'explanation':
            'You should consult the owner\'s manual of your C-Class for the correct transmission fluid capacity.\n\nIf this information is unavailable, you can measure the amount of fluid drained during a transmission fluid change and refill with the same amount. However, it is advisable to have the required fluid ready beforehand to avoid inconvenience.'
      }
    ],
    'Air conditioner': [
      {
        'question':
            'Which refrigerant do you need for the air conditioner of your C-Class?',
        'explanation':
            'Usually, the refrigerant used in automotive air conditioning systems is the R-134a refrigerant. However, it is important to check your owner\'s manual to confirm the correct refrigerant for your specific C-Class model.'
      },
      {
        'question': 'How do you measure the refrigerant of your C-Class?',
        'explanation':
            'To check if there is enough refrigerant in your C-Class air conditioner, you will need to measure the refrigerant pressure using a refrigeration pressure gauge. If your car uses R-134a refrigerant, the pressure should align with the recommended levels provided in a chart.\n\nMeasurements must be taken while the engine is running and the air conditioner is on. This task is best handled by a professional technician.\n\nIf the pressure is not within the recommended range, the refrigerant may need to be recharged.'
      },
      {
        'question':
            'What amount of refrigerant do you need for the air conditioner of your C-Class?',
        'explanation':
            'The amount of refrigerant required varies by vehicle model. For your C-Class, the air conditioning system typically needs around 1 to 1.5 pounds of refrigerant. To know the exact amount, please consult your owner\'s manual.'
      },
      {
        'question':
            'Why is the air conditioner of my C-Class not working properly?',
        'explanation':
            'If the air conditioner of your C-Class is experiencing poor airflow, such as weak air output, there could be an issue with the cabin air filter or the vents. If the air isn’t cold, the following issues might be the cause:'
      },
      {
        'question':
            'Why is the air conditioner of my C-Class not cooling the air properly?',
        'explanation':
            'Most air conditioning problems can be diagnosed by measuring the gas pressure with a pressure gauge. You can refer to the standard pressure levels in your C-Class air conditioner guide.\n\nHere are the common causes of AC failures:\n\n1. **Dirty radiator:** If the air conditioner radiator is dirty, it will not cool the refrigerant effectively. You can clean it with a brush to restore proper airflow.\n\n2. **Damaged control valve:** This valve regulates the refrigerant flow into the compressor. A faulty valve will prevent proper cooling. Replacing the valve is usually an inexpensive fix.\n\n3. **Clogged filter dryer:** If the filter dryer feels too cold or frozen, it is likely clogged. Replacing the filter will solve the problem.\n\n4. **Compressor issues:** The compressor may be damaged or not spinning. This can be checked by using a pressure gauge. If the compressor is not functioning properly, it might be due to a faulty electromagnetic clutch, which will need to be replaced.\n\n5. **Low refrigerant:** If the refrigerant is too low, the AC lines will freeze, and the system will not cool effectively. There may also be a leak in the system that needs to be repaired.\n\n6. **Excess refrigerant:** Too much refrigerant can cause the AC radiator to overheat, leading to inefficiency. Removing the excess refrigerant will resolve this.\n\n7. **Clogged expansion valve:** If the pressure is high but the evaporator is lukewarm, the refrigerant is not reaching the evaporator, and the air in the cabin will not cool properly.'
      }
    ],
    'Sensors': [
      {
        'question':
            'What is the oxygen sensor (or lambda sensor) of your C-Class?',
        'explanation':
            'In short:\nThe oxygen sensor, also known as the lambda sensor, is located in the exhaust system and measures the oxygen level in the exhaust gases. This information is sent to the central computer of your C-Class (ECU or PCM) to adjust fuel injection, helping the engine run efficiently and reducing fuel waste.\n\nYour C-Class may have one or two oxygen sensors. The primary sensor is at the inlet of the catalytic converter, monitoring exhaust gases from the engine. If there’s a second sensor, it is positioned at the catalytic converter outlet to check its performance. If the catalytic converter malfunctions, it can release harmful gases into the atmosphere. Typically, oxygen sensors start to fail after 55,000 to 90,000 miles (90,000 to 140,000 km), and that is when they should be replaced. However, if they are functioning properly, no replacement is necessary. This sensor aids in efficient engine operation by reducing emissions and extending engine life. Issues with the sensor often arise from dirt accumulation due to poor-quality fuel or using the wrong fuel type. Most of the time, cleaning the sensor can restore its normal function.\n\n**Signs that your C-Class oxygen sensor may be faulty:**\n- Unstable idle speed\n- Increased fuel consumption\n- The check engine light turns on'
      },
      {
        'question':
            'What is the Throttle Position Sensor (TPS) of your C-Class?',
        'explanation':
            'In short:\nThe TPS (Throttle Position Sensor) monitors the position of the throttle’s butterfly valve, sending data to the car’s computer so it can adjust fuel injection and regulate the air-fuel mixture. Some vehicles also have a similar sensor in the accelerator pedal, called the “APP sensor.”\nThe TPS sensor is located in the throttle body. In vehicles with automatic transmissions, the TPS also affects gear control.\n\n**Signs that your C-Class TPS may be faulty:**\n- Unstable idle speed\n- Lack of power\n- The car stalls or jerks\n- The check engine light turns on\n- In automatic cars, the gears may not shift properly'
      }
    ],
    'Steering fluid': [
      {
        'question': 'How to change the power steering fluid of your C-Class?',
        'explanation':
            'In short:\nChanging the power steering fluid in your C-Class is straightforward. Ensure the car is cold and the engine is off before starting. Replace the fluid only if there’s an issue with the power steering system, such as strange noises or difficulty turning the wheels. Over time, the fluid may degrade, turning dark and dull. If the fluid level is low but everything is working fine, simply refill it without replacing it entirely.\n\nYou’ll need the following items:\n- The recommended power steering fluid for your C-Class (refer to your owner’s manual).\n- A syringe or pipette to remove the old fluid.\n- A container to collect the used fluid.\n- A rubber cap to cover the reservoir mouth.\n- A funnel for adding the new fluid.\n- Paper towels to clean up spills.\n- A jack (optional, but helpful).\n\n**Steps to change the power steering fluid:**\n1. Lift the front wheels with a jack to make the task easier.\n2. Remove the power steering fluid reservoir and use a syringe to extract most of the old fluid.\n3. Disconnect the return hose (the thinner one) and drain the remaining fluid into a container.\n4. Use a rubber cap to cover the mouth of the return hose.\n5. Refill the reservoir with new fluid using a funnel.\n6. Start the engine.\n7. Turn the steering wheel fully left and right a few times to discharge the old fluid.\n8. Continue refilling the reservoir as the fluid level drops.\n9. Once clean, red fluid flows from the hose, the process is complete.\n10. Turn off the engine, reconnect the hose, and remove the cap.\n11. Top off the fluid level and close the reservoir.\n12. Lower the car by removing the jack.'
      },
      {
        'question': 'What power steering fluid does your C-Class need?',
        'explanation':
            'In short:\nPower steering fluid for your C-Class is typically a manufacturer-specific fluid, and you should check your owner’s manual for the exact type. If you don’t have access to the manual, an automatic transmission fluid type such as ATF+4 or Mercon V can be used temporarily.\n\n**Why does your C-Class power steering system need fluids?**\nThe steering fluid transmits the hydraulic pressure necessary to assist in turning the wheels, a process driven by the power steering pump. Keeping the fluid at the recommended level is important to prevent pump damage and ensure smooth steering operation.'
      }
    ],
    'Maintenance': [
      {
        'question':
            'What filters exist in your C-Class and when should you replace them?',
        'explanation':
            'In short:\nThe filters in your C-Class help keep impurities out of critical systems. Most filters work similarly: fluids pass through porous materials that trap dirt, particles, and other contaminants.\n\n⚠️ The main issue with filters is that over time, they accumulate particles and become clogged, restricting the flow of air, fuel, or oil.\n\n**When should you replace the filters of your C-Class?**\n\n- **Air filter**: Replace every 7,000 miles. It filters dirt and particles from the air entering the engine, protecting the cylinders and piston rings.\n- **Fuel filter**: Replace every 10,000 miles or once a year. Diesel filters last longer (change after 30,000 miles). It catches impurities and water from fuel to protect the fuel system and injectors.\n- **Motor oil filter**: Replace every 5,000 - 10,000 miles (when changing the oil). It traps debris and metallic particles from engine wear to prevent damage.\n- **Transmission fluid filter**: Replace or clean it when changing transmission fluid. In automatic cars, replace every 25,000 miles; in manual cars, every 50,000 miles. It keeps harmful particles from damaging the transmission.\n- **Cabin air filter (pollen filter)**: Replace every 6,000 - 20,000 miles depending on dirt buildup. It filters dust and pollen to ensure clean air inside the cabin.\n\n⚠️ **Warning**: Replacement intervals can vary based on driving conditions. For example, driving in dusty areas or using low-quality fuel may require more frequent filter changes.\n\nRefer to your C-Class owner’s manual for specific intervals.'
      },
      {
        'question':
            'What is brake fluid and which one should you use for your C-Class?',
        'explanation':
            'In short:\nBrake fluid transfers the force from the brake pedal to the brake pads, making it essential to maintain the correct fluid level for effective braking. Always use the recommended brake fluid for your C-Class.\n\nIf the brake fluid is low, a brake warning light will appear on the dashboard, or the brake pedal may feel “spongy.”\n\nThe type of brake fluid to use is usually specified on the cap of the master cylinder reservoir, or you can check the owner’s manual.\n\nThere are several brake fluid types based on DOT ratings. Do not mix them, as they differ in properties:\n- **DOT-3**: For conventional brakes, hygroscopic (absorbs water).\n- **DOT-4**: Suitable for conventional brakes and ABS, absorbs less water.\n- **DOT-5**: Silicone-based, non-hygroscopic (absorbs air).\n- **DOT-5.1**: Advanced DOT-4, hygroscopic, low viscosity.\n\n**When should you refill brake fluid?**\n\nRefill the brake fluid when it reaches the minimum level. A brake warning light or a “squishy” pedal may signal the need for more fluid. Check the reservoir, usually white and located near the engine.\n\nBe careful with brake fluid, as it’s corrosive and harmful. Wear gloves and avoid contact with paint or plastic. Clean spills with water immediately. Always keep the reservoir sealed tightly to prevent contamination.\n\nMaintain brake fluid between the minimum and maximum marks to ensure optimal braking performance.'
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
        'question': 'What is the right tire pressure for your C-Class?',
        'explanation':
            'In short:\nTire pressure is crucial for both the safety and performance of your C-Class.\n\n⚠ There are 3 ways to check the recommended pressure for your C-Class:\n\n1. **General Recommendation**: For most passenger cars, including the C-Class, the recommended pressure is usually around 33 psi. If the car is heavily loaded, you can increase it to 36 psi without issue. For performance variants or sports tires, you may need to inflate them to 40 psi.\n2. **Owner’s Manual**: Check your vehicle’s owner’s manual for the exact recommended pressure.\n3. **Car’s Tag**: Look for a label located on the inside of the driver’s door frame, fuel cap, or sun shield for the recommended pressure values.\n\n**How to Interpret the Tire Pressure Chart in your C-Class**\nThe tag will provide the following details:\n- A: Recommended pressure for the front tires.\n- B: Recommended pressure for the rear tires.\n- C: Recommended pressure for a fully loaded car (passengers and luggage).\n- D: Pressure for the spare tire, which may differ from the others due to its size.\n- E: Tire size specifications for the spare tire, such as T125/70 R17.\n\nTire pressure may be listed in psi (pounds), bar, or kPa depending on your country of origin, so be sure to use the correct unit for your gauge.\n\n**When Should You Check the Pressure of Your Tires?**\n⚠ Check tire pressure every 15 days and before long trips. Always check when the tires are cold to get an accurate reading, as heat from driving increases the pressure, giving false readings.\n\n**Why is It Important to Respect the Recommended Tire Pressure in Your C-Class?**\n- **Security**: Proper tire pressure improves stability, reduces braking distance, and prevents punctures by maintaining optimal tire temperature.\n- **Fuel Efficiency**: Correct pressure reduces rolling resistance, improving fuel efficiency.\n- **Reduced Tire Wear**: Tires with proper inflation wear evenly, lasting longer.\n- **Comfort**: Correct pressure provides better ride stability and comfort, absorbing road irregularities.\n\n**Erosion and Tire Inflation on Your C-Class**\nIncorrect tire pressure, whether too high or too low, causes uneven tire wear and reduces road grip, increasing the risk of tire damage.\n\n**Can I Use a Different Pressure for My C-Class?**\nIn specific cases, you can adjust the pressure:\n- **When driving on sand**: Lower the pressure to around 20 psi to increase the tire footprint and improve traction.\n- **To improve fuel economy**: You can increase the pressure by 2-3 psi for city driving, but this may lead to higher vibrations and faster wear in the tire center.\n\n**Always refer to your C-Class owner’s manual for exact tire pressure guidelines.**'
      },
      {
        'question': 'How to rotate the tires of your C-Class?',
        'explanation':
            'In short:\nThere are two main types of tire rotation, depending on whether your C-Class has directional or non-directional tires. Tire rotation is recommended every 6,000 miles.\n\n**1. Directional Tires**\nDirectional tires are designed to rotate in only one direction. You’ll find an arrow on the sidewall indicating the correct rotation direction. It’s important to rotate them according to this direction for optimal performance, particularly in wet conditions.\n\n**2. Non-Directional Tires**\nNon-directional tires do not have a specific rotation direction. If your C-Class uses non-directional tires, rotate them by switching positions without removing them from their rims, following the pattern recommended in the owner’s manual.\n\nIf your C-Class has dual rear wheels, or requires specific tire rotations, always consult the owner’s manual.\n\n**When Should You Rotate the Tires?**\nTires should be rotated every 6,000 miles or as advised in the owner’s manual.\n\n**Why Should You Rotate the Tires of Your C-Class?**\nRegular tire rotation helps ensure even tire wear and extends their lifespan. If you notice uneven wear, rotate the tires and inspect the alignment or balancing for potential issues.'
      }
    ],
    'Electrical system': [
      {
        'question': 'How to test your C-Class\'s battery, step by step?',
        'explanation':
            '''There are two ways to test the charging system of your C-Class:
      
A. **Check the Battery Indicator (if available)**: Some Mercedes-Benz batteries have a colored indicator to show the charge level. If it is **green**, the charge is optimal. If it is **red**, the charge is low. If your battery doesn’t have this feature, proceed to testing with a multimeter.

B. **How to Use a Multimeter to Check Your C-Class’s Battery**:
1. **Get the Car Ready**: Ensure the engine is off, and let it rest for a few minutes. Turn on the headlights for 30 seconds and then turn them off.
2. **Set the Multimeter**: Set the multimeter to the **20V DC** setting.
3. **Measure the Battery Voltage**: Connect the red probe to the positive terminal (+) and the black probe to the negative terminal (-). The multimeter should show a voltage between **12 and 13 volts**.
4. **Measure the Starting Voltage**: While keeping the probes connected, turn on the engine. The voltage will drop but should remain above **9V**, ideally between **9 and 11V**.
5. **Check the Alternator**: With the engine on, the multimeter should read between **13.2 and 14.8 volts**. Turn on all electrical accessories. The voltage should remain within this range.
6. **Conclusion**: If the voltage exceeds the range, the voltage regulator is likely damaged. If it’s lower than the range, the alternator might be faulty.
'''
      },
      {
        'question': 'How to start your C-Class with a dead battery?',
        'explanation':
            '''There are two ways to start your C-Class with a dead battery:
      
A. **Push the Car (Manual Transmission Only)**:
1. Two or more people are needed to push the car. One person pushes while the driver sits behind the wheel.
2. Turn the ignition key to the "on" position and put the car in second gear, fully pressing the clutch pedal.
3. The car must be pushed fast enough to turn the engine over.
4. Once the car moves, release the clutch pedal quickly to start the engine.
5. Let the engine run for a few minutes to recharge the battery. If the engine doesn’t start again, the battery needs replacement.

B. **Start the Car with Jumper Cables**:
1. Position the working car close to the car with the dead battery, ensuring the vehicles don’t touch, and the gear shift is in **Park**.
2. Attach the red jumper cable clamp to the positive terminal (+) of the dead battery and the other end to the positive terminal (+) of the working car’s battery.
3. Attach the black jumper cable clamp to the negative terminal (-) of the working car’s battery and the other end to any metal part (not the battery) of the car with the dead battery.
4. Start the working car and let it run for a few minutes. Then, start the car with the dead battery.
5. If the car with the dead battery starts, let it run for a few minutes. Disconnect the cables in reverse order: black cable (-) first, then red cable (+).
'''
      }
    ],
    'OBD codes': [
      {
        'question': 'What is the error code OBD-II P0106?',
        'explanation':
            '''The error code P0106 indicates a problem with the MAP (Manifold Absolute Pressure) sensor, particularly related to the voltage output range, which may suggest an issue with the electrical circuit or a mechanical problem with the engine.

The MAP sensor is essential in determining the pressure within the intake manifold, which the Engine Control Unit (ECU) uses to calculate the correct air-to-fuel ratio for optimal engine performance.

**Symptoms of Error Code P0106**:
- "Check engine" light is illuminated.
- Unstable engine performance, erratic acceleration, or idle speed issues.
- Increased fuel consumption.

**Common Causes of Error Code P0106**:
- Loose or cracked intake hose, allowing unfiltered air into the system.
- MAP sensor failure or manufacturing defects.
- Faulty wiring or dirty electrical contacts.
- Engine issues, such as burnt valves or poor mechanical condition.
- Rarely, issues with the ECU (Engine Control Unit).
'''
      },
      {
        'question': 'What are the symptoms of your C-Class’s error code P0340?',
        'explanation':
            '''The error code P0340 points to an issue with the camshaft position sensor circuit. This sensor monitors the rotational speed and position of the camshaft and communicates with the Powertrain Control Module (PCM) to synchronize fuel injection and ignition timing.

**Symptoms of Error Code P0340**:
- Difficulty starting the car or inability to start.
- Loss of engine power while driving.
- Unstable idle speed, engine may stall.
- "Check engine" light is illuminated.

**Common Causes of Error Code P0340**:
- Faulty camshaft position sensor.
- Malfunctioning crankshaft position sensor.
- Damaged wiring or connectors in the camshaft sensor circuit.
- Faulty Powertrain Control Module (PCM).
'''
      }
    ],
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
                colors: [Colors.blueAccent, Colors.green],
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
      //  appBar: AppBar(
      //      title: Text('Explanation for: $question'),
      //   ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.green],
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
