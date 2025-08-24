# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.



version = "0.78.3"
source = { :git => 'https://github.com/nqwlch/react-native.git' }
source[:tag] = "v#{version}"

folly_compiler_flags = "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32"
folly_release_version = "2024.11.18.0"

socket_rocket_version = '0.7.1'

boost_compiler_flags = "-Wno-documentation" 

use_hermes = false
use_hermes_flag = use_hermes ? "-DUSE_HERMES=1" : ""

header_search_paths = [
  "$(PODS_TARGET_SRCROOT)/ReactCommon",
  "$(PODS_ROOT)/boost",
  "$(PODS_ROOT)/DoubleConversion",
  "$(PODS_ROOT)/fast_float/include",
  "$(PODS_ROOT)/fmt/include",
  "$(PODS_ROOT)/RCT-Folly",
  "${PODS_ROOT}/Headers/Public/FlipperKit",
  "$(PODS_ROOT)/Headers/Public/ReactCommon",
  "${PODS_ROOT}/Headers/Public/ReactCodegen/react/renderer/components",
  "$(PODS_ROOT)/RCT-Folly",
  "$(PODS_ROOT)/boost",
  "$(PODS_ROOT)/DoubleConversion",
  "$(PODS_ROOT)/fast_float/include",
  "$(PODS_ROOT)/fmt/include",
  "${PODS_ROOT}/Headers/Public/ReactCodegen/react/renderer/components",
  "$(PODS_CONFIGURATION_BUILD_DIR)/React-debug/React_debug.framework/Headers", 
  "${PODS_CONFIGURATION_BUILD_DIR}/React-runtimeexecutor/React_runtimeexecutor.framework/Headers"
].concat(use_hermes ? [
  "$(PODS_ROOT)/Headers/Public/React-hermes",
  "$(PODS_ROOT)/Headers/Public/hermes-engine"
] : [])

frameworks_search_paths = []
frameworks_search_paths << "\"$(PODS_CONFIGURATION_BUILD_DIR)/React-hermes\"" if use_hermes

Pod::Spec.new do |s|
  s.name                   = "React"
  s.version                = version
  s.summary                = "."
  s.description            = <<-DESC
                               React Native apps are built using the React JS
                               framework, and render directly to native UIKit
                               elements using a fully asynchronous architecture.
                               There is no browser and no HTML. We have picked what
                               we think is the best set of features from these and
                               other technologies to build what we hope to become
                               the best product development framework available,
                               with an emphasis on iteration speed, developer
                               delight, continuity of technology, and absolutely
                               beautiful and fast products with no compromises in
                               quality or capability.
                             DESC
  s.homepage               = "https://reactnative.dev/"
  s.license                = "MIT"
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '15.1' }
  s.source                 = source
  s.preserve_paths         = "package.json", "LICENSE", "LICENSE-docs"
  s.cocoapods_version      = ">= 1.10.1"

  s.dependency "React-Core", version
  s.dependency "React-Core/DevSupport", version
  s.dependency "React-Core/RCTWebSocket", version
  s.dependency "React-RCTActionSheet", version
  s.dependency "React-RCTAnimation", version
  s.dependency "React-RCTBlob", version
  s.dependency "React-RCTImage", version
  s.dependency "React-RCTLinking", version
  s.dependency "React-RCTNetwork", version
  s.dependency "React-RCTSettings", version
  s.dependency "React-RCTText", version
  s.dependency "React-RCTVibration", version
  
  
end
