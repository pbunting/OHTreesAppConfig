Pod::Spec.new do |spec|
  spec.name = "OHTreesAppConfig"
  spec.version = "1.0.0"
  spec.summary = "Simple framework to handle configuration for applications."
  spec.homepage = "https://github.com/pbunting/OHTreesAppConfig"
  spec.license = { type: 'GNU', file: 'LICENSE' }
  spec.authors = { "Your Name" => 'your-email@example.com' }

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/pbunting/OHTreesAppConfig.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "OHTreesStorageAppConfig/**/*.{h,swift}"

end

