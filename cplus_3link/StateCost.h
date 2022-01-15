// File: StateCost.h
// Created by: Michael Napoli
// Created on: 1/14/2022

/*
  Purpose: Calculate the cost of a given system
  state. Friend class: SystemState.h
*/

#ifndef STATECOST
#define STATECOST

#include <iostream>
#include "SystemState.h"

namespace nap {
  class StateCost : public SystemState
  {
  private:
    // CLASS VARIABLE(S):
    float cost;
    float costGradient[3];
    float costHessian[3][3];

    // MEMBER FUNCTION(S):
    float* calcCostGradient(const float newInput[3]);
    float** calcCostHessian(const float newInput[3]);

  public:
    // CONSTRUCTOR:
    StateCost(const float newInput[3]);

    // MEMBER FUNCTION(S):
    float calcStateCost(const float newInput[3]);
    bool calcNewCostParameters(const float newInput[3]);
  };
}

#endif
