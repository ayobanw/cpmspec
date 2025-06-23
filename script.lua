local github_user = "ayobanw"
local repo_name = "cpmspec"
local key_file = "keys.txt"
local script_file = "SCRIPT SPEC GitHub V4.9.2.lua"

local key_url = "https://raw.githubusercontent.com/" .. github_user .. "/" .. repo_name .. "/main/" .. key_file
local script_url = "https://raw.githubusercontent.com/" .. github_user .. "/" .. repo_name .. "/main/" .. script_file

local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

local inputKey = gg.prompt({"Masukkan Key (Password) Anda:"})
if not inputKey or not inputKey[1] or inputKey[1] == "" then
  gg.alert("Tiada input diterima, skrip ditamatkan.")
  os.exit()
end
inputKey = trim(inputKey[1])

local keyRequest = gg.makeRequest(key_url)
if not keyRequest or not keyRequest.content then
  gg.alert("❌ Gagal mendapatkan senarai key. Semak sambungan internet atau URL.")
  os.exit()
end

if not keyRequest.content:find(inputKey, 1, true) then
  gg.alert("❌ Key tidak sah. Hubungi admin untuk akses.")
  os.exit()
end

local scriptRequest = gg.makeRequest(script_url)
if not scriptRequest or not scriptRequest.content then
  gg.alert("❌ Gagal memuat skrip utama dari GitHub. Semak sambungan internet atau URL.")
  os.exit()
end

local func, err = load(scriptRequest.content)
if not func then
  gg.alert("❌ Ralat muat skrip utama: " .. tostring(err))
  os.exit()
end

func()
