#!/usr/bin/env bash

# home position by icubsim - loose L shape
if [[ $1 -eq 1 ]]; then 
fkinview --joints "(0.0 0.0 0.0 0.0 0.0 0.0 60.5 0.0 0.0 0.0)"
fi

# Arm in L shape - 90deg elbow
if [[ $1 -eq 2 ]]; then
fkinview --joints "(0.0 0.0 0.0 0.0 0.0 0.0 90.5 0.0 0.0 0.0)"
fi

# Arm in T-pose with palm facing forward
if [[ $1 -eq 3 ]]; then
fkinview --joints "(0 0 0 0 90 -30 15 0 0 0)"
fi

# Shoulder lift up with arm in L-shape and hand with negative pitch
if [[ $1 -eq 4 ]]; then 
fkinview --joints "(0.0 0.0 0.0 0.0 135.0 0.0 90.5 -90.0 -30.6 20.4)"
fi
