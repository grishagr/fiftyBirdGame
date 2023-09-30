function love.conf(t)
  t.releases = {
    title = nil,              -- The project title (string)
    package = nil,            -- The project command and package name (string)
    loveVersion = nil,        -- The project LÖVE version
    version = nil,            -- The project version
    author = nil,             -- Your name (string)
    email = nil,              -- Your email (string)
    description = nil,        -- The project description (string)
    homepage = nil,           -- The project homepage (string)
    identifier = nil,         -- The project Uniform Type Identifier (string)
    excludeFileList = {},     -- File patterns to exclude. (string list)
    releaseDirectory = nil,   -- Where to store the project releases (string)
  }
end