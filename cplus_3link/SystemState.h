// File: SystemState.h
// Created by: Michael Napoli
// Created on: 1/14/2022

/*
  Purpose: To maintain and run the system update/prediction
  algorithms, as well as calculate the state space.
*/

#ifndef SYSTEMSTATE
#define SYSTEMSTATE

#include <iostream>

namespace nap {
  class SystemState
  {
  protected:
    // CLASS VARIABLE(S):
    float state[6];

  public:
    // CONSTRUCTOR(S):
    SystemState(const float initialState[6]);

    // ACCESSOR FUNCTION(S):
    float* getCurrentState();

    // MEMBER FUNCTION(S):
    float* modifiedEuler(const float nextInput[3]);
  };
}

#endif
