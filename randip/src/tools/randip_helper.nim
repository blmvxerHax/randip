import strutils, streams, random

var
  census = "../temp/randip.census"
  input = newFileStream(census, fmRead)
  data = readAll(input)
  badAddr: seq[string]

badAddr = @["10", "127", "192", "224", "240"]

proc genAddr*(): string =
  randomize()
  var
     ip0 = rand(1..255)
     ip1 = rand(255)
     ip2 = rand(255)
     ip3 = rand(255)
  for i, v in badAddr:
    if intToStr(ip0) == v:
      ip0 = rand(1..255)
  return (join([$ip0, $ip1, $ip2, $ip3], "."))


proc testAddr*(host: string): string =
  for i in data.splitLines:
    if host == i:
      return genAddr()
    else:
      return host
