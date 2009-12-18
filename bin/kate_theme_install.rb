#!/usr/bin/env ruby

kde_settings_dir = `kde4-config --localprefix`.strip
schema_file_name = kde_settings_dir + "share/config/kateschemarc"
syntax_file_name = kde_settings_dir + "share/config/katesyntaxhighlightingrc"

kate_theme = STDIN.read
schema = kate_theme[/kateschemarc\s*\n(.*)/m, 1]
syntax = kate_theme[/katesyntaxhighlightingrc\s*\n(.*)^#.*kateschemarc/m, 1].gsub(/^#.*?\n/, '')

schema_file_content = File.read(schema_file_name)
syntax_file_content = File.read(syntax_file_name)

if schema_file_content.include?(schema.split("\n")[0])
  puts "zawiera"
else
  puts "nie zawiera"
  schema_file_content << schema
end

# p schema
# p "********"
# p syntax

