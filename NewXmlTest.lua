function IsArrayTable(t)
	if type(t) ~= "table" then
        return false
    end
 
    local n = #t
    for i,v in pairs(t) do
        if type(i) ~= "number" then
            return false
        end
        
        if i > n then
            return false
        end 
    end
 
    return true 
end


function GetArrayElemCount(t)
	if t == nil then
		return 0
	end
	
	if not IsArrayTable(t) then
		return 1
	end
	
	return #t
end


function MainTest()
	local xmlstr = "<stage id='1'>"
	for nIndex=0,180 do
		xmlstr = xmlstr .. string.format([[<unit id='%d' basetype='%d' specialtype='%d' specialextype='%d'><elem type='2' layercount='3' dir='4' /></unit>]], nIndex, nIndex, nIndex, nIndex)
	end
	xmlstr = xmlstr.."</stage>"
	
	-- ÆðÊ¼tick
	local tick = os.clock()
	
	local xml = require("XmlParser")
	local xmlTab = xml:ParseXmlText(xmlstr) 
	local nUnitCount = GetArrayElemCount(xmlTab.stage.unit)
	print("stageid="..xmlTab.stage['@id'].."  unitcount="..nUnitCount)

	for nIndex = 1, nUnitCount do
		local oUnit = xmlTab.stage.unit[nIndex]
		local id = oUnit['@id']
		local basetype = oUnit['@basetype']
		local specialtype = oUnit['@specialtype']
		local specialextype = oUnit['@specialextype']
		local elemcount = GetArrayElemCount(oUnit.elem)
		print("id="..id.."  basetype="..basetype.."  specialtype="..specialtype.."  specialextype="..specialextype.."  elemcount="..elemcount)
		for nIdx = 1, elemcount do
			local oElem = oUnit.elem[nIdx] or oUnit.elem
			local elemtype = oElem['@type']
			local layercount = oElem['@layercount']
			local dir = oElem['@dir']
			print("elemtype="..elemtype.."  layercount="..layercount.."  dir="..dir)
		end
	end

	print("total interval:"..os.clock() - tick)
end

MainTest()