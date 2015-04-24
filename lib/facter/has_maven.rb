Facter.add(:has_maven) do
  setcode do
    if File.exist? '/usr/bin/mvn'
      'true'
    else
      'false'
    end
  end
end
