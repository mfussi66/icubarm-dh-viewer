/******************************************************************************
 *                                                                            *
 * Copyright (C) 2021 Fondazione Istituto Italiano di Tecnologia (IIT)        *
 * All Rights Reserved.                                                       *
 *                                                                            *
 ******************************************************************************/

#include "fkinModule.h"

#include <iCub/ctrl/math.h>
#include <yarp/math/Math.h>
#include <yarp/os/Property.h>
#include <yarp/sig/Matrix.h>

#include <utility>
#include <fstream>

/**
 * Definitions of KinModule functions
 */
KinModule::KinModule(const std::string& armtype)
    : arm(armtype),
      armProperties(),
      jointsValues() {}

KinModule::~KinModule() {}

bool KinModule::configure(const yarp::os::ResourceFinder& rf) {
  if (rf.check("help")) {
    std::cout << "fkin arguments:" << std::endl
              << "--joints \"(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0)\"" << std::endl;
    return false;
  }

  if (!rf.check("joints")) {
    std::cout << "Joints values not provided." << std::endl;
    return false;
  } else {
    const auto* jointsList = rf.find("joints").asList();
    for (size_t i = 0; i < jointsList->size(); ++i) {
      jointsValues.push_back(jointsList->get(i).asDouble());
    }
  }

  jointsValues *= iCub::ctrl::CTRL_DEG2RAD;
  std::swap(jointsValues[0], jointsValues[2]);

  // Enable positioning of torso joints
  arm.releaseLink(0);
  arm.releaseLink(1);
  arm.releaseLink(2);

  arm.toLinksProperties(armProperties);

  // Remove constraints from joints
  arm.setAllConstraints(false);

  return true;
}

void KinModule::evaluateKinematics() {
  auto KinH = arm.getH(jointsValues);

  std::ofstream propertiesfile;

  propertiesfile.open(armProperties.find("type").toString() + ".txt");

  propertiesfile << "-------------------------" << std::endl
            << "------- " << armProperties.find("type").toString() << " -------" << std::endl
            << "-------------------------" << std::endl;

  propertiesfile << "Transform: " << std::endl << KinH.toString(5, 3) << std::endl;

  propertiesfile << "Properties: " << std::endl
            << armProperties.toString() << std::endl;
  
  propertiesfile << "H0: " << std::endl
            << armProperties.find("H0").toString() << std::endl;

  for (int i = 0; i < arm.getN(); ++i) {
     propertiesfile << armProperties.findGroup("link_" + std::to_string(i)).toString() << std::endl;
  }

  propertiesfile << "HN: " << std::endl
            << armProperties.find("HN").toString() << std::endl;

  propertiesfile << "-------------------------" << std::endl;


  propertiesfile.close();
}
