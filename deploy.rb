#!/usr/bin/env ruby

require 'fileutils'

SOURCE = "#{Dir.home}/openb"

DESTINATION = "#{Dir.home}/"

Dir.glob("#{Dir.home}/#{SOURCE}/.", File::FNM_DOTMATCH).each { |f| FileUtils.cp_r("#{f}", DESTINATION, :verbose => true) }
