require "import"
--table克隆
if not table.clone then--泥人后期增加了c层的拷贝。判断一下
  table.clone=function(t)
    if nil == t then return nil end
    local res = {}
    for k,v in pairs(t) do
      if 'table' == type(v) then
        res[k] = table.clone(v)
       else
        res[k] = v
      end
    end
    return res
  end
end
--表的真实长度
table.getLength=function(T)
  --if nil==T then return end
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end
--表操作：table合并。第二个会覆盖第一个。返回第一个表
table.mixTable=function(dest,src)
  for v in pairs(src) do
    if type(src[v]) == "table" then
      if not dest[v] then--如果是表且没有，就直接克隆
        dest[v]=table.clone(src[v])
       else--如果是表，但是有了，就进行进一步内容的检查
        if type(dest[v])~= "table" then
          dest[v]=table.clone(src[v])
         else
          local dest = table.mixTable(dest[v],src[v])
        end
      end
     else--非表直接赋值
      dest[v]=src[v]
    end
  end
  return dest
end
--按规则切割成以数字为索引的表，这玩意不含空字符串
table.stringSplit=function(str, split_char)
  local sub_str_tab = {}
  while true do
    local pos = string.find(str, split_char);
    if not pos then
      if str~="" then
        sub_str_tab[#sub_str_tab + 1] = str;
      end
      break
    end
    local sub_str = string.sub(str, 1, pos - 1);
    sub_str_tab[#sub_str_tab + 1] = sub_str;
    str = string.sub(str, pos + 1, #str);
  end
  return sub_str_tab;
end
--按规则切割成以数字为索引的表，这玩意含空字符串
table.stringSplitKeepEmpty=function(str,split_char)
  local sub_str_tab = {}
  while true do
    local pos = string.find(str, split_char);
    if (not pos) then
      sub_str_tab[#sub_str_tab + 1] = str;
      break
    end
    local sub_str = string.sub(str, 1, pos - 1);
    sub_str_tab[#sub_str_tab + 1] = sub_str;
    str = string.sub(str, pos + 1, #str);
  end
  return sub_str_tab;
end
--切割字符串成纵深形式的表
table.split2DepthTable=function(str,target)
  local T={}
  local d=table.stringSplit(str,target)
  local tt=T
  for k,v in pairs(d) do
    if k>=#d then
      tt[v]=true
     else
      tt[v]={}
      tt=tt[v]
    end
  end
  return T
end
--切割字符串成纵深形式的表旧版match配合load
table.split2DepthTable_OLD=function(str,target)
  local s="{<//>}"
  local p=str..target
  local _s=p:gmatch("(.-)"..target)
  for v in _s do
    s=s:gsub("<//>","['"..v.."']={<//>}")
  end
  s=s:gsub("{<//>}","true")
  return load("return "..s)()
end
--table连续索引，第一个是表，第二个是索引数据，可以是表也可以多个参数
table.continuousIndex=function(T,...)
  local cmdl={...}
  if type(cmdl[1])=="table" then
    cmdl=cmdl[1]
  end
  local index=cmdl[1]
  if #cmdl>1 then
    local tmp=T
    for _,v in ipairs(cmdl) do
      tmp=tmp[v]
    end
    return tmp
   else
    return T[index]
  end
end
--表的浅克隆
table.shallowClone=function(t)
  if nil == t then return nil end
  local res = {}
  for k,v in pairs(t) do
    if 'table' == type(v) then
      res[k] = {}
     else
      res[k] = v
    end
  end
  return res
end
--表做数字索引
table.toNumberIndex=function(t)
  if nil == t then return nil end
  local res = {}
  for k,v in pairs(t) do
    table.insert(res,{[k]=v})
    --res[#res+1]=t[k]
  end
  return res
end
--表获得第一个的k,v
table.getFirst=function(t)
  if table.getLength(t)>0 then
    for k,v in pairs(t) do
      return k,v
      --break
    end
   else
    return nil,nil
  end
end
--表浅层k,v互换
table.exchange=function(t)
  if nil == t then return nil end
  local res = {}
  for k,v in pairs(t) do
    if 'table' == type(v) then
      res[k] = {}
     else
      res[v] = k
    end
  end
  return res
end
--表(浅层数组)去重
table.keepOne=function(T)
  local t,Tt={},{}
  for k,v in pairs(T) do
    t[v]=true
  end
  for k,v in pairs(t) do
    table.insert(Tt,k)
  end
  return Tt
end



