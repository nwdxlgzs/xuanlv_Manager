require "import"
--警告，这里部分函数涉及luajava！！！
--字符串按表内各项find
string.findTable = function (tables,str)
  for index,content in ipairs(tables) do
    if str:find(content) then
      return true
    end
  end
end
--字符串按表各项相等式查找
string.equalTable = function (tables,str)
  --return table.find(tables,str)--新版
  --旧版
  --[暂时使用旧版[--
  for index,content in ipairs(tables) do
    if str == tostring(content) then
      return true
    end
  end
  --]]--
end
--字符串按表各项开头查找
string.findStartsWithTable = function (tables,str)
  str=String(str)
  for index,content in ipairs(tables) do
    if str.startsWith(content) then
      return true
    end
  end
end
--字符串按表各项结尾查找
string.findEndsWithTable = function (tables,str)
  str=String(str)
  for index,content in ipairs(tables) do
    if str.endsWith(content) then
      return true
    end
  end
end
--字符串按表各项匹配项批量指定替换成统一的内容
string.gsubByTable= function (tables,str,s)
  for index,content in ipairs(tables) do
    str=string.gsub(str,content,s)
  end
  return str
end
--URL解码
string.decodeURL=function(s)
  local s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
  return s
end
--URL编码
string.encodeURL=function(s)
  local s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
  return string.gsub(s, " ", "+")
end
--lua抗转义
string.unLuaSymbol=function(kk)
  kk=kk:gsub('%%','%%%%')
  kk=kk:gsub('%(','%%(')
  kk=kk:gsub('%)','%%)')
  kk=kk:gsub('%.','%%.')
  kk=kk:gsub('%+','%%+')
  kk=kk:gsub('%-','%%-')
  kk=kk:gsub('%*','%%*')
  kk=kk:gsub('%?','%%?')
  kk=kk:gsub('%[','%%[')
  kk=kk:gsub('%^','%%^')
  kk=kk:gsub('%$','%%$')
  return kk
end
--截取URL(仅http和https)
string.gkeepUrl=function(str)
  local strurltab={}
  for i,v in string.gfind(str,"https?://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]") do
    strurltab[#strurltab+1]=string.sub(str,i,v)
  end
  return strurltab
end
--获取基于URL获得文件名
string.guessFileName=function(str)
  local a,b
  if string.sub(str,-1) == "/" then--判断后头是不是/
    str=string.sub(str,0,-1)--切掉，，，事实上，通常/后头是index.什么的，但是你叫我怎么猜，返回给你一个得了
  end
  str="emptystr/"..str--防止空截字符串
  if str:find(".+/.+%?.+$") then--判断有无最后的/处有?
    a=str:match(".+/(.+)%?.+$")--有
   else
    a=str:match(".+/(.+)$")--没有
  end
  if a then--如果成功
    if a:find(".+#%w+$") then--判断有无#，这个是由于H5中js的锅，得处理一下，后头再加符号就太不要脸了，我就当不存在这种情况了，只认为有字母和数字
      b=a:match("(.+)%#%w+$")--有，最长匹配吧，js是在后头增加的#，虽然可能部分含#文件躺枪
      if b then--如果成功
        return b--成功
       else
        return a--失败
      end
     else
      return a--没有，直接返回
    end
   else--失败再处理
    b=File(str).Name--需要import "java.io.File"
    return b--随便让java的file类猜一下返回
  end
end
--获取域名基于URL
string.keepDomainName=function(str)
  local a,b
  if str:find("://") then
    str=str:match(".-://(.+)")--截取第一次出现://后的内容
  end
  a,b=str:gsub("/","")--计数/
  if b > 1 then
    str=str:match("^(.-)/.+")--截取第一次出现/前内容
   elseif str:find("/") then
    str=str:match("(.-)/")--截取第一次出现/前内容
  end
  return str
end
--通用获得拓展名
string.getExtensionName=function(str)
  str=string.guessFileName(str)
  if str:find("%.") then
    return str:match(".+%.(.+)")
   else
    return str
  end
end
--通过文件名获得拓展名(前提得有)
string.getExtensionNameByFile=function(str)
  str="."..str
  return str:match(".+%.(.+)")
end
string.getMD5=function(s)
  local HexTable = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
  local A = 0x67452301
  local B = 0xefcdab89
  local C = 0x98badcfe
  local D = 0x10325476
  local S11 = 7
  local S12 = 12
  local S13 = 17
  local S14 = 22
  local S21 = 5
  local S22 = 9
  local S23 = 14
  local S24 = 20
  local S31 = 4
  local S32 = 11
  local S33 = 16
  local S34 = 23
  local S41 = 6
  local S42 = 10
  local S43 = 15
  local S44 = 21
  local function F(x,y,z)
    return (x & y) | ((~x) & z)
  end
  local function G(x,y,z)
    return (x & z) | (y & (~z))
  end
  local function H(x,y,z)
    return x ~ y ~ z
  end
  local function I(x,y,z)
    return y ~ (x | (~z))
  end
  local function FF(a,b,c,d,x,s,ac)
    a = a + F(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function GG(a,b,c,d,x,s,ac)
    a = a + G(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function HH(a,b,c,d,x,s,ac)
    a = a + H(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function II(a,b,c,d,x,s,ac)
    a = a + I(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function MD5StringFill(s)
    local len = s:len()
    local mod512 = len * 8 % 512
    --需要填充的字节数
    local fillSize = (448 - mod512) // 8
    if mod512 > 448 then
      fillSize = (960 - mod512) // 8
    end
    local rTab = {}
    --记录当前byte在4个字节的偏移
    local byteIndex = 1
    for i = 1,len do
      local index = (i - 1) // 4 + 1
      rTab[index] = rTab[index] or 0
      rTab[index] = rTab[index] | (s:byte(i) << (byteIndex - 1) * 8)
      byteIndex = byteIndex + 1
      if byteIndex == 5 then
        byteIndex = 1
      end
    end
    --先将最后一个字节组成4字节一组
    --表示0x80是否已插入
    local b0x80 = false
    local tLen = #rTab
    if byteIndex ~= 1 then
      rTab[tLen] = rTab[tLen] | 0x80 << (byteIndex - 1) * 8
      b0x80 = true
    end
    --将余下的字节补齐
    for i = 1,fillSize // 4 do
      if not b0x80 and i == 1 then
        rTab[tLen + i] = 0x80
       else
        rTab[tLen + i] = 0x0
      end
    end
    --后面加原始数据bit长度
    local bitLen = math.floor(len * 8)
    tLen = #rTab
    rTab[tLen + 1] = bitLen & 0xffffffff
    rTab[tLen + 2] = bitLen >> 32
    return rTab
  end
  local fillTab = MD5StringFill(s)
  local result = {A,B,C,D}
  for i = 1,#fillTab // 16 do
    local a = result[1]
    local b = result[2]
    local c = result[3]
    local d = result[4]
    local offset = (i - 1) * 16 + 1
    --第一轮
    a = FF(a, b, c, d, fillTab[offset + 0], S11, 0xd76aa478)
    d = FF(d, a, b, c, fillTab[offset + 1], S12, 0xe8c7b756)
    c = FF(c, d, a, b, fillTab[offset + 2], S13, 0x242070db)
    b = FF(b, c, d, a, fillTab[offset + 3], S14, 0xc1bdceee)
    a = FF(a, b, c, d, fillTab[offset + 4], S11, 0xf57c0faf)
    d = FF(d, a, b, c, fillTab[offset + 5], S12, 0x4787c62a)
    c = FF(c, d, a, b, fillTab[offset + 6], S13, 0xa8304613)
    b = FF(b, c, d, a, fillTab[offset + 7], S14, 0xfd469501)
    a = FF(a, b, c, d, fillTab[offset + 8], S11, 0x698098d8)
    d = FF(d, a, b, c, fillTab[offset + 9], S12, 0x8b44f7af)
    c = FF(c, d, a, b, fillTab[offset + 10], S13, 0xffff5bb1)
    b = FF(b, c, d, a, fillTab[offset + 11], S14, 0x895cd7be)
    a = FF(a, b, c, d, fillTab[offset + 12], S11, 0x6b901122)
    d = FF(d, a, b, c, fillTab[offset + 13], S12, 0xfd987193)
    c = FF(c, d, a, b, fillTab[offset + 14], S13, 0xa679438e)
    b = FF(b, c, d, a, fillTab[offset + 15], S14, 0x49b40821)
    --第二轮
    a = GG(a, b, c, d, fillTab[offset + 1], S21, 0xf61e2562)
    d = GG(d, a, b, c, fillTab[offset + 6], S22, 0xc040b340)
    c = GG(c, d, a, b, fillTab[offset + 11], S23, 0x265e5a51)
    b = GG(b, c, d, a, fillTab[offset + 0], S24, 0xe9b6c7aa)
    a = GG(a, b, c, d, fillTab[offset + 5], S21, 0xd62f105d)
    d = GG(d, a, b, c, fillTab[offset + 10], S22, 0x2441453)
    c = GG(c, d, a, b, fillTab[offset + 15], S23, 0xd8a1e681)
    b = GG(b, c, d, a, fillTab[offset + 4], S24, 0xe7d3fbc8)
    a = GG(a, b, c, d, fillTab[offset + 9], S21, 0x21e1cde6)
    d = GG(d, a, b, c, fillTab[offset + 14], S22, 0xc33707d6)
    c = GG(c, d, a, b, fillTab[offset + 3], S23, 0xf4d50d87)
    b = GG(b, c, d, a, fillTab[offset + 8], S24, 0x455a14ed)
    a = GG(a, b, c, d, fillTab[offset + 13], S21, 0xa9e3e905)
    d = GG(d, a, b, c, fillTab[offset + 2], S22, 0xfcefa3f8)
    c = GG(c, d, a, b, fillTab[offset + 7], S23, 0x676f02d9)
    b = GG(b, c, d, a, fillTab[offset + 12], S24, 0x8d2a4c8a)
    --第三轮
    a = HH(a, b, c, d, fillTab[offset + 5], S31, 0xfffa3942)
    d = HH(d, a, b, c, fillTab[offset + 8], S32, 0x8771f681)
    c = HH(c, d, a, b, fillTab[offset + 11], S33, 0x6d9d6122)
    b = HH(b, c, d, a, fillTab[offset + 14], S34, 0xfde5380c)
    a = HH(a, b, c, d, fillTab[offset + 1], S31, 0xa4beea44)
    d = HH(d, a, b, c, fillTab[offset + 4], S32, 0x4bdecfa9)
    c = HH(c, d, a, b, fillTab[offset + 7], S33, 0xf6bb4b60)
    b = HH(b, c, d, a, fillTab[offset + 10], S34, 0xbebfbc70)
    a = HH(a, b, c, d, fillTab[offset + 13], S31, 0x289b7ec6)
    d = HH(d, a, b, c, fillTab[offset + 0], S32, 0xeaa127fa)
    c = HH(c, d, a, b, fillTab[offset + 3], S33, 0xd4ef3085)
    b = HH(b, c, d, a, fillTab[offset + 6], S34, 0x4881d05)
    a = HH(a, b, c, d, fillTab[offset + 9], S31, 0xd9d4d039)
    d = HH(d, a, b, c, fillTab[offset + 12], S32, 0xe6db99e5)
    c = HH(c, d, a, b, fillTab[offset + 15], S33, 0x1fa27cf8)
    b = HH(b, c, d, a, fillTab[offset + 2], S34, 0xc4ac5665)
    --第四轮
    a = II(a, b, c, d, fillTab[offset + 0], S41, 0xf4292244)
    d = II(d, a, b, c, fillTab[offset + 7], S42, 0x432aff97)
    c = II(c, d, a, b, fillTab[offset + 14], S43, 0xab9423a7)
    b = II(b, c, d, a, fillTab[offset + 5], S44, 0xfc93a039)
    a = II(a, b, c, d, fillTab[offset + 12], S41, 0x655b59c3)
    d = II(d, a, b, c, fillTab[offset + 3], S42, 0x8f0ccc92)
    c = II(c, d, a, b, fillTab[offset + 10], S43, 0xffeff47d)
    b = II(b, c, d, a, fillTab[offset + 1], S44, 0x85845dd1)
    a = II(a, b, c, d, fillTab[offset + 8], S41, 0x6fa87e4f)
    d = II(d, a, b, c, fillTab[offset + 15], S42, 0xfe2ce6e0)
    c = II(c, d, a, b, fillTab[offset + 6], S43, 0xa3014314)
    b = II(b, c, d, a, fillTab[offset + 13], S44, 0x4e0811a1)
    a = II(a, b, c, d, fillTab[offset + 4], S41, 0xf7537e82)
    d = II(d, a, b, c, fillTab[offset + 11], S42, 0xbd3af235)
    c = II(c, d, a, b, fillTab[offset + 2], S43, 0x2ad7d2bb)
    b = II(b, c, d, a, fillTab[offset + 9], S44, 0xeb86d391)
    --加入到之前计算的结果当中
    result[1] = result[1] + a
    result[2] = result[2] + b
    result[3] = result[3] + c
    result[4] = result[4] + d
    result[1] = result[1] & 0xffffffff
    result[2] = result[2] & 0xffffffff
    result[3] = result[3] & 0xffffffff
    result[4] = result[4] & 0xffffffff
  end
  --将Hash值转换成十六进制的字符串
  local retStr = ""
  for i = 1,4 do
    for _ = 1,4 do
      local temp = result[i] & 0x0F
      local str = HexTable[temp + 1]
      result[i] = result[i] >> 4
      temp = result[i] & 0x0F
      retStr = retStr .. HexTable[temp + 1] .. str
      result[i] = result[i] >> 4
    end
  end
  return retStr
end







