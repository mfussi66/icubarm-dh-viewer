/******************************************************************************
 *                                                                            *
 * Copyright (C) 2021 Fondazione Istituto Italiano di Tecnologia (IIT)        *
 * All Rights Reserved.                                                       *
 *                                                                            *
 ******************************************************************************/

#ifndef FKINMODULE_H_
#define FKINMODULE_H_

#include <iCub/iKin/iKinFwd.h>
#include <yarp/os/ResourceFinder.h>
#include <yarp/sig/Vector.h>

#include <iostream>
#include <memory>
#include <string>
#include <vector>

class KinModule {
 public:
  /**
   * @brief Construct a new KinModule object
   *
   * @param axesListValues List of axes used by iDynTree to construct the
   *                       kinematic chain.
   */
  explicit KinModule(const std::string& armtype);

  /**
   * @brief Destroy the Kin Module object
   *
   */
  ~KinModule();

  /**
   * @brief Configures the data structures used by the class, by loading the
   *        command line arguments via ResourceFinder.
   *
   * @param rf Object used to parse command line arguments.
   * @return true if successful, false otherwise.
   */
  bool configure(const yarp::os::ResourceFinder& rf);
  void evaluateKinematics();

 private:

  /** @brief iKin arm object */
  iCub::iKin::iCubArm arm;
  /** @brief Container for the arm properties. */
  yarp::os::Property armProperties;
  /** @brief Joints values expressed in [deg].  */
  yarp::sig::Vector jointsValues;
};

#endif  // FKINMODULE_H_
