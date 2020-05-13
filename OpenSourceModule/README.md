# 开源模块介绍

### [`Mytable`](./Mytable.lua)
>table补充函数库

`table.clone`表克隆</br>
`table.getLength`表长度</br>
`table.mixTable`表混合</br>
`table.stringSplit`字符串切割成表（不含空字符串值）</br>
`table.stringSplitKeepEmpty`字符串切割成表（含空字符串值）</br>
`table.split2DepthTable`切割字符串成纵深形式（树状）的表</br>
`table.split2DepthTable_OLD`旧版table.split2DepthTable</br>
`table.continuousIndex`表连续索引</br>
`table.shallowClone`表浅克隆</br>
`table.toNumberIndex`表转数字索引形式</br>
`table.getFirst`获得表的第一个键值对（一般用于table.toNumberIndex后获得表内数据）</br>

### [`Mystring`](./Mystring.lua)
>string补充函数库

`string.findTable`按表查找</br>
`string.equalTable`按表完整匹配（table.find）</br>
`string.findStartsWithTable`按表匹配开始（luajava）</br>
`string.findEndsWithTable`按表匹配结尾（luajava）</br>
`string.gsubByTable`按表批量gsub</br>
`string.decodeURL`URL解码</br>
`string.encodeURL`URL编码</br>
`string.unLuaSymbol`lua抗转义</br>
`string.gkeepUrl`截取URL(仅http和https)</br>
`string.guessFileName`获取基于URL获得文件名（luajava）</br>
`string.keepDomainName`基于URL截取域名</br>
`string.getExtensionName`通过路径获得拓展名</br>
`string.getExtensionNameByFile`通过文件名获得拓展名</br>
`string.getMD5`获得字符串MD5</br>

