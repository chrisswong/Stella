json.array!(@builds) do |build|
  json.extract! build, :id, :number, :version, :releaseNotes, :platform, :buildIdenifier, :accessToken, :domain, :provision, :createDate, :displayname, :icon
  json.url build_url(build, format: :json)
end
