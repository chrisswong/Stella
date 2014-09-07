json.array!(@builds) do |build|
  json.extract! build, :id, :number, :version, :releaseNotes, :platform, :buildIdenifier, :accessToken, :domain, :provision, :displayname, :icon, :buildFilePath
  json.url build_url(build, format: :json)
end
