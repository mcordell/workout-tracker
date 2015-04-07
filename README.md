##Workout Tacker

[![Circle CI](https://circleci.com/gh/mcordell/workout-tracker/tree/master.svg?style=svg)](https://circleci.com/gh/mcordell/workout-tracker/tree/master)

Workout tracker is my playground Rails app. I primarily use it to test out new
stuff while still getting something that is useful to me. It is primarily
useful for tracking periodic weight training.

###Installation

1. Install Ruby 2.2.0 and [bundler](http://bundler.io/)
2. git clone the repo
3. Run `bundle install` from within the repo
4. Configure your database connection in `config/database.yml`
5. Run `rake db:create; rake db:migrate`
6. Run `rails server` and workout tracker will be running

###Demo

A working copy is currently deployed on heroku
[here](https://workoutstracker.herokuapp.com/), however as of writing it does
not have a open registration.

###Terminology

- _Program_ : program is the type of weight training
- _Cycles_ : a cycle is the largest repeating unit of the program
- _Subcycles_ : a subcycle is the reoccurring unit within a subcycle, consisting
  of workouts
- _Workouts_ : a workout is a single day of training composed of workout sets
- _Workout sets_ : a single set of a number of reps of a given exercise at a given weight,
  e.g. 5 reps of bench press at 125

###Contributing

Feel free to contribute by forking the repo and submitting a pull request.

###Contact

[Michael Cordell](http://mikecordell.com) or
[@mike_cordell](https://twitter.com/mike_cordell) on twitter.

