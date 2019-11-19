Pod::Spec.new do |spec|

  spec.name         = "InBrainSurveys_SDK_Swift"
  spec.version      = "1.0.4"
  spec.summary      = "Survey library to monetize your mobile app."

  spec.description  = <<-DESC
  Survey library to monetize your mobile app, provided by InBrain.
                   DESC

  spec.homepage     = "https://github.com/inBrainSurveys/InBrainSurveys_SDK_Swift"
  spec.license          = { :type => 'Copyright', :text => <<-LICENSE
                                    Copyright 2019
                                    Permission is granted to inBrain partners through signed binding agreement
                                    LICENSE
                                    }

  spec.author             = { "inBrainSurveys" => "joel@inbrain.ai" }
  spec.platform = :ios, "10.0"
  spec.swift_version = "4.2"
  spec.source       = { :git => "https://github.com/inBrainSurveys/InBrainSurveys_SDK_Swift.git", :tag => "1.0.4" }
  spec.vendored_frameworks = "InBrainSurveys_SDK_Swift.framework"
  spec.source_files  = "InBrainSurveys_SDK_Swift.framework/Headers/*.h"
  spec.public_header_files = "InBrainSurveys_SDK_Swift.framework/Headers/*.h"

end
