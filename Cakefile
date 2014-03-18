{exec} = require 'child_process'
Rehab = require 'rehab'

task 'build', 'Build coffee2js using Rehab', sbuild = ->
  console.log "Building project from app/scripts/*.coffee to public/js/app.js"

  files = new Rehab().process './app/scripts'

  to_single_file = "--join public/js/app.js"
  from_files = "--compile #{files.join ' '}"

  exec "coffee #{to_single_file} #{from_files}", (err, stdout, stderr) ->
    throw err if err
