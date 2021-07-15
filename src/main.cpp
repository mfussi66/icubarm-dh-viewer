/******************************************************************************
 *                                                                            *
 * Copyright (C) 2021 Fondazione Istituto Italiano di Tecnologia (IIT)        *
 * All Rights Reserved.                                                       *
 *                                                                            *
 ******************************************************************************/

#include "fkinModule.h"

#include <string>
#include <vector>

int main(int argc, char *argv[]) {
  yarp::os::ResourceFinder rf;

  rf.setDefaultContext("fkin");
  rf.configure(argc, argv);


  KinModule mod_v1("left_v1.0");
  KinModule mod_v2("left_v2.0");
  KinModule mod_v25("left_v2.5");
  KinModule mod_v3("left_v3.0");

  if (!mod_v1.configure(rf)) {
    return EXIT_FAILURE;
  }

  if (!mod_v2.configure(rf)) {
    return EXIT_FAILURE;
  }

  if (!mod_v25.configure(rf)) {
    return EXIT_FAILURE;
  }

  if (!mod_v3.configure(rf)) {
    return EXIT_FAILURE;
  }

  mod_v1.evaluateKinematics();
  mod_v2.evaluateKinematics();
  mod_v25.evaluateKinematics();
  mod_v3.evaluateKinematics();

  return EXIT_SUCCESS;
}
