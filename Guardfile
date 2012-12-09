guard :test do
  watch(%r{^lib/has_uuid/(.+)\.rb$})           { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/(.+)_test\.rb$})              { |m| "lib/has_uuid/#{m[1]}.rb" }
end
