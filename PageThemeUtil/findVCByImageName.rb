require 'rexml/document'
require 'json'
include REXML

if ARGV.length != 1
   puts "need file path"
   abort
end

orangeImageName = ARGV[0]

files = Dir.glob("../**/*.xib")
for file_path in files
   fileContent = File.new(file_path)
   xmldoc = Document.new(fileContent)
   target = XPath.match(xmldoc, "//*[@backgroundImage='#{orangeImageName}']")
   if target.length > 0
      puts "#{file_path}"
   end 
end




