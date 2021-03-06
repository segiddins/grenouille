require File.expand_path('../spec_helper', __FILE__)

module Grenouille
  describe Xcode do
    it 'can retrieve the version number of the currently selected Swift' do
      Xcode.any_instance.stubs(:`).returns("Apple Swift version 1.3 (swiftlang-602.0.49.6 clang-602.0.49)\nTarget: x86_64-apple-darwin14.4.0")

      Xcode.new.current_swift_version.should == Gem::Version.new('1.3')
    end

    it 'can retrieve the version of Swift 1.1' do
      Xcode.any_instance.stubs(:`).returns('Swift version 1.1 (swift-600.0.57.4)')

      Xcode.new.current_swift_version.should == Gem::Version.new('1.1')
    end

    it 'can retrieve the version number of the currently selected Xcode' do
      Xcode.any_instance.stubs(:`).returns("Xcode 3.2.1\nBuild version 6D1002")

      Xcode.new.current_version.should == Gem::Version.new('3.2.1')
    end

    it 'is resilient against xcodebuild not producing any output' do
      Xcode.any_instance.stubs(:`).returns('')

      Xcode.new.current_version.should.be.nil
    end

    it 'is resilient against xcodebuild not producing the desired output' do
      Xcode.any_instance.stubs(:`).returns(File.read(__FILE__))

      Xcode.new.current_version.should.be.nil
    end
  end
end
