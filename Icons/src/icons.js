.pragma library

//Icon set
var<% @glyphs.each do |name, value| %>
<%= name.to_s.upcase %> = "\u<%= value[:codepoint].to_s(16).upcase %>",<% end %>
_="";
