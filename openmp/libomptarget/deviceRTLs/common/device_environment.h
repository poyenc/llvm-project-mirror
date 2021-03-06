//===---- device_environment.h - OpenMP GPU device environment --- CUDA -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Global device environment
//
//===----------------------------------------------------------------------===//

#ifndef _OMPTARGET_DEVICE_ENVIRONMENT_H_
#define _OMPTARGET_DEVICE_ENVIRONMENT_H_

#include "target_impl.h"

// See D70971 for discussion of sharing device_environment.h between devices
#ifdef __AMDGCN__
#include "../../../src/device_env_struct.h"
#else
struct omptarget_device_environmentTy {
  int32_t debug_level;
};
#endif

extern omptarget_device_environmentTy omptarget_device_environment;

#endif
