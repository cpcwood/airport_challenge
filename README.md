# Airport Challenge
======

```
        ______
   -  -- \    \
          \ CW \
    -  --  \____\___________________,-~~~~~~~`-.._
          /     o o o o o o o o o o o o o o o o  |\_
   -  -- `~-.__       __..----..__                  )
                `---~~\___________/------------`````
                =  ===(_________)

```

## Client Requirements
---------

We have a request from a client to write the software to control the flow of planes at an airport:

```
As an air traffic controller
So I can get passengers to a destination
I want to instruct a plane to land at an airport
```
```
As an air traffic controller
So I can get passengers on the way to their destination
I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport
```
```
As an air traffic controller
To ensure safety
I want to prevent landing when the airport is full
```
```
As the system designer
So that the software can be used for many different airports
I would like a default airport capacity that can be overridden as appropriate
```
```
As an air traffic controller
To ensure safety
I want to prevent takeoff when weather is stormy
```
```
As an air traffic controller
To ensure safety
I want to prevent landing when weather is stormy
```

## Approach
---------

#### Extract scope:
* Simple program to organise the landing and taking off of planes from a air traffic controllers point of view
* Single random variable of weather in determining ability to land
* No scope defined for number of airports, so will assume three airports (London, Luton, Gatwick)
* No scope defined for number of planes or airlines, so will assume generic plane with unlimited avaliablity for initalization
* Assumes planes will be initialized by default in flight, however gives option to initialize in airport
* No scope for flightpaths or times, so will assume once a plane has departed it can immediately land again
* Assume any plane which is landed is immediately available for departure
------

#### List out required objects from client requirements:
* AirTrafficController
* Airport
* Plane
* Weather
------

#### List out required controller messages:
* AirTrafficController -> Plane (Land at airport)
  - providing plane is in the air
  - if weather is not stormy
  - if airport not full
* AirTrafficController -> Plane (Take off from airport)
  - if plane is in the airport
  - if weather is not stormy
------

#### List out required attributes of each non-controller object:
* AirTrafficController
* Airport
  - Array to store planes with set capacity
  - Airport IATA code
* Plane
  - Flight status
* Weather
  - Weather status at specific airport
------

#### Create diagram for major processes:
* air_traffic_controller.tell_plane_to_land(airport, plane) [image](https://github.com/cpcwood/airport_challenge-1/blob/master/process_diagrams/depart_plane.jpeg)
* air_traffic_controller.tell_plane_to_depart(airport, plane) [image](https://github.com/cpcwood/airport_challenge-1/blob/master/process_diagrams/land_plane.jpeg)
------

#### List out required messages between objects from diagram:
* good_weather?: air_traffic_controller --> weather
* iata_code: weather --> airport
* airport_at_capacity?: air_traffic_controller --> airport
* cleared_to_land(airport): air_traffic_controller --> plane
* land_plane(plane): plane --> airport
* plane_departure_ready?(plane): air_traffic_controller --> airport
* cleared_for_takeoff(airport): air_traffic_controller --> plane
* plane_departed: plane --> airport
------

#### Create RSpec for basic object functions and implement TDD:
* weather.good_weather?
* airport.iata_code
* airport.airport_at_capacity?
* plane.cleared_to_land(airport)
* airport.land_plane(plane)
* airport.plane_departure_ready?(plane)
* plane.cleared_for_takeoff(airport)
* airport.plane_departed(plane)
------

#### Create RSpec for controller (AirTrafficController) and implement TDD:
* air_traffic_controller.tell_plane_to_land(airport, plane)
  - planes do not land if bad weather
  - planes do not land if airport is at capacity
  - planes land if no bad weather and airport has capacity
  - planes do not land if they are already landed (part of plane spec)
* air_traffic_controller.tell_plane_to_depart(airport, plane)
  - planes do not depart if there is bad weather
  - planes do not depart if they are not in the airport
  - planes depart if weather is good and they are ready to depart
  - planes do not take off if already in flight (part of plane spec)
* add log of air traffic controller actions and verify using rspec
------

#### Refactor:
* Cleanup
* Rubocop
* Have available airports based in airtraffic controller
* Modify logging to return flight ID and airport iata code
* Refactor class initialize methods to take hash as input if required (OOD)
* Create basic example run file and log file, then exclude any new logs using .gitignore
* Remove good_weather? reliance on airport, since adds no benefit, option to add realtime api in future
* Add some controller methods to private
------

#### Reflect
* Total time spent on project: 7-8hrs
* First weekend challenege of Makers so the client requirements wern't too extrenuous
*  Process of extracting scope then creating sequence diagrams worked well for draft designing the program objects and messages
* Definitely had some mission creep from the client requirements due to curiosity, e.g. adding in log file, number of airports, flight ID etc. In the future only design program to client requirements, then add in extras after if curious
* Need to create process for object-oritented design, so that principles are included in the first draft of the program instead of refactored in after
* RSpec went well although could have known more matchers to give more specific results and also require a type of RSpec test for running full program functionality
