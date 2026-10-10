require 'cocoapods'
require 'xcodeproj'

module DeploymentTargetPatch
  def self.patch(workspace_path)
    pods_project_path = File.join(
      File.dirname(workspace_path),
      'Pods',
      'Pods.xcodeproj'
    )

    return unless File.exist?(pods_project_path)

    project = Xcodeproj::Project.open(pods_project_path)

    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end

    project.save

    puts "[Hook] Patched Pods deployment target to iOS 15.0"
  end
end

module Pod
  class Validator
    alias_method :original_build_pod, :build_pod

    def build_pod
      workspace = Dir.glob(
        File.join(Dir.tmpdir, 'CocoaPods-Lint-*', 'App.xcworkspace')
      ).max_by { |path| File.mtime(path) }

      DeploymentTargetPatch.patch(workspace) if workspace

      original_build_pod
    end
  end
end
