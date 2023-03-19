local Path = GetPath()
local GamePath = "/GameData/" .. Path
local P3DFile = P3D.P3DFile(GamePath)
local pool = GetSetting("rand_pool")
if (pool == 1) then
  -- Here are the animation files
  local filenames = {
    "apu_a.p3d",
    "bart_a.p3d",
    "homer_a.p3d",
    "lisa_a.p3d",
    "marge_a.p3d",
    "ndr_a.p3d",
    "npd_a.p3d",
    "nps_a.p3d"
  }
  for i=1, #P3DFile.Chunks do
    local file = P3D.P3DFile("/GameData/art/chars/" .. filenames[math.random(#filenames)])
    local new_anim =  file.Chunks[ math.random(#file.Chunks)]
    new_anim.Name = P3DFile.Chunks[i].Name
    P3DFile.Chunks[i] = new_anim
  end
else
  local animations = {}
  function ShuffleList(tbl)
    for i = #tbl, 2, -1 do
      local j = math.random(i)
      tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
  end
  -- Get all the animations names
  local i = 1
  for chunk in P3DFile:GetChunks(P3D.Identifiers.Animation) do
    animations[i] = chunk.Name
    i=i+1
  end
  -- Shuffle
  animations = ShuffleList(animations)
  -- Rename chunks in shuffled order
  i = 1
  for chunk in P3DFile:GetChunks(P3D.Identifiers.Animation) do
    chunk.Name = animations[i]
    i=i+1
  end
end
-- After modifications
P3DFile:Output()