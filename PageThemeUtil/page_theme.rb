require 'rexml/document'
require 'json'
include REXML

if ARGV.length != 1
   puts "need file path"
   abort
end

json_path = ARGV[0]

file_content = File.read(json_path)
themeHash = JSON.parse(file_content);
themeHash.each do | pair |

   orangeImageName = pair['o']
   redImageName = pair['r']
   files = Dir.glob("../**/*.xib")
   for file_path in files
      fileContent = File.new(file_path)
      xmldoc = Document.new(fileContent)
      target = XPath.match(xmldoc, "//*[@backgroundImage='#{orangeImageName}']")
      for row in target
         #delete older ones
         users = row.parent.elements["userDefinedRuntimeAttributes]"]
         
         ary = Array.new#save extra runtimeAttr to ary
         if users && users.has_elements?
            users.elements.each {|node|
              keyPath =  node.attributes['keyPath']
              if keyPath != "orangeImageName" && keyPath != "redImageName"
                 ary.push(node)
              end
            }
         end
         row.parent.delete_element "userDefinedRuntimeAttributes"

         if redImageName.end_with? "png"
            #add new runtime attr
            userDefinedRuntimeAttributes = Element.new 'userDefinedRuntimeAttributes'
            #add old extra runtimeAttr
            ary.each {|node| 
               userDefinedRuntimeAttributes.add_element node
            }
            userDefinedRuntimeAttributes.add_element 'userDefinedRuntimeAttribute',{'type'=>'string','keyPath'=>'orangeImageName', 'value'=>"#{orangeImageName}"}
            userDefinedRuntimeAttributes.add_element 'userDefinedRuntimeAttribute',{'type'=>'string','keyPath'=>'redImageName', 'value'=>"#{redImageName}"}
            row.parent.add_element userDefinedRuntimeAttributes
         end
      end

      if target.length > 0
         puts "#{file_path} changed"
      end 

      File.open(file_path, "w") do |data|
         data<<xmldoc
      end
   end
end




