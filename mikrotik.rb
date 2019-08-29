def upload_mikrotik_script(machine, source_file_path, target_script_name)
    puts "Uploading script '#{target_script_name}' from file '#{source_file_path}'"
  
    system("vagrant", "ssh", "#{machine.name}", "--", ":if ([:len [/system script find " +
      "name=\"#{target_script_name}\"]] != 0) do={ :put \"Target script already exists. Removing\"; " +
      "/system script remove #{target_script_name} }")
  
    machine.communicate.tap do |comm|
      comm.upload(source_file_path, "temp_script_2del.rsc")
    end
    system("vagrant", "ssh", "#{machine.name}", "--", "/system script add name=" +
      target_script_name + " source=[/file get temp_script_2del.rsc contents]")
    system("vagrant", "ssh", "#{machine.name}", "--", ":delay 5; /file remove temp_script_2del.rsc")
  end