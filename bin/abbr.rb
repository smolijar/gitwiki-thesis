#!/usr/bin/env ruby

path = File.expand_path("../src/meta/abbreviations.txt", File.dirname(__FILE__))
abbreviations = File
  .read(path)
  .split("\n")
  .map{|x| x.split('-')}

File.write(
  File.expand_path("../src/meta/abbreviations.tex", File.dirname(__FILE__)),
  abbreviations.map{|acr,exp| "\\newacronym{#{acr}}{#{acr}}{#{exp}}"}.join("\n")
)

input = ARGF.read
abbreviations.each {|a,b| input.gsub! /(?<=[^A-Z])#{a}(?=[^A-Z])/, "\\gls{#{a}}" }
puts input