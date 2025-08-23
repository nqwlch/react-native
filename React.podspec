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

  # s.dependency "React-Core", version
  # s.dependency "React-Core/DevSupport", version
  # s.dependency "React-Core/RCTWebSocket", version
  # s.dependency "React-RCTActionSheet", version
  # s.dependency "React-RCTAnimation", version
  # s.dependency "React-RCTBlob", version
  # s.dependency "React-RCTImage", version
  # s.dependency "React-RCTLinking", version
  # s.dependency "React-RCTNetwork", version
  # s.dependency "React-RCTSettings", version
  # s.dependency "React-RCTText", version
  # s.dependency "React-RCTVibration", version
  s.preserve_paths          = "package.json", "LICENSE", "LICENSE-docs", "Libraries/Blob/*.js"

  s.dependency "RCT-Folly", folly_release_version
  s.dependency "DoubleConversion"
  s.dependency "boost"
  s.dependency "Yoga"
  s.dependency "glog"
  s.dependency "SocketRocket", socket_rocket_version

  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags + ' ' + use_hermes_flag
  s.resource_bundle        = { "RCTI18nStrings" => ["React/I18n/strings/*.lproj"]}
  s.weak_framework         = "JavaScriptCore"
  s.libraries            = "c++abi", "c++", "z"

  s.framework = [
      "UIKit", 
      "Accelerate",
      "QuartzCore", 
      "ImageIO", 
      "CoreGraphics",
      "MobileCoreServices",
      "AudioToolbox",
      "AVFoundation",
      "CoreLocation",
      "CoreText",
      "MapKit",
      "WebKit",
      "CoreTelephony",
      "SystemConfiguration",
      "UserNotifications",
      "Security", 
      "CFNetwork",
      "JavaScriptCore"
  ]

  s.pod_target_xcconfig    = {
    "HEADER_SEARCH_PATHS" => header_search_paths,
    "DEFINES_MODULE" => "YES",
    "GCC_PREPROCESSOR_DEFINITIONS" => "RCT_METRO_PORT=${RCT_METRO_PORT}",
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
    "FRAMEWORK_SEARCH_PATHS" => frameworks_search_paths.join(" ")
  }

  s.source_files           = [
      "React/**/*.{c,h,m,mm,S,cpp}",
      "React/Cxx*/*.{h,m,mm}",
      "React/DevSupport/*",
      "React/Inspector/*",
      "ReactCommon/jsinspector/*.{cpp,h}",
      "ReactCommon/jsiexecutor/jsireact/*.{cpp,h}",
      "ReactCommon/jsi/*.{cpp,h}",
      "ReactCommon/cxxreact/*.{cpp,h}",
      "Libraries/ActionSheetIOS/**.{h,m}",
      "Libraries/ART/**/*.{h,m}",
      "Libraries/NativeAnimation/{Drivers/*,Nodes/*,*}.{h,m}",
      "Libraries/Blob/*.{h,m,mm}",
      "Libraries/Geolocation/*.{h,m}",
      "Libraries/Image/*.{h,m}",
      "Libraries/Network/*.{h,m,mm}",
      "Libraries/PushNotificationIOS/*.{h,m}",
      "Libraries/Settings/*.{h,m}",
      "Libraries/Text/**/*.{h,m}",
      "Libraries/Vibration/*.{h,m}",
      "Libraries/WebSocket/*.{h,m}",
      "Libraries/LinkingIOS/*.{h,m}"
  ]

  exclude_files = [
    "**/__tests__/*",
    "IntegrationTests/*",
    # "React/DevSupport/**/*",
    # "React/Inspector/*",
    "ReactCommon/yoga/*",
    # "React/Cxx*/*",
    "React/Fabric/**/*",
    # "React/FBReactNativeSpec/**/*",
    "React/Tests/**/*",
    "ReactCommon/cxxreact/SampleCxxModule.*"
  ]
  # If we are using Hermes (the default is use hermes, so USE_HERMES can be nil), we don't have jsc installed
  # So we have to exclude the JSCExecutorFactory
  if use_hermes
    exclude_files = exclude_files.append("React/CxxBridge/JSCExecutorFactory.{h,mm}")
  end
  s.exclude_files = exclude_files
  s.ios.exclude_files    = "React/**/RCTTVView*.*"
  s.tvos.exclude_files   = "React/Modules/RCTClipboard*",
                            "React/Views/RCTDatePicker*",
                            "React/Views/RCTPicker*",
                            "React/Views/RCTRefreshControl*",
                            "React/Views/RCTSlider*",
                            "React/Views/RCTSwitch*",
                            "React/Views/RCTWebView*"

  s.resource_bundles = {'React-Core_privacy' => 'React/Resources/PrivacyInfo.xcprivacy'}


end
