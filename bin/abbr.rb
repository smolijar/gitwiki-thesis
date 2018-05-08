#!/usr/bin/env ruby

path = File.expand_path("../src/meta/abbreviations.txt", File.dirname(__FILE__))
abbreviations, glossaries = File
  .read(path)
  .split(/%.*\n/)
  .map{|x| x.split("\n").map{|ln| ln.split('-', 2)} }

File.write(
  File.expand_path("../src/meta/abbreviations.tex", File.dirname(__FILE__)),
  [
    abbreviations.map{|acr,exp| "\\newacronym{#{acr}}{#{acr}}{#{exp}}"}.join("\n"),
    glossaries.map{|acr,exp| "\\newglossaryentry{#{acr}}{name={#{acr}}, description={#{exp}}}"}.join("\n")
  ].join("\n")
)

input = ARGF.read
abbreviations.each {|a,b| input.gsub! /(?<=[^A-Z])#{a}(?=[^A-Z])/, "\\acrshort{#{a}}" }
glossaries.each {|a,b| input.gsub! /(?<=[^a-zA-Z])#{a}(?=[^a-zA-Z])/, "\\gls{#{a}}" }

input.gsub! /<<[a-zA-Z\.\/]+>>/ do |s|
  filename = s.match(/^<<(.*)>>$/).captures.first
  path = File.expand_path("../src/listing/#{filename}", File.dirname(__FILE__))
  if File.exist? path
    File.read(path)
  else
    s
  end
end

puts input